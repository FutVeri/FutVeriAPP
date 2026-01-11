"""
Süper Lig Fixtures API Endpoints
Provides fixture data for mobile simulation
"""
from fastapi import APIRouter, HTTPException, Query
from typing import Optional, List

from app.schemas.fixtures import (
    FixtureResponse,
    FixturesListResponse,
    TeamsListResponse,
    TeamInfo,
    SeasonOverview,
    RoundInfo,
)
from app.data.super_lig_fixtures import (
    generate_all_fixtures,
    get_fixtures_by_round,
    get_team_fixtures,
    get_upcoming_fixtures,
    get_current_round,
    get_all_teams,
    get_team_by_id,
    ROUND_DATES,
)

router = APIRouter(prefix="/fixtures", tags=["fixtures"])


@router.get("/", response_model=FixturesListResponse)
async def get_all_fixtures_endpoint(
    round: Optional[int] = Query(None, ge=1, le=34, description="Filter by matchweek (1-34)"),
    team_id: Optional[str] = Query(None, description="Filter by team ID"),
    limit: Optional[int] = Query(None, ge=1, le=306, description="Limit results"),
):
    """
    Get all fixtures for the season.
    
    - **round**: Optional matchweek filter (1-34)
    - **team_id**: Optional team ID filter
    - **limit**: Optional result limit
    """
    if round:
        fixtures = get_fixtures_by_round(round)
    elif team_id:
        fixtures = get_team_fixtures(team_id)
    else:
        fixtures = generate_all_fixtures()
    
    if limit:
        fixtures = fixtures[:limit]
    
    return FixturesListResponse(
        success=True,
        total=len(fixtures),
        round=round,
        fixtures=[FixtureResponse(**f) for f in fixtures]
    )


@router.get("/round/{round_num}", response_model=FixturesListResponse)
async def get_round_fixtures(round_num: int):
    """
    Get all fixtures for a specific matchweek.
    
    - **round_num**: Matchweek number (1-34)
    """
    if round_num < 1 or round_num > 34:
        raise HTTPException(status_code=400, detail="Round must be between 1 and 34")
    
    fixtures = get_fixtures_by_round(round_num)
    
    return FixturesListResponse(
        success=True,
        total=len(fixtures),
        round=round_num,
        fixtures=[FixtureResponse(**f) for f in fixtures]
    )


@router.get("/upcoming", response_model=FixturesListResponse)
async def get_upcoming_fixtures_endpoint(
    limit: int = Query(20, ge=1, le=100, description="Number of upcoming fixtures to return")
):
    """
    Get upcoming fixtures sorted by date.
    
    - **limit**: Number of fixtures to return (default: 20)
    """
    fixtures = get_upcoming_fixtures(limit)
    
    return FixturesListResponse(
        success=True,
        total=len(fixtures),
        fixtures=[FixtureResponse(**f) for f in fixtures]
    )


@router.get("/current-round", response_model=FixturesListResponse)
async def get_current_round_fixtures():
    """
    Get fixtures for the current matchweek.
    """
    current = get_current_round()
    fixtures = get_fixtures_by_round(current)
    
    return FixturesListResponse(
        success=True,
        total=len(fixtures),
        round=current,
        fixtures=[FixtureResponse(**f) for f in fixtures]
    )


@router.get("/team/{team_id}", response_model=FixturesListResponse)
async def get_team_fixtures_endpoint(team_id: str):
    """
    Get all fixtures for a specific team.
    
    - **team_id**: Team ID (e.g., 'gs', 'fb', 'bjk', 'ts')
    """
    team = get_team_by_id(team_id)
    if not team:
        raise HTTPException(status_code=404, detail=f"Team '{team_id}' not found")
    
    fixtures = get_team_fixtures(team_id)
    
    return FixturesListResponse(
        success=True,
        total=len(fixtures),
        fixtures=[FixtureResponse(**f) for f in fixtures]
    )


@router.get("/teams", response_model=TeamsListResponse)
async def get_teams():
    """
    Get all Süper Lig teams.
    """
    teams = get_all_teams()
    
    return TeamsListResponse(
        success=True,
        total=len(teams),
        teams=[TeamInfo(**t) for t in teams]
    )


@router.get("/teams/{team_id}", response_model=TeamInfo)
async def get_team(team_id: str):
    """
    Get team details by ID.
    
    - **team_id**: Team ID (e.g., 'gs', 'fb', 'bjk', 'ts')
    """
    team = get_team_by_id(team_id)
    if not team:
        raise HTTPException(status_code=404, detail=f"Team '{team_id}' not found")
    
    return TeamInfo(**team)


@router.get("/season", response_model=SeasonOverview)
async def get_season_overview():
    """
    Get season overview with all rounds information.
    """
    current = get_current_round()
    all_fixtures = generate_all_fixtures()
    
    rounds = []
    for round_num in range(1, 35):
        dates = ROUND_DATES.get(round_num, {})
        round_fixtures = [f for f in all_fixtures if f["round"] == round_num]
        finished_count = sum(1 for f in round_fixtures if f["is_finished"])
        
        rounds.append(RoundInfo(
            round=round_num,
            start_date=dates.get("start"),
            end_date=dates.get("end"),
            matches_count=len(round_fixtures),
            matches_finished=finished_count
        ))
    
    return SeasonOverview(
        success=True,
        league_name="Trendyol Süper Lig",
        season="2025-2026",
        total_teams=18,
        total_rounds=34,
        total_matches=306,
        current_round=current,
        rounds=rounds
    )


@router.get("/match/{match_id}", response_model=FixtureResponse)
async def get_match(match_id: str):
    """
    Get a specific match by ID.
    
    - **match_id**: Match ID (e.g., 'sl2526_r01_m1')
    """
    all_fixtures = generate_all_fixtures()
    
    for fixture in all_fixtures:
        if fixture["id"] == match_id:
            return FixtureResponse(**fixture)
    
    raise HTTPException(status_code=404, detail=f"Match '{match_id}' not found")
