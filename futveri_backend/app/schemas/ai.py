"""
AI schemas for request/response models.
"""
from typing import Optional
from datetime import datetime
from pydantic import BaseModel, Field


# ============== Request Models ==============

class AIQueryRequest(BaseModel):
    """Natural language query request."""
    query: str = Field(..., min_length=3, max_length=500, description="Türkçe soru")


class PlayerSearchRequest(BaseModel):
    """Player search with filters."""
    position: Optional[str] = Field(None, description="Oyuncu pozisyonu")
    min_age: Optional[int] = Field(None, ge=10, le=50)
    max_age: Optional[int] = Field(None, ge=10, le=50)
    min_rating: Optional[float] = Field(None, ge=1, le=10)
    team: Optional[str] = None
    limit: int = Field(20, ge=1, le=100)


class SimilarPlayersRequest(BaseModel):
    """Similar players request."""
    player_name: str = Field(..., min_length=2)
    count: int = Field(5, ge=1, le=20)


class SemanticSearchRequest(BaseModel):
    """Semantic search request."""
    query: str = Field(..., min_length=3, max_length=300)
    count: int = Field(5, ge=1, le=20)


class TopPlayersRequest(BaseModel):
    """Top players request."""
    metric: str = Field(
        "avg_overall",
        pattern="^(avg_overall|avg_potential|avg_physical|avg_technical|avg_tactical|avg_mental)$"
    )
    count: int = Field(10, ge=1, le=50)


# ============== Response Models ==============

class AIQueryResponse(BaseModel):
    """Natural language query response."""
    answer: str
    sources: list[dict] = []
    success: bool = True
    error: Optional[str] = None


class PlayerAnalyticsResponse(BaseModel):
    """Player analytics data."""
    player_name: str
    player_position: str
    player_team: str
    player_age: int
    
    avg_physical: float
    avg_technical: float
    avg_tactical: float
    avg_mental: float
    avg_overall: float
    avg_potential: float
    
    min_overall: float
    max_overall: float
    total_reports: int
    
    combined_strengths: Optional[str] = None
    combined_weaknesses: Optional[str] = None
    combined_risks: Optional[str] = None
    all_recommended_roles: Optional[str] = None
    
    first_report_date: Optional[datetime] = None
    last_report_date: Optional[datetime] = None


class PlayerSearchResponse(BaseModel):
    """Player search results."""
    players: list[PlayerAnalyticsResponse]
    total: int


class SimilarPlayerItem(BaseModel):
    """Similar player item."""
    player_name: str
    player_position: Optional[str] = None
    player_team: Optional[str] = None
    overall_rating: Optional[float] = None
    similarity: float


class SimilarPlayersResponse(BaseModel):
    """Similar players response."""
    reference_player: str
    similar_players: list[SimilarPlayerItem]


class SemanticSearchItem(BaseModel):
    """Semantic search result item."""
    report_id: str
    player_name: str
    player_position: Optional[str] = None
    player_team: Optional[str] = None
    overall_rating: Optional[float] = None
    similarity: float


class SemanticSearchResponse(BaseModel):
    """Semantic search response."""
    query: str
    results: list[SemanticSearchItem]


class StatisticsResponse(BaseModel):
    """Data lake statistics."""
    total_players: int
    total_reports: int
    average_rating: float
    last_sync: Optional[datetime] = None


class SyncResponse(BaseModel):
    """ETL sync response."""
    reports_synced: int
    players_updated: int
    embeddings_created: int
    summaries_generated: int
    errors: list[str] = []
    success: bool
