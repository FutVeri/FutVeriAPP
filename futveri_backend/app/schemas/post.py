"""
Post schemas for social features.
"""
from datetime import datetime
from typing import Optional

from pydantic import BaseModel, Field


class PostCreate(BaseModel):
    """Post creation schema."""
    report_id: Optional[str] = None  # Optional link to scout report
    player_name: str = Field(..., max_length=100)
    player_info: str = Field(..., max_length=200)
    rating: float = Field(..., ge=1.0, le=10.0)
    comment: str = Field(..., min_length=10, max_length=2000)
    image_urls: list[str] = Field(default_factory=list)
    is_public: bool = True


class PostUpdate(BaseModel):
    """Post update schema."""
    comment: Optional[str] = Field(None, min_length=10, max_length=2000)
    image_urls: Optional[list[str]] = None
    is_public: Optional[bool] = None


class PostResponse(BaseModel):
    """Post response schema."""
    id: str
    scout_id: str
    scout_name: Optional[str] = None  # Populated from join
    scout_avatar: Optional[str] = None
    
    report_id: Optional[str] = None
    player_name: str
    player_info: str
    rating: float
    comment: str
    image_urls: Optional[list[str]] = None
    
    likes_count: int = 0
    comments_count: int = 0
    is_liked: bool = False  # Calculated based on current user
    
    is_public: bool
    created_at: datetime
    updated_at: datetime
    
    class Config:
        from_attributes = True


class PostListResponse(BaseModel):
    """Paginated post list response."""
    items: list[PostResponse]
    total: int
    page: int
    size: int
    pages: int


class CommentCreate(BaseModel):
    """Comment creation schema."""
    content: str = Field(..., min_length=1, max_length=1000)
    parent_id: Optional[str] = None  # For replies


class CommentResponse(BaseModel):
    """Comment response schema."""
    id: str
    post_id: str
    user_id: str
    user_name: Optional[str] = None
    user_avatar: Optional[str] = None
    content: str
    parent_id: Optional[str] = None
    created_at: datetime
    
    class Config:
        from_attributes = True


class CommentListResponse(BaseModel):
    """Comment list response."""
    items: list[CommentResponse]
    total: int
