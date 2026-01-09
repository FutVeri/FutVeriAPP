"""
Trendyol Süper Lig 2025-2026 Fixture Schemas
"""
from pydantic import BaseModel
from typing import Optional, List
from datetime import datetime


class TeamInfo(BaseModel):
    """Basic team information"""
    id: str
    name: str
    short_name: str
    badge_url: str
    stadium: str


class FixtureBase(BaseModel):
    """Single match fixture"""
    id: str
    home_team_id: str
    away_team_id: str
    home_team_name: str
    away_team_name: str
    home_team_badge: str
    away_team_badge: str
    round: int  # Matchweek 1-34
    match_datetime: datetime
    stadium: str
    status: str  # 'scheduled', 'finished', 'postponed', 'live'
    home_score: Optional[int] = None
    away_score: Optional[int] = None


class FixtureResponse(FixtureBase):
    """Fixture response with computed fields"""
    is_finished: bool = False
    is_upcoming: bool = True
    
    class Config:
        from_attributes = True


class FixturesListResponse(BaseModel):
    """Response for fixtures list"""
    success: bool = True
    total: int
    round: Optional[int] = None
    fixtures: List[FixtureResponse]


class TeamsListResponse(BaseModel):
    """Response for teams list"""
    success: bool = True
    total: int
    teams: List[TeamInfo]


class RoundInfo(BaseModel):
    """Information about a matchweek"""
    round: int
    start_date: datetime
    end_date: datetime
    matches_count: int
    matches_finished: int


class SeasonOverview(BaseModel):
    """Season overview response"""
    success: bool = True
    league_name: str = "Trendyol Süper Lig"
    season: str = "2025-2026"
    total_teams: int = 18
    total_rounds: int = 34
    total_matches: int = 306
    current_round: int
    rounds: List[RoundInfo]
