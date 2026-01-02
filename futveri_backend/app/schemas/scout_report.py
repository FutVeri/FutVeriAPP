"""
ScoutReport schemas for CRUD operations and responses.
"""
from datetime import datetime
from typing import Optional

from pydantic import BaseModel, Field


class RatingInput(BaseModel):
    """Rating with description input."""
    rating: int = Field(..., ge=1, le=10)
    description: str = Field(..., min_length=10, max_length=1000)


class ScoutReportCreate(BaseModel):
    """Scout report creation schema."""
    # Player Information
    player_id: Optional[str] = None
    player_name: str = Field(..., min_length=2, max_length=100)
    player_position: str = Field(..., max_length=50)
    player_age: int = Field(..., ge=10, le=50)
    player_team: str = Field(..., max_length=100)
    player_image_url: Optional[str] = Field(None, max_length=500)
    
    # Match Context
    match_date: datetime
    rival_team: str = Field(..., max_length=100)
    score: str = Field(..., max_length=20)
    minute_played: int = Field(..., ge=0, le=120)
    match_type: str = Field(..., max_length=50)  # Stadium, TV, Video
    
    # Ratings
    physical_rating: int = Field(..., ge=1, le=10)
    physical_description: str = Field(..., min_length=10)
    technical_rating: int = Field(..., ge=1, le=10)
    technical_description: str = Field(..., min_length=10)
    tactical_rating: int = Field(..., ge=1, le=10)
    tactical_description: str = Field(..., min_length=10)
    mental_rating: int = Field(..., ge=1, le=10)
    mental_description: str = Field(..., min_length=10)
    
    # Overall
    overall_rating: float = Field(..., ge=1.0, le=10.0)
    potential_rating: float = Field(..., ge=1.0, le=10.0)
    
    # SWOT
    strengths: str = Field(..., min_length=10)
    weaknesses: str = Field(..., min_length=10)
    risks: str = Field(..., min_length=10)
    recommended_role: str = Field(..., max_length=100)
    
    # Additional
    description: Optional[str] = None
    notes: Optional[str] = None
    image_urls: list[str] = Field(default_factory=list)
    
    # Status
    status: str = Field(default="draft", pattern="^(draft|submitted)$")


class ScoutReportUpdate(BaseModel):
    """Scout report update schema."""
    player_name: Optional[str] = Field(None, min_length=2, max_length=100)
    player_position: Optional[str] = Field(None, max_length=50)
    player_age: Optional[int] = Field(None, ge=10, le=50)
    player_team: Optional[str] = Field(None, max_length=100)
    player_image_url: Optional[str] = Field(None, max_length=500)
    
    match_date: Optional[datetime] = None
    rival_team: Optional[str] = Field(None, max_length=100)
    score: Optional[str] = Field(None, max_length=20)
    minute_played: Optional[int] = Field(None, ge=0, le=120)
    match_type: Optional[str] = Field(None, max_length=50)
    
    physical_rating: Optional[int] = Field(None, ge=1, le=10)
    physical_description: Optional[str] = None
    technical_rating: Optional[int] = Field(None, ge=1, le=10)
    technical_description: Optional[str] = None
    tactical_rating: Optional[int] = Field(None, ge=1, le=10)
    tactical_description: Optional[str] = None
    mental_rating: Optional[int] = Field(None, ge=1, le=10)
    mental_description: Optional[str] = None
    
    overall_rating: Optional[float] = Field(None, ge=1.0, le=10.0)
    potential_rating: Optional[float] = Field(None, ge=1.0, le=10.0)
    
    strengths: Optional[str] = None
    weaknesses: Optional[str] = None
    risks: Optional[str] = None
    recommended_role: Optional[str] = Field(None, max_length=100)
    
    description: Optional[str] = None
    notes: Optional[str] = None
    image_urls: Optional[list[str]] = None
    
    status: Optional[str] = Field(None, pattern="^(draft|submitted)$")


class ScoutReportResponse(BaseModel):
    """Scout report response schema."""
    id: str
    
    # Player
    player_id: Optional[str] = None
    player_name: str
    player_position: str
    player_age: int
    player_team: str
    player_image_url: Optional[str] = None
    
    # Match
    match_date: datetime
    rival_team: str
    score: str
    minute_played: int
    match_type: str
    
    # Ratings
    physical_rating: int
    physical_description: str
    technical_rating: int
    technical_description: str
    tactical_rating: int
    tactical_description: str
    mental_rating: int
    mental_description: str
    overall_rating: float
    potential_rating: float
    
    # SWOT
    strengths: str
    weaknesses: str
    risks: str
    recommended_role: str
    
    # Additional
    description: Optional[str] = None
    notes: Optional[str] = None
    image_urls: Optional[list[str]] = None
    
    # Status
    status: str
    rejection_reason: Optional[str] = None
    
    # Meta
    scout_id: str
    scout_name: Optional[str] = None  # Populated from join
    reviewed_by: Optional[str] = None
    reviewed_at: Optional[datetime] = None
    created_at: datetime
    updated_at: datetime
    
    class Config:
        from_attributes = True


class ScoutReportListResponse(BaseModel):
    """Paginated scout report list response."""
    items: list[ScoutReportResponse]
    total: int
    page: int
    size: int
    pages: int


class ReportApproveRequest(BaseModel):
    """Report approval request."""
    pass  # No additional data needed


class ReportRejectRequest(BaseModel):
    """Report rejection request."""
    reason: str = Field(..., min_length=10, max_length=500)


class ReportStatsResponse(BaseModel):
    """Report statistics for dashboard."""
    total_reports: int
    pending_reports: int
    approved_reports: int
    rejected_reports: int
    draft_reports: int
