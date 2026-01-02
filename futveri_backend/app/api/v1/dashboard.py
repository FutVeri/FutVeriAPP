"""
Dashboard endpoints for admin analytics and statistics.
"""
from datetime import datetime, timedelta, timezone
from typing import Optional

from fastapi import APIRouter, Depends, status
from sqlalchemy import func, select
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.dependencies import AdminUser, ClubUser, DBSession
from app.models.scout_report import ScoutReport
from app.models.user import User
from app.schemas.dashboard import (
    ActivityPoint,
    AdminDashboardResponse,
    DashboardStatsResponse,
    PendingItemResponse,
    RecentActivityResponse,
)

router = APIRouter(prefix="/dashboard", tags=["Dashboard"])


@router.get("/stats", response_model=DashboardStatsResponse)
async def get_dashboard_stats(
    db: DBSession,
    admin: AdminUser,
) -> dict:
    """
    Get comprehensive dashboard statistics.
    Admin only.
    """
    now = datetime.now(timezone.utc)
    today_start = now.replace(hour=0, minute=0, second=0, microsecond=0)
    online_threshold = now - timedelta(minutes=15)
    
    # User stats
    total_users_result = await db.execute(select(func.count(User.id)))
    total_users = total_users_result.scalar()
    
    dau_result = await db.execute(
        select(func.count(User.id)).where(User.last_active_at >= today_start)
    )
    daily_active_users = dau_result.scalar()
    
    online_result = await db.execute(
        select(func.count(User.id)).where(User.last_active_at >= online_threshold)
    )
    online_users = online_result.scalar()
    
    scouts_result = await db.execute(
        select(func.count(User.id)).where(User.role == "scout")
    )
    scouts_count = scouts_result.scalar()
    
    clubs_result = await db.execute(
        select(func.count(User.id)).where(User.role == "club")
    )
    clubs_count = clubs_result.scalar()
    
    # Report stats
    total_reports_result = await db.execute(select(func.count(ScoutReport.id)))
    total_reports = total_reports_result.scalar()
    
    pending_result = await db.execute(
        select(func.count(ScoutReport.id)).where(ScoutReport.status == "submitted")
    )
    pending_reports = pending_result.scalar()
    
    approved_result = await db.execute(
        select(func.count(ScoutReport.id)).where(ScoutReport.status == "approved")
    )
    approved_reports = approved_result.scalar()
    
    rejected_result = await db.execute(
        select(func.count(ScoutReport.id)).where(ScoutReport.status == "rejected")
    )
    rejected_reports = rejected_result.scalar()
    
    # Weekly activity (last 7 days)
    weekly_activity = []
    for i in range(7):
        day = today_start - timedelta(days=6-i)
        next_day = day + timedelta(days=1)
        
        users_result = await db.execute(
            select(func.count(User.id)).where(
                User.last_active_at >= day,
                User.last_active_at < next_day,
            )
        )
        users_count = users_result.scalar()
        
        reports_result = await db.execute(
            select(func.count(ScoutReport.id)).where(
                ScoutReport.created_at >= day,
                ScoutReport.created_at < next_day,
            )
        )
        reports_count = reports_result.scalar()
        
        weekly_activity.append({
            "date": day,
            "users": users_count,
            "reports": reports_count,
        })
    
    return {
        "total_users": total_users,
        "daily_active_users": daily_active_users,
        "online_users": online_users,
        "scouts_count": scouts_count,
        "clubs_count": clubs_count,
        "total_reports": total_reports,
        "pending_reports": pending_reports,
        "approved_reports": approved_reports,
        "rejected_reports": rejected_reports,
        "api_response_ms": 50,  # Placeholder, could be calculated
        "db_status": True,
        "weekly_activity": weekly_activity,
    }


@router.get("/pending", response_model=list[PendingItemResponse])
async def get_pending_items(
    db: DBSession,
    admin: AdminUser,
    limit: int = 10,
) -> list[dict]:
    """
    Get pending items that need admin action.
    Admin only.
    """
    # Get pending reports
    query = (
        select(ScoutReport, User)
        .join(User, ScoutReport.scout_id == User.id)
        .where(ScoutReport.status == "submitted")
        .order_by(ScoutReport.created_at.desc())
        .limit(limit)
    )
    
    result = await db.execute(query)
    items = result.all()
    
    pending_items = []
    for report, user in items:
        pending_items.append({
            "id": report.id,
            "type": "report",
            "title": f"{report.player_name} Raporu",
            "subtitle": f"{report.player_position} • {report.player_team}",
            "created_at": report.created_at,
            "author_name": user.name,
            "author_avatar": user.avatar_url,
        })
    
    return pending_items


@router.get("/recent-activity", response_model=list[RecentActivityResponse])
async def get_recent_activity(
    db: DBSession,
    admin: AdminUser,
    limit: int = 20,
) -> list[dict]:
    """
    Get recent activity feed for dashboard.
    Admin only.
    """
    activities = []
    
    # Recent user registrations
    users_query = (
        select(User)
        .order_by(User.created_at.desc())
        .limit(5)
    )
    users_result = await db.execute(users_query)
    recent_users = users_result.scalars().all()
    
    for user in recent_users:
        activities.append({
            "id": f"user_{user.id}",
            "type": "user_registered",
            "title": "Yeni Kullanıcı Kaydı",
            "description": f"{user.name} ({user.role}) kaydoldu",
            "timestamp": user.created_at,
            "user_id": user.id,
            "user_name": user.name,
            "user_avatar": user.avatar_url,
        })
    
    # Recent report submissions
    reports_query = (
        select(ScoutReport, User)
        .join(User, ScoutReport.scout_id == User.id)
        .where(ScoutReport.status.in_(["submitted", "approved", "rejected"]))
        .order_by(ScoutReport.updated_at.desc())
        .limit(10)
    )
    reports_result = await db.execute(reports_query)
    recent_reports = reports_result.all()
    
    for report, user in recent_reports:
        activity_type = f"report_{report.status}"
        if report.status == "submitted":
            title = "Rapor Gönderildi"
            description = f"{user.name} {report.player_name} için rapor gönderdi"
        elif report.status == "approved":
            title = "Rapor Onaylandı"
            description = f"{report.player_name} raporu onaylandı"
        else:
            title = "Rapor Reddedildi"
            description = f"{report.player_name} raporu reddedildi"
        
        activities.append({
            "id": f"report_{report.id}",
            "type": activity_type,
            "title": title,
            "description": description,
            "timestamp": report.updated_at,
            "user_id": user.id,
            "user_name": user.name,
            "user_avatar": user.avatar_url,
        })
    
    # Sort by timestamp and return
    activities.sort(key=lambda x: x["timestamp"], reverse=True)
    return activities[:limit]


@router.get("", response_model=AdminDashboardResponse)
async def get_full_dashboard(
    db: DBSession,
    admin: AdminUser,
) -> dict:
    """
    Get complete admin dashboard data in one call.
    Admin only.
    """
    # Get stats
    stats = await get_dashboard_stats(db, admin)
    
    # Get pending items
    pending_items = await get_pending_items(db, admin, limit=5)
    
    # Get recent activities
    recent_activities = await get_recent_activity(db, admin, limit=10)
    
    return {
        "stats": stats,
        "recent_activities": recent_activities,
        "pending_items": pending_items,
    }
