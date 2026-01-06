"""
AI API endpoints for FutVeri.
Provides natural language queries, player search, and analytics.
"""
from typing import Optional
from datetime import datetime

from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.db.database import get_db
from app.core.dependencies import get_current_user, require_roles
from app.models.user import User
from app.schemas.ai import (
    AIQueryRequest, AIQueryResponse,
    PlayerSearchRequest, PlayerSearchResponse, PlayerAnalyticsResponse,
    SimilarPlayersRequest, SimilarPlayersResponse, SimilarPlayerItem,
    SemanticSearchRequest, SemanticSearchResponse, SemanticSearchItem,
    TopPlayersRequest,
    StatisticsResponse, SyncResponse
)
from app.ai.agent import FutVeriAgent
from app.ai.data_lake import DataLake
from app.ai.vector_store import VectorStore
from app.ai.etl_service import ETLService
from app.ai.summarizer import ReportSummarizer


router = APIRouter(prefix="/ai", tags=["AI"])

# Lazy-loaded singletons
_agent: Optional[FutVeriAgent] = None
_data_lake: Optional[DataLake] = None
_vector_store: Optional[VectorStore] = None


def get_data_lake() -> DataLake:
    """Get or create data lake instance."""
    global _data_lake
    if _data_lake is None:
        _data_lake = DataLake()
    return _data_lake


def get_vector_store() -> VectorStore:
    """Get or create vector store instance."""
    global _vector_store
    if _vector_store is None:
        _vector_store = VectorStore()
    return _vector_store


def get_agent() -> FutVeriAgent:
    """Get or create agent instance."""
    global _agent
    if _agent is None:
        _agent = FutVeriAgent(
            data_lake=get_data_lake(),
            vector_store=get_vector_store()
        )
    return _agent


# ============== Natural Language Query ==============

@router.post("/query", response_model=AIQueryResponse)
async def query_ai(
    request: AIQueryRequest,
    current_user: User = Depends(get_current_user)
):
    """
    Doğal dil sorgusu ile AI'a soru sor.
    
    Örnek sorular:
    - "En yüksek potansiyele sahip oyuncular kim?"
    - "18 yaş altı forvetleri listele"
    - "Ahmet Kaya'ya benzer oyuncular bul"
    """
    agent = get_agent()
    result = agent.query(request.query)
    
    return AIQueryResponse(
        answer=result["answer"],
        sources=result.get("sources", []),
        success=result.get("success", True),
        error=result.get("error")
    )


# ============== Player Search & Analytics ==============

@router.post("/players/search", response_model=PlayerSearchResponse)
async def search_players(
    request: PlayerSearchRequest,
    current_user: User = Depends(get_current_user)
):
    """
    Filtrelerle oyuncu ara.
    Pozisyon, yaş, puan ve takım filtresi kullanılabilir.
    """
    data_lake = get_data_lake()
    players = data_lake.search_players(
        position=request.position,
        min_age=request.min_age,
        max_age=request.max_age,
        min_rating=request.min_rating,
        team=request.team,
        limit=request.limit
    )
    
    return PlayerSearchResponse(
        players=[PlayerAnalyticsResponse(**p) for p in players],
        total=len(players)
    )


@router.get("/players/{player_name}", response_model=PlayerAnalyticsResponse)
async def get_player_analytics(
    player_name: str,
    current_user: User = Depends(get_current_user)
):
    """
    Belirli bir oyuncunun detaylı analizini getir.
    """
    data_lake = get_data_lake()
    player = data_lake.get_player_analytics(player_name)
    
    if not player:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Oyuncu bulunamadı: {player_name}"
        )
    
    return PlayerAnalyticsResponse(**player)


@router.post("/players/top", response_model=PlayerSearchResponse)
async def get_top_players(
    request: TopPlayersRequest,
    current_user: User = Depends(get_current_user)
):
    """
    Belirli bir metriğe göre en iyi oyuncuları listele.
    
    Metrikler: avg_overall, avg_potential, avg_physical, 
    avg_technical, avg_tactical, avg_mental
    """
    data_lake = get_data_lake()
    players = data_lake.get_top_players(
        metric=request.metric,
        limit=request.count
    )
    
    return PlayerSearchResponse(
        players=[PlayerAnalyticsResponse(**p) for p in players],
        total=len(players)
    )


# ============== Similarity & Semantic Search ==============

@router.post("/players/similar", response_model=SimilarPlayersResponse)
async def find_similar_players(
    request: SimilarPlayersRequest,
    current_user: User = Depends(get_current_user)
):
    """
    Bir oyuncuya benzer oyuncuları bul.
    Oyun tarzı ve özellikler bazında benzerlik analizi.
    """
    vector_store = get_vector_store()
    similar = vector_store.find_similar_players(
        player_name=request.player_name,
        n_results=request.count
    )
    
    return SimilarPlayersResponse(
        reference_player=request.player_name,
        similar_players=[SimilarPlayerItem(**p) for p in similar]
    )


@router.post("/search", response_model=SemanticSearchResponse)
async def semantic_search(
    request: SemanticSearchRequest,
    current_user: User = Depends(get_current_user)
):
    """
    Anlam bazlı rapor araması.
    Doğal dil sorguları ile oyuncu ve rapor arar.
    
    Örnek: "hızlı ve teknik kanat oyuncuları"
    """
    vector_store = get_vector_store()
    results = vector_store.search_similar(
        query=request.query,
        n_results=request.count
    )
    
    formatted = []
    for r in results:
        meta = r.get("metadata", {})
        formatted.append(SemanticSearchItem(
            report_id=r["report_id"],
            player_name=meta.get("player_name", "Bilinmeyen"),
            player_position=meta.get("player_position"),
            player_team=meta.get("player_team"),
            overall_rating=meta.get("overall_rating"),
            similarity=r.get("similarity", 0)
        ))
    
    return SemanticSearchResponse(
        query=request.query,
        results=formatted
    )


# ============== Statistics & Sync ==============

@router.get("/statistics", response_model=StatisticsResponse)
async def get_statistics(
    current_user: User = Depends(get_current_user)
):
    """
    Veri havuzu istatistiklerini getir.
    """
    data_lake = get_data_lake()
    stats = data_lake.get_statistics()
    last_sync = data_lake.get_last_sync()
    
    return StatisticsResponse(
        total_players=stats["total_players"],
        total_reports=stats["total_reports"],
        average_rating=stats["average_rating"],
        last_sync=last_sync
    )


@router.post("/sync", response_model=SyncResponse)
async def sync_data(
    full: bool = False,
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(require_roles("admin", "superadmin"))
):
    """
    Supabase'den local veri havuzuna senkronizasyon.
    
    - full=False: Sadece son senkronizasyondan sonra güncellenen raporlar
    - full=True: Tüm raporları yeniden senkronize et
    
    Sadece admin kullanabilir.
    """
    try:
        # Initialize services
        data_lake = get_data_lake()
        vector_store = get_vector_store()
        summarizer = ReportSummarizer()
        
        etl = ETLService(
            data_lake=data_lake,
            vector_store=vector_store,
            summarizer=summarizer
        )
        
        # Run sync
        if full:
            stats = await etl.sync_all(db)
        else:
            stats = await etl.sync_incremental(db)
        
        return SyncResponse(
            reports_synced=stats["reports_synced"],
            players_updated=stats["players_updated"],
            embeddings_created=stats["embeddings_created"],
            summaries_generated=stats["summaries_generated"],
            errors=stats["errors"],
            success=len(stats["errors"]) == 0
        )
        
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Senkronizasyon hatası: {str(e)}"
        )


@router.post("/sync/simple", response_model=SyncResponse)
async def sync_data_simple(
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(require_roles("admin", "superadmin"))
):
    """
    Basit senkronizasyon (özet oluşturmadan).
    Daha hızlı çalışır, Ollama gerekmez.
    """
    try:
        data_lake = get_data_lake()
        vector_store = get_vector_store()
        
        etl = ETLService(
            data_lake=data_lake,
            vector_store=vector_store,
            summarizer=None  # No summarizer = no LLM needed
        )
        
        stats = await etl.sync_all(db)
        
        return SyncResponse(
            reports_synced=stats["reports_synced"],
            players_updated=stats["players_updated"],
            embeddings_created=stats["embeddings_created"],
            summaries_generated=0,
            errors=stats["errors"],
            success=len(stats["errors"]) == 0
        )
        
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Senkronizasyon hatası: {str(e)}"
        )
