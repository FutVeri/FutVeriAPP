"""
User management endpoints.
Admin-only operations for user listing and management.
"""
from datetime import datetime, timedelta, timezone
from math import ceil
from typing import Optional

from fastapi import APIRouter, Depends, HTTPException, Query, status
from sqlalchemy import func, select
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.dependencies import AdminUser, CurrentUser, DBSession, require_roles
from app.models.user import User
from app.schemas.user import (
    UserAdminUpdate,
    UserListResponse,
    UserResponse,
    UserStatsResponse,
    UserUpdate,
)

router = APIRouter(prefix="/users", tags=["Users"])


@router.get("", response_model=UserListResponse)
async def list_users(
    db: DBSession,
    admin: AdminUser,
    page: int = Query(1, ge=1),
    size: int = Query(20, ge=1, le=100),
    role: Optional[str] = Query(None),
    search: Optional[str] = Query(None),
    is_active: Optional[bool] = Query(None),
) -> dict:
    """
    List all users with pagination and filters.
    Admin only.
    """
    query = select(User)
    count_query = select(func.count(User.id))
    
    # Apply filters
    if role:
        query = query.where(User.role == role)
        count_query = count_query.where(User.role == role)
    
    if search:
        search_filter = User.name.ilike(f"%{search}%") | User.email.ilike(f"%{search}%")
        query = query.where(search_filter)
        count_query = count_query.where(search_filter)
    
    if is_active is not None:
        query = query.where(User.is_active == is_active)
        count_query = count_query.where(User.is_active == is_active)
    
    # Get total count
    total_result = await db.execute(count_query)
    total = total_result.scalar()
    
    # Apply pagination
    query = query.offset((page - 1) * size).limit(size)
    query = query.order_by(User.created_at.desc())
    
    result = await db.execute(query)
    users = result.scalars().all()
    
    return {
        "items": users,
        "total": total,
        "page": page,
        "size": size,
        "pages": ceil(total / size) if total > 0 else 1,
    }


@router.get("/stats", response_model=UserStatsResponse)
async def get_user_stats(
    db: DBSession,
    admin: AdminUser,
) -> dict:
    """
    Get user statistics for dashboard.
    Admin only.
    """
    now = datetime.now(timezone.utc)
    today_start = now.replace(hour=0, minute=0, second=0, microsecond=0)
    online_threshold = now - timedelta(minutes=15)
    
    # Total users
    total_result = await db.execute(select(func.count(User.id)))
    total_users = total_result.scalar()
    
    # Daily active users (logged in today)
    dau_result = await db.execute(
        select(func.count(User.id)).where(User.last_active_at >= today_start)
    )
    daily_active_users = dau_result.scalar()
    
    # Online users (active in last 15 minutes)
    online_result = await db.execute(
        select(func.count(User.id)).where(User.last_active_at >= online_threshold)
    )
    online_users = online_result.scalar()
    
    # Role counts
    scouts_result = await db.execute(
        select(func.count(User.id)).where(User.role == "scout")
    )
    scouts_count = scouts_result.scalar()
    
    clubs_result = await db.execute(
        select(func.count(User.id)).where(User.role == "club")
    )
    clubs_count = clubs_result.scalar()
    
    premium_result = await db.execute(
        select(func.count(User.id)).where(User.role == "premium")
    )
    premium_count = premium_result.scalar()
    
    return {
        "total_users": total_users,
        "daily_active_users": daily_active_users,
        "online_users": online_users,
        "scouts_count": scouts_count,
        "clubs_count": clubs_count,
        "premium_count": premium_count,
    }


@router.get("/{user_id}", response_model=UserResponse)
async def get_user(
    user_id: str,
    db: DBSession,
    current_user: CurrentUser,
) -> User:
    """
    Get user by ID.
    Users can view their own profile, admins can view any user.
    """
    if user_id != current_user.id and not current_user.is_admin:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Bu kullanıcıyı görüntüleme yetkiniz yok",
        )
    
    result = await db.execute(select(User).where(User.id == user_id))
    user = result.scalar_one_or_none()
    
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Kullanıcı bulunamadı",
        )
    
    return user


@router.put("/{user_id}", response_model=UserResponse)
async def update_user(
    user_id: str,
    request: UserUpdate,
    db: DBSession,
    current_user: CurrentUser,
) -> User:
    """
    Update user profile.
    Users can update their own profile.
    """
    if user_id != current_user.id:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Sadece kendi profilinizi güncelleyebilirsiniz",
        )
    
    result = await db.execute(select(User).where(User.id == user_id))
    user = result.scalar_one_or_none()
    
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Kullanıcı bulunamadı",
        )
    
    # Update fields
    update_data = request.model_dump(exclude_unset=True)
    for field, value in update_data.items():
        setattr(user, field, value)
    
    await db.commit()
    await db.refresh(user)
    
    return user


@router.put("/{user_id}/admin", response_model=UserResponse)
async def admin_update_user(
    user_id: str,
    request: UserAdminUpdate,
    db: DBSession,
    admin: AdminUser,
) -> User:
    """
    Admin update user (can change role, status).
    Admin only.
    """
    result = await db.execute(select(User).where(User.id == user_id))
    user = result.scalar_one_or_none()
    
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Kullanıcı bulunamadı",
        )
    
    # Prevent demoting superadmin if not superadmin
    if user.role == "superadmin" and admin.role != "superadmin":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Süper admin üzerinde değişiklik yapamazsınız",
        )
    
    # Update fields
    update_data = request.model_dump(exclude_unset=True)
    for field, value in update_data.items():
        setattr(user, field, value)
    
    await db.commit()
    await db.refresh(user)
    
    return user


@router.delete("/{user_id}")
async def delete_user(
    user_id: str,
    db: DBSession,
    admin: AdminUser,
) -> dict:
    """
    Delete user account.
    Admin only. Cannot delete superadmins.
    """
    result = await db.execute(select(User).where(User.id == user_id))
    user = result.scalar_one_or_none()
    
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Kullanıcı bulunamadı",
        )
    
    if user.role == "superadmin":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Süper admin silinemez",
        )
    
    await db.delete(user)
    await db.commit()
    
    return {"message": "Kullanıcı başarıyla silindi"}
