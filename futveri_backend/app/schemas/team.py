"""
Team schemas for CRUD operations and responses.
"""
from datetime import datetime
from typing import Optional

from pydantic import BaseModel, Field


class TeamCreate(BaseModel):
    """Team creation schema."""
    name: str = Field(..., min_length=2, max_length=100)
    short_name: Optional[str] = Field(None, max_length=10)
    logo_url: Optional[str] = Field(None, max_length=500)
    
    city: Optional[str] = Field(None, max_length=100)
    country: str = Field(..., max_length=100)
    stadium: Optional[str] = Field(None, max_length=100)
    
    league: Optional[str] = Field(None, max_length=100)
    league_level: Optional[int] = Field(None, ge=1, le=10)


class TeamUpdate(BaseModel):
    """Team update schema."""
    name: Optional[str] = Field(None, min_length=2, max_length=100)
    short_name: Optional[str] = Field(None, max_length=10)
    logo_url: Optional[str] = Field(None, max_length=500)
    
    city: Optional[str] = Field(None, max_length=100)
    country: Optional[str] = Field(None, max_length=100)
    stadium: Optional[str] = Field(None, max_length=100)
    
    league: Optional[str] = Field(None, max_length=100)
    league_level: Optional[int] = Field(None, ge=1, le=10)


class TeamResponse(BaseModel):
    """Team response schema."""
    id: str
    name: str
    short_name: Optional[str] = None
    logo_url: Optional[str] = None
    
    city: Optional[str] = None
    country: str
    stadium: Optional[str] = None
    
    league: Optional[str] = None
    league_level: Optional[int] = None
    
    created_at: datetime
    updated_at: datetime
    
    class Config:
        from_attributes = True


class TeamListResponse(BaseModel):
    """Paginated team list response."""
    items: list[TeamResponse]
    total: int
    page: int
    size: int
    pages: int
