"""
Posts API endpoints for social feed.
"""
import uuid
from datetime import datetime, timezone
from typing import Optional

from fastapi import APIRouter, Depends, HTTPException, Query, status
from sqlalchemy import select, func, and_, desc
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.core.dependencies import get_current_user, get_db, require_roles
from app.models.post import Post, Comment, Like
from app.models.user import User
from app.schemas.post import (
    CommentCreate,
    CommentListResponse,
    CommentResponse,
    PostCreate,
    PostListResponse,
    PostResponse,
    PostUpdate,
)

router = APIRouter(prefix="/posts", tags=["Posts"])


def _post_to_response(post: Post, current_user_id: str | None = None, is_liked: bool = False) -> PostResponse:
    """Convert Post model to PostResponse."""
    return PostResponse(
        id=post.id,
        scout_id=post.scout_id,
        scout_name=post.scout.name if post.scout else None,
        scout_avatar=post.scout.avatar_url if post.scout else None,
        report_id=post.report_id,
        player_name=post.player_name,
        player_info=post.player_info,
        rating=post.rating,
        comment=post.comment,
        image_urls=post.image_urls or [],
        likes_count=post.likes_count,
        comments_count=post.comments_count,
        is_liked=is_liked,
        is_public=post.is_public,
        created_at=post.created_at,
        updated_at=post.updated_at,
    )


@router.get("", response_model=PostListResponse)
async def list_posts(
    page: int = Query(1, ge=1),
    size: int = Query(20, ge=1, le=100),
    scout_id: Optional[str] = None,
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """
    Get posts feed.
    Shows public posts and user's own posts.
    """
    # Build base query
    query = select(Post).options(selectinload(Post.scout))
    
    # Filter: public posts OR user's own posts
    query = query.where(
        (Post.is_public == True) | (Post.scout_id == current_user.id)
    )
    
    if scout_id:
        query = query.where(Post.scout_id == scout_id)
    
    # Order by newest first
    query = query.order_by(desc(Post.created_at))
    
    # Count total
    count_query = select(func.count()).select_from(query.subquery())
    total_result = await db.execute(count_query)
    total = total_result.scalar() or 0
    
    # Paginate
    offset = (page - 1) * size
    query = query.offset(offset).limit(size)
    
    result = await db.execute(query)
    posts = result.scalars().all()
    
    # Check which posts current user has liked
    if posts:
        post_ids = [p.id for p in posts]
        likes_query = select(Like.post_id).where(
            and_(Like.post_id.in_(post_ids), Like.user_id == current_user.id)
        )
        likes_result = await db.execute(likes_query)
        liked_post_ids = set(likes_result.scalars().all())
    else:
        liked_post_ids = set()
    
    # Convert to response
    items = [
        _post_to_response(post, current_user.id, post.id in liked_post_ids)
        for post in posts
    ]
    
    pages = (total + size - 1) // size
    
    return PostListResponse(
        items=items,
        total=total,
        page=page,
        size=size,
        pages=pages,
    )


@router.post("", response_model=PostResponse, status_code=status.HTTP_201_CREATED)
async def create_post(
    post_data: PostCreate,
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(require_roles("scout", "admin", "superadmin")),
):
    """
    Create a new post.
    Only scouts and admins can create posts.
    """
    post = Post(
        id=str(uuid.uuid4()),
        scout_id=current_user.id,
        report_id=post_data.report_id,
        player_name=post_data.player_name,
        player_info=post_data.player_info,
        rating=post_data.rating,
        comment=post_data.comment,
        image_urls=post_data.image_urls,
        is_public=post_data.is_public,
        likes_count=0,
        comments_count=0,
    )
    
    db.add(post)
    await db.commit()
    await db.refresh(post)
    
    # Load scout relationship
    await db.refresh(post, ["scout"])
    
    return _post_to_response(post, current_user.id)


@router.get("/{post_id}", response_model=PostResponse)
async def get_post(
    post_id: str,
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Get a single post by ID."""
    query = select(Post).options(selectinload(Post.scout)).where(Post.id == post_id)
    result = await db.execute(query)
    post = result.scalar_one_or_none()
    
    if not post:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Post bulunamadı",
        )
    
    # Check access
    if not post.is_public and post.scout_id != current_user.id:
        if current_user.role not in ["admin", "superadmin"]:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Bu posta erişim izniniz yok",
            )
    
    # Check if liked
    like_query = select(Like).where(
        and_(Like.post_id == post_id, Like.user_id == current_user.id)
    )
    like_result = await db.execute(like_query)
    is_liked = like_result.scalar_one_or_none() is not None
    
    return _post_to_response(post, current_user.id, is_liked)


@router.put("/{post_id}", response_model=PostResponse)
async def update_post(
    post_id: str,
    post_data: PostUpdate,
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Update a post. Only the owner can update."""
    query = select(Post).options(selectinload(Post.scout)).where(Post.id == post_id)
    result = await db.execute(query)
    post = result.scalar_one_or_none()
    
    if not post:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Post bulunamadı",
        )
    
    # Check ownership
    if post.scout_id != current_user.id:
        if current_user.role not in ["admin", "superadmin"]:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Bu postu düzenleme izniniz yok",
            )
    
    # Update fields
    update_data = post_data.model_dump(exclude_unset=True)
    for key, value in update_data.items():
        setattr(post, key, value)
    
    post.updated_at = datetime.now(timezone.utc)
    
    await db.commit()
    await db.refresh(post)
    
    return _post_to_response(post, current_user.id)


@router.delete("/{post_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_post(
    post_id: str,
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Delete a post. Only the owner or admin can delete."""
    query = select(Post).where(Post.id == post_id)
    result = await db.execute(query)
    post = result.scalar_one_or_none()
    
    if not post:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Post bulunamadı",
        )
    
    # Check ownership
    if post.scout_id != current_user.id:
        if current_user.role not in ["admin", "superadmin"]:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Bu postu silme izniniz yok",
            )
    
    await db.delete(post)
    await db.commit()


# ============ LIKES ============

@router.post("/{post_id}/like", status_code=status.HTTP_201_CREATED)
async def like_post(
    post_id: str,
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Like a post."""
    # Check post exists
    post_query = select(Post).where(Post.id == post_id)
    post_result = await db.execute(post_query)
    post = post_result.scalar_one_or_none()
    
    if not post:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Post bulunamadı",
        )
    
    # Check if already liked
    like_query = select(Like).where(
        and_(Like.post_id == post_id, Like.user_id == current_user.id)
    )
    like_result = await db.execute(like_query)
    existing_like = like_result.scalar_one_or_none()
    
    if existing_like:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Bu postu zaten beğendiniz",
        )
    
    # Create like
    like = Like(
        id=str(uuid.uuid4()),
        post_id=post_id,
        user_id=current_user.id,
    )
    db.add(like)
    
    # Update likes count
    post.likes_count += 1
    
    await db.commit()
    
    return {"message": "Post beğenildi", "likes_count": post.likes_count}


@router.delete("/{post_id}/like", status_code=status.HTTP_200_OK)
async def unlike_post(
    post_id: str,
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Remove like from a post."""
    # Check post exists
    post_query = select(Post).where(Post.id == post_id)
    post_result = await db.execute(post_query)
    post = post_result.scalar_one_or_none()
    
    if not post:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Post bulunamadı",
        )
    
    # Find like
    like_query = select(Like).where(
        and_(Like.post_id == post_id, Like.user_id == current_user.id)
    )
    like_result = await db.execute(like_query)
    like = like_result.scalar_one_or_none()
    
    if not like:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Bu postu henüz beğenmediniz",
        )
    
    # Delete like
    await db.delete(like)
    
    # Update likes count
    post.likes_count = max(0, post.likes_count - 1)
    
    await db.commit()
    
    return {"message": "Beğeni kaldırıldı", "likes_count": post.likes_count}


# ============ COMMENTS ============

@router.get("/{post_id}/comments", response_model=CommentListResponse)
async def get_comments(
    post_id: str,
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Get comments for a post."""
    # Check post exists
    post_query = select(Post).where(Post.id == post_id)
    post_result = await db.execute(post_query)
    post = post_result.scalar_one_or_none()
    
    if not post:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Post bulunamadı",
        )
    
    # Get comments
    query = (
        select(Comment)
        .options(selectinload(Comment.user))
        .where(Comment.post_id == post_id)
        .order_by(Comment.created_at)
    )
    result = await db.execute(query)
    comments = result.scalars().all()
    
    items = [
        CommentResponse(
            id=c.id,
            post_id=c.post_id,
            user_id=c.user_id,
            user_name=c.user.name if c.user else None,
            user_avatar=c.user.avatar_url if c.user else None,
            content=c.content,
            parent_id=c.parent_id,
            created_at=c.created_at,
        )
        for c in comments
    ]
    
    return CommentListResponse(items=items, total=len(items))


@router.post("/{post_id}/comments", response_model=CommentResponse, status_code=status.HTTP_201_CREATED)
async def create_comment(
    post_id: str,
    comment_data: CommentCreate,
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Add a comment to a post."""
    # Check post exists
    post_query = select(Post).where(Post.id == post_id)
    post_result = await db.execute(post_query)
    post = post_result.scalar_one_or_none()
    
    if not post:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Post bulunamadı",
        )
    
    # If replying, check parent exists
    if comment_data.parent_id:
        parent_query = select(Comment).where(
            and_(Comment.id == comment_data.parent_id, Comment.post_id == post_id)
        )
        parent_result = await db.execute(parent_query)
        parent = parent_result.scalar_one_or_none()
        
        if not parent:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Yanıt verilecek yorum bulunamadı",
            )
    
    # Create comment
    comment = Comment(
        id=str(uuid.uuid4()),
        post_id=post_id,
        user_id=current_user.id,
        content=comment_data.content,
        parent_id=comment_data.parent_id,
    )
    db.add(comment)
    
    # Update comments count
    post.comments_count += 1
    
    await db.commit()
    await db.refresh(comment)
    
    return CommentResponse(
        id=comment.id,
        post_id=comment.post_id,
        user_id=comment.user_id,
        user_name=current_user.name,
        user_avatar=current_user.avatar_url,
        content=comment.content,
        parent_id=comment.parent_id,
        created_at=comment.created_at,
    )


@router.delete("/{post_id}/comments/{comment_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_comment(
    post_id: str,
    comment_id: str,
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Delete a comment. Only the owner or admin can delete."""
    # Find comment
    query = select(Comment).where(
        and_(Comment.id == comment_id, Comment.post_id == post_id)
    )
    result = await db.execute(query)
    comment = result.scalar_one_or_none()
    
    if not comment:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Yorum bulunamadı",
        )
    
    # Check ownership
    if comment.user_id != current_user.id:
        if current_user.role not in ["admin", "superadmin"]:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Bu yorumu silme izniniz yok",
            )
    
    # Update post comments count
    post_query = select(Post).where(Post.id == post_id)
    post_result = await db.execute(post_query)
    post = post_result.scalar_one_or_none()
    
    if post:
        post.comments_count = max(0, post.comments_count - 1)
    
    await db.delete(comment)
    await db.commit()
