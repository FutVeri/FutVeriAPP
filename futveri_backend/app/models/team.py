"""
Team model for football clubs/teams.
"""
from datetime import datetime
from typing import Optional
import uuid

from sqlalchemy import DateTime, String, func
from sqlalchemy.orm import Mapped, mapped_column

from app.db.database import Base


class Team(Base):
    """
    Team/Club model for football teams.
    """
    __tablename__ = "teams"
    
    id: Mapped[str] = mapped_column(
        String(36),
        primary_key=True,
        default=lambda: str(uuid.uuid4()),
    )
    
    # Basic Information
    name: Mapped[str] = mapped_column(
        String(100),
        nullable=False,
        unique=True,
        index=True,
    )
    short_name: Mapped[Optional[str]] = mapped_column(
        String(10),
        nullable=True,
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
    country: Mapped[str] = mapped_column(
        String(100),
        nullable=False,
    )
    stadium: Mapped[Optional[str]] = mapped_column(
        String(100),
        nullable=True,
    )
    
    # League Information
    league: Mapped[Optional[str]] = mapped_column(
        String(100),
        nullable=True,
    )
    league_level: Mapped[Optional[int]] = mapped_column(
        nullable=True,
    )  # 1 = First division, 2 = Second division, etc.
    
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
    
    def __repr__(self) -> str:
        return f"<Team {self.name}>"
