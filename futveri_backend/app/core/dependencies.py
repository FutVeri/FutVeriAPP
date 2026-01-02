"""
Common dependencies for FastAPI endpoints.
Provides authentication, authorization, and database session management.
"""
from typing import Annotated

from fastapi import Depends, HTTPException, status
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.security import decode_token
from app.db.database import get_db
from app.models.user import User
from app.schemas.auth import TokenPayload

# HTTP Bearer token security scheme
security = HTTPBearer()


async def get_current_user(
    credentials: Annotated[HTTPAuthorizationCredentials, Depends(security)],
    db: Annotated[AsyncSession, Depends(get_db)],
) -> User:
    """
    Get the current authenticated user from JWT token.
    
    Args:
        credentials: Bearer token from Authorization header
        db: Database session
    
    Returns:
        User model instance
    
    Raises:
        HTTPException: If token is invalid or user not found
    """
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Geçersiz kimlik bilgileri",
        headers={"WWW-Authenticate": "Bearer"},
    )
    
    token = credentials.credentials
    payload = decode_token(token)
    
    if payload is None:
        raise credentials_exception
    
    # Check token type
    if payload.get("type") != "access":
        raise credentials_exception
    
    user_id: str = payload.get("sub")
    if user_id is None:
        raise credentials_exception
    
    # Get user from database
    from sqlalchemy import select
    result = await db.execute(select(User).where(User.id == user_id))
    user = result.scalar_one_or_none()
    
    if user is None:
        raise credentials_exception
    
    if not user.is_active:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Kullanıcı hesabı devre dışı",
        )
    
    return user


async def get_current_active_user(
    current_user: Annotated[User, Depends(get_current_user)],
) -> User:
    """Get current active user (alias for get_current_user with active check)."""
    return current_user


def require_roles(*allowed_roles: str):
    """
    Dependency factory for role-based authorization.
    
    Args:
        allowed_roles: List of roles that are allowed access
    
    Returns:
        Dependency function that checks user role
    
    Usage:
        @router.get("/admin-only")
        async def admin_endpoint(user: User = Depends(require_roles("admin", "superadmin"))):
            ...
    """
    async def role_checker(
        current_user: Annotated[User, Depends(get_current_user)],
    ) -> User:
        if current_user.role not in allowed_roles:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail=f"Bu işlem için yetkiniz yok. Gerekli rol: {', '.join(allowed_roles)}",
            )
        return current_user
    
    return role_checker


# Common role dependencies
require_admin = require_roles("admin", "superadmin")
require_scout = require_roles("scout", "admin", "superadmin")
require_club = require_roles("club", "admin", "superadmin")
require_premium = require_roles("premium", "scout", "club", "admin", "superadmin")


# Type aliases for cleaner endpoint signatures
CurrentUser = Annotated[User, Depends(get_current_user)]
AdminUser = Annotated[User, Depends(require_admin)]
ScoutUser = Annotated[User, Depends(require_scout)]
ClubUser = Annotated[User, Depends(require_club)]
DBSession = Annotated[AsyncSession, Depends(get_db)]
