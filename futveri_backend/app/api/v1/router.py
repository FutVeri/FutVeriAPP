"""
API v1 router - combines all endpoint routers.
"""
from fastapi import APIRouter

from app.api.v1.auth import router as auth_router
from app.api.v1.dashboard import router as dashboard_router
from app.api.v1.players import router as players_router
from app.api.v1.posts import router as posts_router
from app.api.v1.reports import router as reports_router
from app.api.v1.teams import router as teams_router
from app.api.v1.users import router as users_router
from app.api.v1.ai import router as ai_router
from app.api.v1.fixtures import router as fixtures_router
from app.api.v1.simulation import router as simulation_router

api_router = APIRouter()

# Include all routers
api_router.include_router(auth_router)
api_router.include_router(users_router)
api_router.include_router(reports_router)
api_router.include_router(players_router)
api_router.include_router(teams_router)
api_router.include_router(posts_router)
api_router.include_router(dashboard_router)
api_router.include_router(ai_router)
api_router.include_router(fixtures_router)
api_router.include_router(simulation_router)

