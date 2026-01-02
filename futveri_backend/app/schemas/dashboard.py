"""
Dashboard schemas for admin statistics and analytics.
"""
from datetime import datetime
from typing import Optional

from pydantic import BaseModel


class ActivityPoint(BaseModel):
    """Activity data point for charts."""
    date: datetime
    users: int
    reports: int


class DashboardStatsResponse(BaseModel):
    """Dashboard statistics response."""
    # User stats
    total_users: int
    daily_active_users: int
    online_users: int
    scouts_count: int
    clubs_count: int
    
    # Report stats
    total_reports: int
    pending_reports: int
    approved_reports: int
    rejected_reports: int
    
    # System health
    api_response_ms: int
    db_status: bool
    
    # Weekly activity
    weekly_activity: list[ActivityPoint]


class RecentActivityResponse(BaseModel):
    """Recent activity item for dashboard."""
    id: str
    type: str  # "user_registered", "report_submitted", "report_approved", etc.
    title: str
    description: str
    timestamp: datetime
    user_id: Optional[str] = None
    user_name: Optional[str] = None
    user_avatar: Optional[str] = None


class PendingItemResponse(BaseModel):
    """Pending item for dashboard."""
    id: str
    type: str  # "report"
    title: str
    subtitle: str
    created_at: datetime
    author_name: str
    author_avatar: Optional[str] = None


class AdminDashboardResponse(BaseModel):
    """Complete admin dashboard response."""
    stats: DashboardStatsResponse
    recent_activities: list[RecentActivityResponse]
    pending_items: list[PendingItemResponse]
