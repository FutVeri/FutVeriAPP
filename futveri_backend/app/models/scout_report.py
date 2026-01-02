"""
ScoutReport model for player evaluation reports.
Contains physical, technical, tactical, and mental ratings with SWOT analysis.
"""
from datetime import datetime
from typing import Optional
import uuid

from sqlalchemy import DateTime, Float, ForeignKey, Integer, String, Text, func
from sqlalchemy.dialects.postgresql import ARRAY
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.db.database import Base


class ScoutReport(Base):
    """
    Scout report model for player evaluations.
    
    Status values:
        - draft: Initial state, not submitted
        - submitted: Submitted for review
        - approved: Approved by admin
        - rejected: Rejected by admin
    """
    __tablename__ = "scout_reports"
    
    id: Mapped[str] = mapped_column(
        String(36),
        primary_key=True,
        default=lambda: str(uuid.uuid4()),
    )
    
    # Player Information
    player_id: Mapped[Optional[str]] = mapped_column(
        String(36),
        ForeignKey("players.id", ondelete="SET NULL"),
        nullable=True,
    )
    player_name: Mapped[str] = mapped_column(
        String(100),
        nullable=False,
    )
    player_position: Mapped[str] = mapped_column(
        String(50),
        nullable=False,
    )
    player_age: Mapped[int] = mapped_column(
        Integer,
        nullable=False,
    )
    player_team: Mapped[str] = mapped_column(
        String(100),
        nullable=False,
    )
    player_image_url: Mapped[Optional[str]] = mapped_column(
        String(500),
        nullable=True,
    )
    
    # Match Context
    match_date: Mapped[datetime] = mapped_column(
        DateTime(timezone=True),
        nullable=False,
    )
    rival_team: Mapped[str] = mapped_column(
        String(100),
        nullable=False,
    )
    score: Mapped[str] = mapped_column(
        String(20),
        nullable=False,
    )
    minute_played: Mapped[int] = mapped_column(
        Integer,
        nullable=False,
    )
    match_type: Mapped[str] = mapped_column(
        String(50),
        nullable=False,
    )  # Stadium, TV, Video, etc.
    
    # Physical Rating
    physical_rating: Mapped[int] = mapped_column(
        Integer,
        nullable=False,
    )  # 1-10
    physical_description: Mapped[str] = mapped_column(
        Text,
        nullable=False,
    )
    
    # Technical Rating
    technical_rating: Mapped[int] = mapped_column(
        Integer,
        nullable=False,
    )  # 1-10
    technical_description: Mapped[str] = mapped_column(
        Text,
        nullable=False,
    )
    
    # Tactical Rating
    tactical_rating: Mapped[int] = mapped_column(
        Integer,
        nullable=False,
    )  # 1-10
    tactical_description: Mapped[str] = mapped_column(
        Text,
        nullable=False,
    )
    
    # Mental Rating
    mental_rating: Mapped[int] = mapped_column(
        Integer,
        nullable=False,
    )  # 1-10
    mental_description: Mapped[str] = mapped_column(
        Text,
        nullable=False,
    )
    
    # Overall Ratings
    overall_rating: Mapped[float] = mapped_column(
        Float,
        nullable=False,
    )  # Calculated average
    potential_rating: Mapped[float] = mapped_column(
        Float,
        nullable=False,
    )  # Scout's potential assessment
    
    # SWOT Analysis
    strengths: Mapped[str] = mapped_column(
        Text,
        nullable=False,
    )
    weaknesses: Mapped[str] = mapped_column(
        Text,
        nullable=False,
    )
    risks: Mapped[str] = mapped_column(
        Text,
        nullable=False,
    )
    recommended_role: Mapped[str] = mapped_column(
        String(100),
        nullable=False,
    )
    
    # Additional Information
    description: Mapped[Optional[str]] = mapped_column(
        Text,
        nullable=True,
    )
    notes: Mapped[Optional[str]] = mapped_column(
        Text,
        nullable=True,
    )
    image_urls: Mapped[Optional[list]] = mapped_column(
        ARRAY(String(500)),
        nullable=True,
        default=list,
    )
    
    # Status & Meta
    status: Mapped[str] = mapped_column(
        String(20),
        default="draft",
        nullable=False,
    )  # draft, submitted, approved, rejected
    
    scout_id: Mapped[str] = mapped_column(
        String(36),
        ForeignKey("users.id", ondelete="CASCADE"),
        nullable=False,
    )
    
    # Admin who approved/rejected
    reviewed_by: Mapped[Optional[str]] = mapped_column(
        String(36),
        ForeignKey("users.id", ondelete="SET NULL"),
        nullable=True,
    )
    reviewed_at: Mapped[Optional[datetime]] = mapped_column(
        DateTime(timezone=True),
        nullable=True,
    )
    rejection_reason: Mapped[Optional[str]] = mapped_column(
        Text,
        nullable=True,
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
    scout = relationship("User", foreign_keys=[scout_id], backref="reports")
    player = relationship("Player", backref="reports")
    reviewer = relationship("User", foreign_keys=[reviewed_by])
    
    def __repr__(self) -> str:
        return f"<ScoutReport {self.player_name} by {self.scout_id}>"
    
    @property
    def is_editable(self) -> bool:
        """Check if report can be edited."""
        return self.status in ("draft", "rejected")
    
    @property
    def average_rating(self) -> float:
        """Calculate average of all ratings."""
        return (
            self.physical_rating +
            self.technical_rating +
            self.tactical_rating +
            self.mental_rating
        ) / 4.0
