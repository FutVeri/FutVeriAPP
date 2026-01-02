"""
Player endpoints for CRUD operations.
"""
from math import ceil
from typing import Optional

from fastapi import APIRouter, Depends, HTTPException, Query, status
from sqlalchemy import func, select
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.dependencies import AdminUser, CurrentUser, DBSession, ScoutUser
from app.models.player import Player
from app.schemas.player import (
    PlayerCreate,
    PlayerListResponse,
    PlayerResponse,
    PlayerUpdate,
)

router = APIRouter(prefix="/players", tags=["Players"])


@router.get("", response_model=PlayerListResponse)
async def list_players(
    db: DBSession,
    current_user: CurrentUser,
    page: int = Query(1, ge=1),
    size: int = Query(20, ge=1, le=100),
    search: Optional[str] = Query(None),
    position: Optional[str] = Query(None),
    nationality: Optional[str] = Query(None),
    club: Optional[str] = Query(None),
    min_age: Optional[int] = Query(None),
    max_age: Optional[int] = Query(None),
) -> dict:
    """
    List players with pagination and filters.
    """
    query = select(Player)
    count_query = select(func.count(Player.id))
    
    # Apply filters
    if search:
        query = query.where(Player.name.ilike(f"%{search}%"))
        count_query = count_query.where(Player.name.ilike(f"%{search}%"))
    
    if position:
        query = query.where(Player.position == position)
        count_query = count_query.where(Player.position == position)
    
    if nationality:
        query = query.where(Player.nationality.ilike(f"%{nationality}%"))
        count_query = count_query.where(Player.nationality.ilike(f"%{nationality}%"))
    
    if club:
        query = query.where(Player.current_club.ilike(f"%{club}%"))
        count_query = count_query.where(Player.current_club.ilike(f"%{club}%"))
    
    if min_age:
        query = query.where(Player.age >= min_age)
        count_query = count_query.where(Player.age >= min_age)
    
    if max_age:
        query = query.where(Player.age <= max_age)
        count_query = count_query.where(Player.age <= max_age)
    
    # Get total count
    total_result = await db.execute(count_query)
    total = total_result.scalar()
    
    # Apply pagination
    query = query.offset((page - 1) * size).limit(size)
    query = query.order_by(Player.name.asc())
    
    result = await db.execute(query)
    players = result.scalars().all()
    
    return {
        "items": players,
        "total": total,
        "page": page,
        "size": size,
        "pages": ceil(total / size) if total > 0 else 1,
    }


@router.post("", response_model=PlayerResponse, status_code=status.HTTP_201_CREATED)
async def create_player(
    request: PlayerCreate,
    db: DBSession,
    current_user: ScoutUser,  # Scouts and admins can create
) -> Player:
    """
    Create a new player.
    Scout or admin only.
    """
    player = Player(**request.model_dump())
    
    db.add(player)
    await db.commit()
    await db.refresh(player)
    
    return player


@router.get("/{player_id}", response_model=PlayerResponse)
async def get_player(
    player_id: str,
    db: DBSession,
    current_user: CurrentUser,
) -> Player:
    """
    Get player by ID.
    """
    result = await db.execute(select(Player).where(Player.id == player_id))
    player = result.scalar_one_or_none()
    
    if not player:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Oyuncu bulunamadı",
        )
    
    return player


@router.put("/{player_id}", response_model=PlayerResponse)
async def update_player(
    player_id: str,
    request: PlayerUpdate,
    db: DBSession,
    admin: AdminUser,
) -> Player:
    """
    Update player information.
    Admin only.
    """
    result = await db.execute(select(Player).where(Player.id == player_id))
    player = result.scalar_one_or_none()
    
    if not player:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Oyuncu bulunamadı",
        )
    
    # Update fields
    update_data = request.model_dump(exclude_unset=True)
    for field, value in update_data.items():
        setattr(player, field, value)
    
    await db.commit()
    await db.refresh(player)
    
    return player


@router.delete("/{player_id}")
async def delete_player(
    player_id: str,
    db: DBSession,
    admin: AdminUser,
) -> dict:
    """
    Delete player.
    Admin only.
    """
    result = await db.execute(select(Player).where(Player.id == player_id))
    player = result.scalar_one_or_none()
    
    if not player:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Oyuncu bulunamadı",
        )
    
    await db.delete(player)
    await db.commit()
    
    return {"message": "Oyuncu başarıyla silindi"}
