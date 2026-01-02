"""
Club model for registered club accounts (customers).
Different from Team - this is for club accounts that use the platform.
"""
from datetime import datetime
from typing import Optional
import uuid

from sqlalchemy import Boolean, DateTime, ForeignKey, String, func
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.db.database import Base


class Club(Base):
    """
    Club model for customer club accounts.
    These are clubs that register to view scout reports.
    """
    __tablename__ = "clubs"
    
    id: Mapped[str] = mapped_column(
        String(36),
        primary_key=True,
        default=lambda: str(uuid.uuid4()),
    )
    
    # Link to user account
    user_id: Mapped[str] = mapped_column(
        String(36),
        ForeignKey("users.id", ondelete="CASCADE"),
        unique=True,
        nullable=False,
    )
    
    # Club Information
    name: Mapped[str] = mapped_column(
        String(100),
        nullable=False,
    )
    logo_url: Mapped[Optional[str]] = mapped_column(
        String(500),
        nullable=True,
    )
    
    # Location
    city: Mapped[Optional[str]] = mapped_column(
        String(100),
        nullable=True,
    )
    country: Mapped[Optional[str]] = mapped_column(
        String(100),
        nullable=True,
    )
    
    # League
    league: Mapped[Optional[str]] = mapped_column(
        String(100),
        nullable=True,
    )
    
    # Subscription (for future use)
    subscription_tier: Mapped[str] = mapped_column(
        String(20),
        default="free",
        nullable=False,
    )  # free, basic, premium, enterprise
    subscription_expires_at: Mapped[Optional[datetime]] = mapped_column(
        DateTime(timezone=True),
        nullable=True,
    )
    
    # Limits
    max_scouts: Mapped[int] = mapped_column(
        default=5,
        nullable=False,
    )
    max_reports_per_month: Mapped[int] = mapped_column(
        default=50,
        nullable=False,
    )
    
    # Status
    is_verified: Mapped[bool] = mapped_column(
        Boolean,
        default=False,
        nullable=False,
    )
    
    # Timestamps
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True),
        server_default=func.now(),
        nullable=False,
    )
    updated_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True),
        server_default=func.now(),
        onupdate=func.now(),
        nullable=False,
    )
    
    # Relationships
    user = relationship("User", backref="club_profile")
    
    def __repr__(self) -> str:
        return f"<Club {self.name}>"
