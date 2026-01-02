"""
User model for authentication and authorization.
Supports multiple roles: user, scout, premium, club, admin, superadmin.
"""
from datetime import datetime
from typing import Optional
import uuid

from sqlalchemy import Boolean, DateTime, String, func
from sqlalchemy.orm import Mapped, mapped_column

from app.db.database import Base


class User(Base):
    """
    User model representing all user types in the system.
    
    Roles:
        - user: Regular user (read-only access)
        - scout: Can create reports
        - premium: Premium user features
        - club: Club account (can view scout reports)
        - admin: Full admin access
        - superadmin: Super admin (can manage admins)
    """
    __tablename__ = "users"
    
    id: Mapped[str] = mapped_column(
        String(36),
        primary_key=True,
        default=lambda: str(uuid.uuid4()),
    )
    
    # Authentication
    email: Mapped[str] = mapped_column(
        String(255),
        unique=True,
        index=True,
        nullable=False,
    )
    hashed_password: Mapped[str] = mapped_column(
        String(255),
        nullable=False,
    )
    
    # Profile
    name: Mapped[str] = mapped_column(
        String(100),
        nullable=False,
    )
    avatar_url: Mapped[Optional[str]] = mapped_column(
        String(500),
        nullable=True,
    )
    
    # Role & Status
    role: Mapped[str] = mapped_column(
        String(20),
        default="user",
        nullable=False,
    )
    is_active: Mapped[bool] = mapped_column(
        Boolean,
        default=True,
        nullable=False,
    )
    is_verified: Mapped[bool] = mapped_column(
        Boolean,
        default=False,
        nullable=False,
    )
    
    # Scout specific fields
    region: Mapped[Optional[str]] = mapped_column(
        String(100),
        nullable=True,
    )
    
    # Club specific fields
    club_name: Mapped[Optional[str]] = mapped_column(
        String(100),
        nullable=True,
    )
    club_logo_url: Mapped[Optional[str]] = mapped_column(
        String(500),
        nullable=True,
    )
    city: Mapped[Optional[str]] = mapped_column(
        String(100),
        nullable=True,
    )
    country: Mapped[Optional[str]] = mapped_column(
        String(100),
        nullable=True,
    )
    league: Mapped[Optional[str]] = mapped_column(
        String(100),
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
    last_active_at: Mapped[Optional[datetime]] = mapped_column(
        DateTime(timezone=True),
        nullable=True,
    )
    
    def __repr__(self) -> str:
        return f"<User {self.email} ({self.role})>"
    
    @property
    def is_admin(self) -> bool:
        """Check if user has admin privileges."""
        return self.role in ("admin", "superadmin")
    
    @property
    def is_scout(self) -> bool:
        """Check if user is a scout."""
        return self.role == "scout" or self.is_admin
    
    @property
    def is_club(self) -> bool:
        """Check if user is a club account."""
        return self.role == "club" or self.is_admin
