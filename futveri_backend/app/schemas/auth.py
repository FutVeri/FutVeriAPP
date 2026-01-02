"""
Authentication schemas for login, registration, and tokens.
"""
from datetime import datetime
from typing import Optional

from pydantic import BaseModel, EmailStr, Field


class TokenResponse(BaseModel):
    """JWT token response."""
    access_token: str
    refresh_token: str
    token_type: str = "bearer"


class TokenPayload(BaseModel):
    """JWT token payload."""
    sub: str  # User ID
    role: str
    exp: datetime
    type: str  # "access" or "refresh"


class LoginRequest(BaseModel):
    """Login request body."""
    email: EmailStr
    password: str = Field(..., min_length=6)


class RegisterRequest(BaseModel):
    """User registration request."""
    email: EmailStr
    password: str = Field(..., min_length=6)
    name: str = Field(..., min_length=2, max_length=100)
    role: str = Field(default="user", pattern="^(user|scout)$")
    
    # Scout specific (optional)
    region: Optional[str] = Field(None, max_length=100)


class RegisterClubRequest(BaseModel):
    """Club registration request."""
    email: EmailStr
    password: str = Field(..., min_length=6)
    name: str = Field(..., min_length=2, max_length=100)  # Contact person name
    
    # Club details
    club_name: str = Field(..., min_length=2, max_length=100)
    city: Optional[str] = Field(None, max_length=100)
    country: Optional[str] = Field(None, max_length=100)
    league: Optional[str] = Field(None, max_length=100)


class RefreshTokenRequest(BaseModel):
    """Refresh token request."""
    refresh_token: str


class ChangePasswordRequest(BaseModel):
    """Password change request."""
    current_password: str
    new_password: str = Field(..., min_length=6)
