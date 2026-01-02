"""
Player model for footballer information.
"""
from datetime import datetime
from typing import Optional
import uuid

from sqlalchemy import DateTime, Float, ForeignKey, Integer, String, func
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.db.database import Base


class Player(Base):
    """
    Player model for footballer profiles.
    """
    __tablename__ = "players"
    
    id: Mapped[str] = mapped_column(
        String(36),
        primary_key=True,
        default=lambda: str(uuid.uuid4()),
    )
    
    # Basic Information
    name: Mapped[str] = mapped_column(
        String(100),
        nullable=False,
        index=True,
    )
    image_url: Mapped[Optional[str]] = mapped_column(
        String(500),
        nullable=True,
    )
    age: Mapped[int] = mapped_column(
        Integer,
        nullable=False,
    )
    date_of_birth: Mapped[Optional[datetime]] = mapped_column(
        DateTime(timezone=True),
        nullable=True,
    )
    nationality: Mapped[str] = mapped_column(
        String(100),
        nullable=False,
    )
    
    # Position & Role
    position: Mapped[str] = mapped_column(
        String(50),
        nullable=False,
    )
    preferred_foot: Mapped[Optional[str]] = mapped_column(
        String(10),
        nullable=True,
    )  # Left, Right, Both
    
    # Club Information
    current_club: Mapped[str] = mapped_column(
        String(100),
        nullable=False,
    )
    current_club_id: Mapped[Optional[str]] = mapped_column(
        String(36),
        ForeignKey("teams.id", ondelete="SET NULL"),
        nullable=True,
    )
    contract_until: Mapped[Optional[datetime]] = mapped_column(
        DateTime(timezone=True),
        nullable=True,
    )
    
    # Market Information
    market_value: Mapped[Optional[float]] = mapped_column(
        Float,
        nullable=True,
    )  # In EUR
    
    # Statistics (calculated from reports)
    reports_count: Mapped[int] = mapped_column(
        Integer,
        default=0,
        nullable=False,
    )
    average_rating: Mapped[Optional[float]] = mapped_column(
        Float,
        nullable=True,
    )
    
    # Physical attributes
    height: Mapped[Optional[int]] = mapped_column(
        Integer,
        nullable=True,
    )  # In cm
    weight: Mapped[Optional[int]] = mapped_column(
        Integer,
        nullable=True,
    )  # In kg
    
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
    current_team = relationship("Team", backref="players")
    
    def __repr__(self) -> str:
        return f"<Player {self.name} ({self.position})>"
