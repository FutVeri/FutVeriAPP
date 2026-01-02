"""
Scout report endpoints for CRUD and approval operations.
"""
from datetime import datetime, timezone
from math import ceil
from typing import Optional

from fastapi import APIRouter, Depends, HTTPException, Query, status
from sqlalchemy import func, or_, select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import joinedload

from app.core.dependencies import AdminUser, CurrentUser, DBSession, ScoutUser
from app.models.scout_report import ScoutReport
from app.models.user import User
from app.schemas.scout_report import (
    ReportApproveRequest,
    ReportRejectRequest,
    ReportStatsResponse,
    ScoutReportCreate,
    ScoutReportListResponse,
    ScoutReportResponse,
    ScoutReportUpdate,
)

router = APIRouter(prefix="/reports", tags=["Scout Reports"])


@router.get("", response_model=ScoutReportListResponse)
async def list_reports(
    db: DBSession,
    current_user: CurrentUser,
    page: int = Query(1, ge=1),
    size: int = Query(20, ge=1, le=100),
    status_filter: Optional[str] = Query(None, alias="status"),
    scout_id: Optional[str] = Query(None),
    player_name: Optional[str] = Query(None),
    my_reports: bool = Query(False),
) -> dict:
    """
    List scout reports with pagination and filters.
    
    - Regular users: See approved reports only
    - Scouts: See all reports + their own drafts
    - Clubs: See approved reports
    - Admins: See all reports
    """
    query = select(ScoutReport).options(joinedload(ScoutReport.scout))
    count_query = select(func.count(ScoutReport.id))
    
    # Role-based access control
    if current_user.is_admin:
        # Admins see everything
        pass
    elif current_user.role == "scout":
        # Scouts see approved reports + their own
        query = query.where(
            or_(
                ScoutReport.status == "approved",
                ScoutReport.scout_id == current_user.id,
            )
        )
        count_query = count_query.where(
            or_(
                ScoutReport.status == "approved",
                ScoutReport.scout_id == current_user.id,
            )
        )
    else:
        # Regular users and clubs see only approved
        query = query.where(ScoutReport.status == "approved")
        count_query = count_query.where(ScoutReport.status == "approved")
    
    # Apply filters
    if my_reports and current_user.role == "scout":
        query = query.where(ScoutReport.scout_id == current_user.id)
        count_query = count_query.where(ScoutReport.scout_id == current_user.id)
    
    if status_filter and current_user.is_admin:
        query = query.where(ScoutReport.status == status_filter)
        count_query = count_query.where(ScoutReport.status == status_filter)
    
    if scout_id and current_user.is_admin:
        query = query.where(ScoutReport.scout_id == scout_id)
        count_query = count_query.where(ScoutReport.scout_id == scout_id)
    
    if player_name:
        query = query.where(ScoutReport.player_name.ilike(f"%{player_name}%"))
        count_query = count_query.where(ScoutReport.player_name.ilike(f"%{player_name}%"))
    
    # Get total count
    total_result = await db.execute(count_query)
    total = total_result.scalar()
    
    # Apply pagination
    query = query.offset((page - 1) * size).limit(size)
    query = query.order_by(ScoutReport.created_at.desc())
    
    result = await db.execute(query)
    reports = result.scalars().unique().all()
    
    # Add scout_name to response
    response_items = []
    for report in reports:
        report_dict = {
            **{c.name: getattr(report, c.name) for c in report.__table__.columns},
            "scout_name": report.scout.name if report.scout else None,
        }
        response_items.append(report_dict)
    
    return {
        "items": response_items,
        "total": total,
        "page": page,
        "size": size,
        "pages": ceil(total / size) if total > 0 else 1,
    }


@router.get("/stats", response_model=ReportStatsResponse)
async def get_report_stats(
    db: DBSession,
    admin: AdminUser,
) -> dict:
    """
    Get report statistics for dashboard.
    Admin only.
    """
    # Total reports
    total_result = await db.execute(select(func.count(ScoutReport.id)))
    total_reports = total_result.scalar()
    
    # By status
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
    
    draft_result = await db.execute(
        select(func.count(ScoutReport.id)).where(ScoutReport.status == "draft")
    )
    draft_reports = draft_result.scalar()
    
    return {
        "total_reports": total_reports,
        "pending_reports": pending_reports,
        "approved_reports": approved_reports,
        "rejected_reports": rejected_reports,
        "draft_reports": draft_reports,
    }


@router.post("", response_model=ScoutReportResponse, status_code=status.HTTP_201_CREATED)
async def create_report(
    request: ScoutReportCreate,
    db: DBSession,
    current_user: ScoutUser,
) -> ScoutReport:
    """
    Create a new scout report.
    Scout only.
    """
    report = ScoutReport(
        **request.model_dump(),
        scout_id=current_user.id,
    )
    
    db.add(report)
    await db.commit()
    await db.refresh(report)
    
    return report


@router.get("/{report_id}", response_model=ScoutReportResponse)
async def get_report(
    report_id: str,
    db: DBSession,
    current_user: CurrentUser,
) -> dict:
    """
    Get report by ID.
    """
    query = select(ScoutReport).options(joinedload(ScoutReport.scout)).where(ScoutReport.id == report_id)
    result = await db.execute(query)
    report = result.scalar_one_or_none()
    
    if not report:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Rapor bulunamadı",
        )
    
    # Access control
    if not current_user.is_admin:
        if report.status != "approved" and report.scout_id != current_user.id:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Bu raporu görüntüleme yetkiniz yok",
            )
    
    # Build response with scout_name
    report_dict = {
        **{c.name: getattr(report, c.name) for c in report.__table__.columns},
        "scout_name": report.scout.name if report.scout else None,
    }
    
    return report_dict


@router.put("/{report_id}", response_model=ScoutReportResponse)
async def update_report(
    report_id: str,
    request: ScoutReportUpdate,
    db: DBSession,
    current_user: CurrentUser,
) -> ScoutReport:
    """
    Update a scout report.
    Only owner can update, and only if draft or rejected.
    """
    result = await db.execute(select(ScoutReport).where(ScoutReport.id == report_id))
    report = result.scalar_one_or_none()
    
    if not report:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Rapor bulunamadı",
        )
    
    # Check ownership
    if report.scout_id != current_user.id and not current_user.is_admin:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Bu raporu düzenleme yetkiniz yok",
        )
    
    # Check if editable
    if not report.is_editable and not current_user.is_admin:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Bu rapor düzenlenemez (onay bekliyor veya onaylanmış)",
        )
    
    # Update fields
    update_data = request.model_dump(exclude_unset=True)
    for field, value in update_data.items():
        setattr(report, field, value)
    
    await db.commit()
    await db.refresh(report)
    
    return report


@router.delete("/{report_id}")
async def delete_report(
    report_id: str,
    db: DBSession,
    current_user: CurrentUser,
) -> dict:
    """
    Delete a scout report.
    Owner can delete drafts, admins can delete any.
    """
    result = await db.execute(select(ScoutReport).where(ScoutReport.id == report_id))
    report = result.scalar_one_or_none()
    
    if not report:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Rapor bulunamadı",
        )
    
    # Check permissions
    if current_user.is_admin:
        pass  # Admins can delete any
    elif report.scout_id == current_user.id:
        if report.status not in ("draft", "rejected"):
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Sadece taslak veya reddedilmiş raporlar silinebilir",
            )
    else:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Bu raporu silme yetkiniz yok",
        )
    
    await db.delete(report)
    await db.commit()
    
    return {"message": "Rapor başarıyla silindi"}


@router.post("/{report_id}/submit")
async def submit_report(
    report_id: str,
    db: DBSession,
    current_user: ScoutUser,
) -> dict:
    """
    Submit a draft report for approval.
    Scout only, owner only.
    """
    result = await db.execute(select(ScoutReport).where(ScoutReport.id == report_id))
    report = result.scalar_one_or_none()
    
    if not report:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Rapor bulunamadı",
        )
    
    if report.scout_id != current_user.id:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Sadece kendi raporlarınızı gönderebilirsiniz",
        )
    
    if report.status != "draft":
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Sadece taslak raporlar gönderilebilir",
        )
    
    report.status = "submitted"
    await db.commit()
    
    return {"message": "Rapor onay için gönderildi"}


@router.post("/{report_id}/approve")
async def approve_report(
    report_id: str,
    db: DBSession,
    admin: AdminUser,
) -> dict:
    """
    Approve a submitted report.
    Admin only.
    """
    result = await db.execute(select(ScoutReport).where(ScoutReport.id == report_id))
    report = result.scalar_one_or_none()
    
    if not report:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Rapor bulunamadı",
        )
    
    if report.status != "submitted":
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Sadece gönderilmiş raporlar onaylanabilir",
        )
    
    report.status = "approved"
    report.reviewed_by = admin.id
    report.reviewed_at = datetime.now(timezone.utc)
    
    await db.commit()
    
    return {"message": "Rapor onaylandı"}


@router.post("/{report_id}/reject")
async def reject_report(
    report_id: str,
    request: ReportRejectRequest,
    db: DBSession,
    admin: AdminUser,
) -> dict:
    """
    Reject a submitted report with reason.
    Admin only.
    """
    result = await db.execute(select(ScoutReport).where(ScoutReport.id == report_id))
    report = result.scalar_one_or_none()
    
    if not report:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Rapor bulunamadı",
        )
    
    if report.status != "submitted":
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Sadece gönderilmiş raporlar reddedilebilir",
        )
    
    report.status = "rejected"
    report.reviewed_by = admin.id
    report.reviewed_at = datetime.now(timezone.utc)
    report.rejection_reason = request.reason
    
    await db.commit()
    
    return {"message": "Rapor reddedildi"}
