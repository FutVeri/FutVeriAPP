"""
Player schemas for CRUD operations and responses.
"""
from datetime import datetime
from typing import Optional

from pydantic import BaseModel, Field


class PlayerCreate(BaseModel):
    """Player creation schema."""
    name: str = Field(..., min_length=2, max_length=100)
    image_url: Optional[str] = Field(None, max_length=500)
    age: int = Field(..., ge=10, le=50)
    date_of_birth: Optional[datetime] = None
    nationality: str = Field(..., max_length=100)
    
    position: str = Field(..., max_length=50)
    preferred_foot: Optional[str] = Field(None, pattern="^(Left|Right|Both)$")
    
    current_club: str = Field(..., max_length=100)
    current_club_id: Optional[str] = None
    contract_until: Optional[datetime] = None
    
    market_value: Optional[float] = Field(None, ge=0)
    height: Optional[int] = Field(None, ge=100, le=250)  # cm
    weight: Optional[int] = Field(None, ge=40, le=150)   # kg


class PlayerUpdate(BaseModel):
    """Player update schema."""
    name: Optional[str] = Field(None, min_length=2, max_length=100)
    image_url: Optional[str] = Field(None, max_length=500)
    age: Optional[int] = Field(None, ge=10, le=50)
    date_of_birth: Optional[datetime] = None
    nationality: Optional[str] = Field(None, max_length=100)
    
    position: Optional[str] = Field(None, max_length=50)
    preferred_foot: Optional[str] = Field(None, pattern="^(Left|Right|Both)$")
    
    current_club: Optional[str] = Field(None, max_length=100)
    current_club_id: Optional[str] = None
    contract_until: Optional[datetime] = None
    
    market_value: Optional[float] = Field(None, ge=0)
    height: Optional[int] = Field(None, ge=100, le=250)
    weight: Optional[int] = Field(None, ge=40, le=150)


class PlayerResponse(BaseModel):
    """Player response schema."""
    id: str
    name: str
    image_url: Optional[str] = None
    age: int
    date_of_birth: Optional[datetime] = None
    nationality: str
    
    position: str
    preferred_foot: Optional[str] = None
    
    current_club: str
    current_club_id: Optional[str] = None
    contract_until: Optional[datetime] = None
    
    market_value: Optional[float] = None
    height: Optional[int] = None
    weight: Optional[int] = None
    
    # Statistics
    reports_count: int = 0
    average_rating: Optional[float] = None
    
    created_at: datetime
    updated_at: datetime
    
    class Config:
        from_attributes = True


class PlayerListResponse(BaseModel):
    """Paginated player list response."""
    items: list[PlayerResponse]
    total: int
    page: int
    size: int
    pages: int


class PlayerSearchParams(BaseModel):
    """Player search parameters."""
    name: Optional[str] = None
    position: Optional[str] = None
    nationality: Optional[str] = None
    club: Optional[str] = None
    min_age: Optional[int] = Field(None, ge=10)
    max_age: Optional[int] = Field(None, le=50)
    min_rating: Optional[float] = Field(None, ge=1.0)
