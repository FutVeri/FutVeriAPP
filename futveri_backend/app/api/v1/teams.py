"""
Team endpoints for CRUD operations.
"""
from math import ceil
from typing import Optional

from fastapi import APIRouter, Depends, HTTPException, Query, status
from sqlalchemy import func, select
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.dependencies import AdminUser, CurrentUser, DBSession
from app.models.team import Team
from app.schemas.team import (
    TeamCreate,
    TeamListResponse,
    TeamResponse,
    TeamUpdate,
)

router = APIRouter(prefix="/teams", tags=["Teams"])


@router.get("", response_model=TeamListResponse)
async def list_teams(
    db: DBSession,
    current_user: CurrentUser,
    page: int = Query(1, ge=1),
    size: int = Query(20, ge=1, le=100),
    search: Optional[str] = Query(None),
    country: Optional[str] = Query(None),
    league: Optional[str] = Query(None),
) -> dict:
    """
    List teams with pagination and filters.
    """
    query = select(Team)
    count_query = select(func.count(Team.id))
    
    # Apply filters
    if search:
        query = query.where(Team.name.ilike(f"%{search}%"))
        count_query = count_query.where(Team.name.ilike(f"%{search}%"))
    
    if country:
        query = query.where(Team.country.ilike(f"%{country}%"))
        count_query = count_query.where(Team.country.ilike(f"%{country}%"))
    
    if league:
        query = query.where(Team.league.ilike(f"%{league}%"))
        count_query = count_query.where(Team.league.ilike(f"%{league}%"))
    
    # Get total count
    total_result = await db.execute(count_query)
    total = total_result.scalar()
    
    # Apply pagination
    query = query.offset((page - 1) * size).limit(size)
    query = query.order_by(Team.name.asc())
    
    result = await db.execute(query)
    teams = result.scalars().all()
    
    return {
        "items": teams,
        "total": total,
        "page": page,
        "size": size,
        "pages": ceil(total / size) if total > 0 else 1,
    }


@router.post("", response_model=TeamResponse, status_code=status.HTTP_201_CREATED)
async def create_team(
    request: TeamCreate,
    db: DBSession,
    admin: AdminUser,
) -> Team:
    """
    Create a new team.
    Admin only.
    """
    # Check if team name already exists
    existing = await db.execute(
        select(Team).where(Team.name == request.name)
    )
    if existing.scalar_one_or_none():
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Bu isimde bir takım zaten mevcut",
        )
    
    team = Team(**request.model_dump())
    
    db.add(team)
    await db.commit()
    await db.refresh(team)
    
    return team


@router.get("/{team_id}", response_model=TeamResponse)
async def get_team(
    team_id: str,
    db: DBSession,
    current_user: CurrentUser,
) -> Team:
    """
    Get team by ID.
    """
    result = await db.execute(select(Team).where(Team.id == team_id))
    team = result.scalar_one_or_none()
    
    if not team:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Takım bulunamadı",
        )
    
    return team


@router.put("/{team_id}", response_model=TeamResponse)
async def update_team(
    team_id: str,
    request: TeamUpdate,
    db: DBSession,
    admin: AdminUser,
) -> Team:
    """
    Update team information.
    Admin only.
    """
    result = await db.execute(select(Team).where(Team.id == team_id))
    team = result.scalar_one_or_none()
    
    if not team:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Takım bulunamadı",
        )
    
    # Check for name conflict
    if request.name and request.name != team.name:
        existing = await db.execute(
            select(Team).where(Team.name == request.name)
        )
        if existing.scalar_one_or_none():
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Bu isimde bir takım zaten mevcut",
            )
    
    # Update fields
    update_data = request.model_dump(exclude_unset=True)
    for field, value in update_data.items():
        setattr(team, field, value)
    
    await db.commit()
    await db.refresh(team)
    
    return team


@router.delete("/{team_id}")
async def delete_team(
    team_id: str,
    db: DBSession,
    admin: AdminUser,
) -> dict:
    """
    Delete team.
    Admin only.
    """
    result = await db.execute(select(Team).where(Team.id == team_id))
    team = result.scalar_one_or_none()
    
    if not team:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Takım bulunamadı",
        )
    
    await db.delete(team)
    await db.commit()
    
    return {"message": "Takım başarıyla silindi"}
