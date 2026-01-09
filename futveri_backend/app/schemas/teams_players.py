"""
Teams and Players Schemas for Simulation API
"""
from pydantic import BaseModel
from typing import Optional, List, Dict


class PlayerAttributes(BaseModel):
    """Player attribute ratings (1-99 scale)"""
    pace: int
    stamina: int
    strength: int
    shooting: int
    passing: int
    dribbling: int
    defending: int
    vision: int
    composure: int
    reflexes: int = 0  # GK only
    positioning_gk: int = 0  # GK only


class PlayerInfo(BaseModel):
    """Player information for simulation"""
    id: str
    name: str
    position: str
    number: int
    nationality: str
    age: int
    overall: int
    attributes: PlayerAttributes
    is_key_player: bool = False
    market_value: float = 0.0
    image_url: str = ""


class TeamColors(BaseModel):
    """Team colors"""
    primary: str
    secondary: str


class TeamInfo(BaseModel):
    """Basic team info without players"""
    id: str
    name: str
    short_name: str
    badge_url: str
    stadium: str
    stadium_capacity: Optional[int] = None
    coach: Optional[str] = None
    colors: Optional[TeamColors] = None
    overall_rating: int
    attack_rating: int
    midfield_rating: int
    defense_rating: int
    form: List[str] = []


class TeamWithPlayers(TeamInfo):
    """Full team info with player list"""
    players: List[PlayerInfo] = []


class TeamStrengthAnalysis(BaseModel):
    """Team strength analysis for simulation"""
    team_id: str
    average_overall: float
    average_pace: float
    average_shooting: float
    average_passing: float
    average_defending: float
    star_players: int
    squad_depth: int
    total_market_value: float


class TeamsListResponse(BaseModel):
    """Response for teams list"""
    success: bool = True
    total: int
    teams: List[TeamInfo]


class TeamDetailResponse(BaseModel):
    """Response for single team with players"""
    success: bool = True
    team: TeamWithPlayers


class PlayersListResponse(BaseModel):
    """Response for players list"""
    success: bool = True
    total: int
    team_id: Optional[str] = None
    players: List[PlayerInfo]


class PlayerDetailResponse(BaseModel):
    """Response for single player"""
    success: bool = True
    player: PlayerInfo


class MatchupPreview(BaseModel):
    """Head-to-head matchup preview for simulation"""
    home_team: TeamInfo
    away_team: TeamInfo
    home_strength: TeamStrengthAnalysis
    away_strength: TeamStrengthAnalysis
    home_key_players: List[PlayerInfo]
    away_key_players: List[PlayerInfo]
    prediction: Dict[str, float]  # home_win, draw, away_win probabilities


class MatchupPreviewResponse(BaseModel):
    """Response for matchup preview"""
    success: bool = True
    matchup: MatchupPreview
