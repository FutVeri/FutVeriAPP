"""
Post model for social features (feed, likes, comments).
"""
from datetime import datetime
from typing import Optional
import uuid

from sqlalchemy import Boolean, DateTime, Float, ForeignKey, Integer, String, Text, func
from sqlalchemy.dialects.postgresql import ARRAY
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.db.database import Base


class Post(Base):
    """
    Post model for social feed.
    Posts are created from scout reports when shared publicly.
    """
    __tablename__ = "posts"
    
    id: Mapped[str] = mapped_column(
        String(36),
        primary_key=True,
        default=lambda: str(uuid.uuid4()),
    )
    
    # Author
    scout_id: Mapped[str] = mapped_column(
        String(36),
        ForeignKey("users.id", ondelete="CASCADE"),
        nullable=False,
    )
    
    # Linked report (optional - post can be standalone)
    report_id: Mapped[Optional[str]] = mapped_column(
        String(36),
        ForeignKey("scout_reports.id", ondelete="SET NULL"),
        nullable=True,
    )
    
    # Content
    player_name: Mapped[str] = mapped_column(
        String(100),
        nullable=False,
    )
    player_info: Mapped[str] = mapped_column(
        String(200),
        nullable=False,
    )  # e.g., "18 yaş • Orta Saha • Galatasaray"
    rating: Mapped[float] = mapped_column(
        Float,
        nullable=False,
    )
    comment: Mapped[str] = mapped_column(
        Text,
        nullable=False,
    )
    image_urls: Mapped[Optional[list]] = mapped_column(
        ARRAY(String(500)),
        nullable=True,
        default=list,
    )
    
    # Engagement counts (denormalized for performance)
    likes_count: Mapped[int] = mapped_column(
        Integer,
        default=0,
        nullable=False,
    )
    comments_count: Mapped[int] = mapped_column(
        Integer,
        default=0,
        nullable=False,
    )
    
    # Visibility
    is_public: Mapped[bool] = mapped_column(
        Boolean,
        default=True,
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
    scout = relationship("User", backref="posts")
    report = relationship("ScoutReport", backref="post")
    
    def __repr__(self) -> str:
        return f"<Post {self.id[:8]} by {self.scout_id[:8]}>"


class Comment(Base):
    """
    Comment model for post comments.
    """
    __tablename__ = "comments"
    
    id: Mapped[str] = mapped_column(
        String(36),
        primary_key=True,
        default=lambda: str(uuid.uuid4()),
    )
    
    # Relations
    post_id: Mapped[str] = mapped_column(
        String(36),
        ForeignKey("posts.id", ondelete="CASCADE"),
        nullable=False,
    )
    user_id: Mapped[str] = mapped_column(
        String(36),
        ForeignKey("users.id", ondelete="CASCADE"),
        nullable=False,
    )
    
    # Content
    content: Mapped[str] = mapped_column(
        Text,
        nullable=False,
    )
    
    # Reply to another comment
    parent_id: Mapped[Optional[str]] = mapped_column(
        String(36),
        ForeignKey("comments.id", ondelete="CASCADE"),
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
    post = relationship("Post", backref="comments")
    user = relationship("User", backref="comments")
    replies = relationship("Comment", backref="parent", remote_side=[id])
    
    def __repr__(self) -> str:
        return f"<Comment {self.id[:8]} on {self.post_id[:8]}>"


class Like(Base):
    """
    Like model for post likes.
    """
    __tablename__ = "likes"
    
    id: Mapped[str] = mapped_column(
        String(36),
        primary_key=True,
        default=lambda: str(uuid.uuid4()),
    )
    
    # Relations
    post_id: Mapped[str] = mapped_column(
        String(36),
        ForeignKey("posts.id", ondelete="CASCADE"),
        nullable=False,
    )
    user_id: Mapped[str] = mapped_column(
        String(36),
        ForeignKey("users.id", ondelete="CASCADE"),
        nullable=False,
    )
    
    # Timestamps
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True),
        server_default=func.now(),
        nullable=False,
    )
    
    # Relationships
    post = relationship("Post", backref="likes")
    user = relationship("User", backref="likes")
    
    def __repr__(self) -> str:
        return f"<Like {self.user_id[:8]} -> {self.post_id[:8]}>"
