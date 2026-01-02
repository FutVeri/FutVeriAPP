"""
User schemas for CRUD operations and responses.
"""
from datetime import datetime
from typing import Optional

from pydantic import BaseModel, EmailStr, Field


class UserBase(BaseModel):
    """Base user fields."""
    email: EmailStr
    name: str = Field(..., min_length=2, max_length=100)


class UserCreate(UserBase):
    """User creation schema (internal use)."""
    password: str = Field(..., min_length=6)
    role: str = "user"


class UserUpdate(BaseModel):
    """User update schema."""
    name: Optional[str] = Field(None, min_length=2, max_length=100)
    avatar_url: Optional[str] = Field(None, max_length=500)
    region: Optional[str] = Field(None, max_length=100)
    
    # Club fields
    club_name: Optional[str] = Field(None, max_length=100)
    city: Optional[str] = Field(None, max_length=100)
    country: Optional[str] = Field(None, max_length=100)
    league: Optional[str] = Field(None, max_length=100)


class UserResponse(BaseModel):
    """User response schema."""
    id: str
    email: EmailStr
    name: str
    avatar_url: Optional[str] = None
    role: str
    is_active: bool
    is_verified: bool
    
    # Scout specific
    region: Optional[str] = None
    
    # Club specific
    club_name: Optional[str] = None
    club_logo_url: Optional[str] = None
    city: Optional[str] = None
    country: Optional[str] = None
    league: Optional[str] = None
    
    # Timestamps
    created_at: datetime
    last_active_at: Optional[datetime] = None
    
    class Config:
        from_attributes = True


class UserListResponse(BaseModel):
    """Paginated user list response."""
    items: list[UserResponse]
    total: int
    page: int
    size: int
    pages: int


class UserAdminUpdate(BaseModel):
    """Admin user update schema (can change role, status)."""
    name: Optional[str] = Field(None, min_length=2, max_length=100)
    role: Optional[str] = Field(None, pattern="^(user|scout|premium|club|admin)$")
    is_active: Optional[bool] = None
    is_verified: Optional[bool] = None


class UserStatsResponse(BaseModel):
    """User statistics for dashboard."""
    total_users: int
    daily_active_users: int
    online_users: int
    scouts_count: int
    clubs_count: int
    premium_count: int
