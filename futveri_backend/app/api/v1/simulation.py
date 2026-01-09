"""
Simulation API Endpoints
Teams, Players, and Match Analysis for Mobile Simulation
"""
from fastapi import APIRouter, HTTPException, Query
from typing import Optional, List

from app.schemas.teams_players import (
    TeamInfo,
    TeamWithPlayers,
    PlayerInfo,
    PlayerAttributes,
    TeamColors,
    TeamStrengthAnalysis,
    TeamsListResponse,
    TeamDetailResponse,
    PlayersListResponse,
    PlayerDetailResponse,
    MatchupPreview,
    MatchupPreviewResponse,
)
from app.data.super_lig_teams_players import BIG4_TEAMS
from app.data.super_lig_anadolu_teams import ANADOLU_PART1
from app.data.super_lig_anadolu_teams_part2 import ANADOLU_PART2

router = APIRouter(prefix="/simulation", tags=["simulation"])


def get_all_teams_combined():
    """Combine Big 4 and all Anadolu teams"""
    return {**BIG4_TEAMS, **ANADOLU_PART1, **ANADOLU_PART2}


def convert_team_to_schema(team_data: dict, include_players: bool = False):
    """Convert raw team data to schema"""
    colors = team_data.get("colors")
    team_colors = TeamColors(**colors) if colors else None
    
    base_info = TeamInfo(
        id=team_data["id"],
        name=team_data["name"],
        short_name=team_data["short_name"],
        badge_url=team_data["badge_url"],
        stadium=team_data["stadium"],
        stadium_capacity=team_data.get("stadium_capacity"),
        coach=team_data.get("coach"),
        colors=team_colors,
        overall_rating=team_data.get("overall_rating", 70),
        attack_rating=team_data.get("attack_rating", 70),
        midfield_rating=team_data.get("midfield_rating", 70),
        defense_rating=team_data.get("defense_rating", 70),
        form=team_data.get("form", []),
    )
    
    if include_players:
        players = []
        for p in team_data.get("players", []):
            players.append(PlayerInfo(
                id=p["id"],
                name=p["name"],
                position=p["position"],
                number=p["number"],
                nationality=p["nationality"],
                age=p["age"],
                overall=p["overall"],
                attributes=PlayerAttributes(**p["attributes"]),
                is_key_player=p.get("is_key_player", False),
                market_value=p.get("market_value", 0),
                image_url=p.get("image_url", ""),
            ))
        return TeamWithPlayers(**base_info.dict(), players=players)
    
    return base_info


# =============================================================================
# TEAMS ENDPOINTS
# =============================================================================

@router.get("/teams", response_model=TeamsListResponse)
async def get_all_teams(
    category: Optional[str] = Query(None, description="Filter: 'big4' or 'anadolu'")
):
    """
    Get all teams for simulation.
    
    - **category**: Optional filter ('big4' for GS/FB/BJK/TS, 'anadolu' for others)
    """
    if category == "big4":
        teams_data = TEAMS_DATA
    elif category == "anadolu":
        teams_data = ANADOLU_TEAMS_DATA
    else:
        teams_data = get_all_teams_combined()
    
    teams = [convert_team_to_schema(t) for t in teams_data.values()]
    teams.sort(key=lambda x: x.overall_rating, reverse=True)
    
    return TeamsListResponse(success=True, total=len(teams), teams=teams)


@router.get("/teams/{team_id}", response_model=TeamDetailResponse)
async def get_team_details(team_id: str):
    """
    Get team details with full player list.
    
    - **team_id**: Team ID (e.g., 'gs', 'fb', 'bjk', 'ts')
    """
    all_teams = get_all_teams_combined()
    team_data = all_teams.get(team_id)
    
    if not team_data:
        raise HTTPException(status_code=404, detail=f"Team '{team_id}' not found")
    
    team = convert_team_to_schema(team_data, include_players=True)
    
    return TeamDetailResponse(success=True, team=team)


@router.get("/teams/{team_id}/strength", response_model=TeamStrengthAnalysis)
async def get_team_strength(team_id: str):
    """
    Get team strength analysis for simulation.
    """
    all_teams = get_all_teams_combined()
    team_data = all_teams.get(team_id)
    
    if not team_data:
        raise HTTPException(status_code=404, detail=f"Team '{team_id}' not found")
    
    players = team_data.get("players", [])
    if not players:
        raise HTTPException(status_code=404, detail=f"No players found for team '{team_id}'")
    
    # Calculate averages
    avg_overall = sum(p["overall"] for p in players) / len(players)
    avg_pace = sum(p["attributes"]["pace"] for p in players) / len(players)
    avg_shooting = sum(p["attributes"]["shooting"] for p in players) / len(players)
    avg_passing = sum(p["attributes"]["passing"] for p in players) / len(players)
    avg_defending = sum(p["attributes"]["defending"] for p in players) / len(players)
    
    return TeamStrengthAnalysis(
        team_id=team_id,
        average_overall=round(avg_overall, 1),
        average_pace=round(avg_pace, 1),
        average_shooting=round(avg_shooting, 1),
        average_passing=round(avg_passing, 1),
        average_defending=round(avg_defending, 1),
        star_players=len([p for p in players if p["overall"] >= 80]),
        squad_depth=len(players),
        total_market_value=round(sum(p.get("market_value", 0) for p in players), 1),
    )


@router.get("/teams/{team_id}/key-players", response_model=PlayersListResponse)
async def get_key_players(team_id: str):
    """
    Get key players for a team.
    """
    all_teams = get_all_teams_combined()
    team_data = all_teams.get(team_id)
    
    if not team_data:
        raise HTTPException(status_code=404, detail=f"Team '{team_id}' not found")
    
    key_players = [
        PlayerInfo(
            id=p["id"],
            name=p["name"],
            position=p["position"],
            number=p["number"],
            nationality=p["nationality"],
            age=p["age"],
            overall=p["overall"],
            attributes=PlayerAttributes(**p["attributes"]),
            is_key_player=True,
            market_value=p.get("market_value", 0),
            image_url=p.get("image_url", ""),
        )
        for p in team_data.get("players", []) if p.get("is_key_player")
    ]
    
    return PlayersListResponse(
        success=True,
        total=len(key_players),
        team_id=team_id,
        players=key_players
    )


# =============================================================================
# PLAYERS ENDPOINTS
# =============================================================================

@router.get("/players", response_model=PlayersListResponse)
async def get_all_players(
    team_id: Optional[str] = Query(None, description="Filter by team ID"),
    position: Optional[str] = Query(None, description="Filter by position (GK, CB, RB, LB, CDM, CM, CAM, RM, LM, RW, LW, ST)"),
    min_overall: Optional[int] = Query(None, ge=1, le=99),
    max_overall: Optional[int] = Query(None, ge=1, le=99),
    limit: Optional[int] = Query(50, ge=1, le=500),
):
    """
    Get players with optional filters.
    """
    all_teams = get_all_teams_combined()
    
    all_players = []
    for tid, team_data in all_teams.items():
        if team_id and tid != team_id:
            continue
        for p in team_data.get("players", []):
            all_players.append({**p, "team_id": tid})
    
    # Apply filters
    if position:
        all_players = [p for p in all_players if p["position"].upper() == position.upper()]
    if min_overall:
        all_players = [p for p in all_players if p["overall"] >= min_overall]
    if max_overall:
        all_players = [p for p in all_players if p["overall"] <= max_overall]
    
    # Sort by overall rating
    all_players.sort(key=lambda x: x["overall"], reverse=True)
    all_players = all_players[:limit]
    
    players = [
        PlayerInfo(
            id=p["id"],
            name=p["name"],
            position=p["position"],
            number=p["number"],
            nationality=p["nationality"],
            age=p["age"],
            overall=p["overall"],
            attributes=PlayerAttributes(**p["attributes"]),
            is_key_player=p.get("is_key_player", False),
            market_value=p.get("market_value", 0),
            image_url=p.get("image_url", ""),
        )
        for p in all_players
    ]
    
    return PlayersListResponse(
        success=True,
        total=len(players),
        team_id=team_id,
        players=players
    )


@router.get("/players/{player_id}", response_model=PlayerDetailResponse)
async def get_player_details(player_id: str):
    """
    Get player details by ID.
    """
    all_teams = get_all_teams_combined()
    
    for team_data in all_teams.values():
        for p in team_data.get("players", []):
            if p["id"] == player_id:
                player = PlayerInfo(
                    id=p["id"],
                    name=p["name"],
                    position=p["position"],
                    number=p["number"],
                    nationality=p["nationality"],
                    age=p["age"],
                    overall=p["overall"],
                    attributes=PlayerAttributes(**p["attributes"]),
                    is_key_player=p.get("is_key_player", False),
                    market_value=p.get("market_value", 0),
                    image_url=p.get("image_url", ""),
                )
                return PlayerDetailResponse(success=True, player=player)
    
    raise HTTPException(status_code=404, detail=f"Player '{player_id}' not found")


# =============================================================================
# MATCHUP ANALYSIS
# =============================================================================

@router.get("/matchup/{home_team_id}/{away_team_id}", response_model=MatchupPreviewResponse)
async def get_matchup_preview(home_team_id: str, away_team_id: str):
    """
    Get matchup preview with team comparison and prediction.
    """
    all_teams = get_all_teams_combined()
    
    home_data = all_teams.get(home_team_id)
    away_data = all_teams.get(away_team_id)
    
    if not home_data:
        raise HTTPException(status_code=404, detail=f"Home team '{home_team_id}' not found")
    if not away_data:
        raise HTTPException(status_code=404, detail=f"Away team '{away_team_id}' not found")
    
    home_team = convert_team_to_schema(home_data)
    away_team = convert_team_to_schema(away_data)
    
    # Calculate strengths
    home_players = home_data.get("players", [])
    away_players = away_data.get("players", [])
    
    def calc_strength(players, team_id):
        if not players:
            return TeamStrengthAnalysis(
                team_id=team_id, average_overall=70, average_pace=70,
                average_shooting=70, average_passing=70, average_defending=70,
                star_players=0, squad_depth=0, total_market_value=0
            )
        return TeamStrengthAnalysis(
            team_id=team_id,
            average_overall=round(sum(p["overall"] for p in players) / len(players), 1),
            average_pace=round(sum(p["attributes"]["pace"] for p in players) / len(players), 1),
            average_shooting=round(sum(p["attributes"]["shooting"] for p in players) / len(players), 1),
            average_passing=round(sum(p["attributes"]["passing"] for p in players) / len(players), 1),
            average_defending=round(sum(p["attributes"]["defending"] for p in players) / len(players), 1),
            star_players=len([p for p in players if p["overall"] >= 80]),
            squad_depth=len(players),
            total_market_value=round(sum(p.get("market_value", 0) for p in players), 1),
        )
    
    home_strength = calc_strength(home_players, home_team_id)
    away_strength = calc_strength(away_players, away_team_id)
    
    # Get key players
    home_key = [
        PlayerInfo(
            id=p["id"], name=p["name"], position=p["position"], number=p["number"],
            nationality=p["nationality"], age=p["age"], overall=p["overall"],
            attributes=PlayerAttributes(**p["attributes"]), is_key_player=True,
            market_value=p.get("market_value", 0), image_url=p.get("image_url", ""),
        )
        for p in home_players if p.get("is_key_player")
    ]
    away_key = [
        PlayerInfo(
            id=p["id"], name=p["name"], position=p["position"], number=p["number"],
            nationality=p["nationality"], age=p["age"], overall=p["overall"],
            attributes=PlayerAttributes(**p["attributes"]), is_key_player=True,
            market_value=p.get("market_value", 0), image_url=p.get("image_url", ""),
        )
        for p in away_players if p.get("is_key_player")
    ]
    
    # Calculate prediction
    rating_diff = home_data.get("overall_rating", 70) - away_data.get("overall_rating", 70)
    home_advantage = 5.0
    
    home_win = 35 + (rating_diff + home_advantage) * 2
    draw = 25 - abs(rating_diff) * 0.5
    home_win = max(10, min(80, home_win))
    draw = max(15, min(35, draw))
    away_win = 100 - home_win - draw
    away_win = max(10, min(80, away_win))
    
    # Normalize
    total = home_win + draw + away_win
    prediction = {
        "home_win": round((home_win / total) * 100, 1),
        "draw": round((draw / total) * 100, 1),
        "away_win": round((away_win / total) * 100, 1),
    }
    
    matchup = MatchupPreview(
        home_team=home_team,
        away_team=away_team,
        home_strength=home_strength,
        away_strength=away_strength,
        home_key_players=home_key,
        away_key_players=away_key,
        prediction=prediction,
    )
    
    return MatchupPreviewResponse(success=True, matchup=matchup)
