"""
LangChain Tools for FutVeri AI Agent.
Provides structured tools for player search, comparison, and analysis.
"""
from typing import Optional, Any
from pydantic import BaseModel, Field, ConfigDict

from langchain_core.tools import tool

from app.ai.data_lake import DataLake
from app.ai.vector_store import VectorStore


# Global instances (set by create_tools)
_data_lake: Optional[DataLake] = None
_vector_store: Optional[VectorStore] = None


# ============== Tool Functions ==============

@tool
def search_players(
    position: Optional[str] = None,
    min_age: Optional[int] = None,
    max_age: Optional[int] = None,
    min_rating: Optional[float] = None,
    team: Optional[str] = None,
    limit: int = 10
) -> str:
    """Oyuncuları filtrelerle arar. 
    Pozisyon, yaş aralığı, minimum puan ve takım filtresi kullanabilirsin.
    Örnek: 18 yaş altı forvetleri bul, 7+ puana sahip orta saha oyuncuları"""
    global _data_lake
    if _data_lake is None:
        return "Veri havuzu başlatılmamış."
    
    results = _data_lake.search_players(
        position=position,
        min_age=min_age,
        max_age=max_age,
        min_rating=min_rating,
        team=team,
        limit=limit
    )
    
    if not results:
        return "Kriterlere uygun oyuncu bulunamadı."
    
    output = f"Bulunan {len(results)} oyuncu:\n\n"
    for p in results:
        output += f"• {p['player_name']} ({p['player_position']}, {p['player_age']} yaş)\n"
        output += f"  Takım: {p['player_team']}\n"
        output += f"  Puan: {p['avg_overall']:.1f}/10 | Potansiyel: {p['avg_potential']:.1f}/10\n"
        output += f"  Rapor Sayısı: {p['total_reports']}\n\n"
    
    return output


@tool
def get_player_info(player_name: str) -> str:
    """Belirli bir oyuncunun detaylı bilgilerini getirir.
    Ortalama puanlar, güçlü/zayıf yönler ve rapor istatistiklerini içerir."""
    global _data_lake
    if _data_lake is None:
        return "Veri havuzu başlatılmamış."
    
    player = _data_lake.get_player_analytics(player_name)
    
    if not player:
        return f"'{player_name}' adlı oyuncu bulunamadı."
    
    output = f"📊 {player['player_name']} Detaylı Analiz\n"
    output += f"{'='*40}\n\n"
    output += f"Pozisyon: {player['player_position']}\n"
    output += f"Yaş: {player['player_age']}\n"
    output += f"Takım: {player['player_team']}\n\n"
    
    output += "PUANLAR:\n"
    output += f"• Fiziksel: {player['avg_physical']:.1f}/10\n"
    output += f"• Teknik: {player['avg_technical']:.1f}/10\n"
    output += f"• Taktik: {player['avg_tactical']:.1f}/10\n"
    output += f"• Mental: {player['avg_mental']:.1f}/10\n"
    output += f"• Genel: {player['avg_overall']:.1f}/10\n"
    output += f"• Potansiyel: {player['avg_potential']:.1f}/10\n\n"
    
    output += "SWOT ANALİZİ:\n"
    strengths = player.get('combined_strengths', '')[:300] if player.get('combined_strengths') else 'N/A'
    weaknesses = player.get('combined_weaknesses', '')[:300] if player.get('combined_weaknesses') else 'N/A'
    risks = player.get('combined_risks', '')[:200] if player.get('combined_risks') else 'N/A'
    roles = player.get('all_recommended_roles', 'N/A')
    
    output += f"✅ Güçlü Yönler: {strengths}\n"
    output += f"⚠️ Zayıf Yönler: {weaknesses}\n"
    output += f"🚨 Riskler: {risks}\n"
    output += f"🎯 Önerilen Roller: {roles}\n\n"
    
    output += f"📈 Toplam Rapor: {player['total_reports']}\n"
    
    return output


@tool
def find_similar_players(player_name: str, count: int = 5) -> str:
    """Bir oyuncuya benzer oyuncuları bulur.
    Oyun tarzı, güçlü yönler ve özellikler bazında benzerlik analizi yapar."""
    global _vector_store
    if _vector_store is None:
        return "Vektör veritabanı başlatılmamış."
    
    similar = _vector_store.find_similar_players(player_name, n_results=count)
    
    if not similar:
        return f"'{player_name}' için benzer oyuncu bulunamadı. Oyuncunun raporu olmayabilir."
    
    output = f"'{player_name}' oyuncusuna benzer {len(similar)} oyuncu:\n\n"
    for i, p in enumerate(similar, 1):
        similarity_pct = p.get('similarity', 0) * 100
        output += f"{i}. {p.get('player_name', 'Bilinmeyen')}\n"
        output += f"   Pozisyon: {p.get('player_position', 'N/A')} | Takım: {p.get('player_team', 'N/A')}\n"
        rating = p.get('overall_rating')
        rating_str = f"{rating:.1f}" if rating else "N/A"
        output += f"   Puan: {rating_str}/10 | Benzerlik: %{similarity_pct:.0f}\n\n"
    
    return output


@tool
def semantic_search(query: str, count: int = 5) -> str:
    """Raporlarda anlam bazlı arama yapar.
    Doğal dil sorguları ile oyuncu ve rapor arar.
    Örnek: 'hızlı ve teknik yetenekli kanat oyuncuları', 'liderlik özellikleri güçlü oyuncular'"""
    global _vector_store
    if _vector_store is None:
        return "Vektör veritabanı başlatılmamış."
    
    results = _vector_store.search_similar(query, n_results=count)
    
    if not results:
        return "Arama sonucu bulunamadı."
    
    output = f"'{query}' araması için {len(results)} sonuç:\n\n"
    for i, r in enumerate(results, 1):
        meta = r.get('metadata', {})
        similarity_pct = r.get('similarity', 0) * 100
        output += f"{i}. {meta.get('player_name', 'Bilinmeyen')}\n"
        output += f"   Pozisyon: {meta.get('player_position', 'N/A')} | Takım: {meta.get('player_team', 'N/A')}\n"
        rating = meta.get('overall_rating')
        rating_str = f"{rating}" if rating else "N/A"
        output += f"   Puan: {rating_str}/10 | Eşleşme: %{similarity_pct:.0f}\n\n"
    
    return output


@tool
def get_top_players(metric: str = "avg_overall", count: int = 10) -> str:
    """Belirli bir metriğe göre en iyi oyuncuları listeler.
    Metrikler: avg_overall (genel), avg_potential (potansiyel), 
    avg_physical (fiziksel), avg_technical (teknik), 
    avg_tactical (taktik), avg_mental (mental)"""
    global _data_lake
    if _data_lake is None:
        return "Veri havuzu başlatılmamış."
    
    results = _data_lake.get_top_players(metric=metric, limit=count)
    
    if not results:
        return "Henüz oyuncu verisi yok."
    
    metric_names = {
        "avg_overall": "Genel Puan",
        "avg_potential": "Potansiyel",
        "avg_physical": "Fiziksel",
        "avg_technical": "Teknik",
        "avg_tactical": "Taktik",
        "avg_mental": "Mental"
    }
    metric_label = metric_names.get(metric, metric)
    
    output = f"🏆 {metric_label} Sıralaması (Top {len(results)}):\n\n"
    for i, p in enumerate(results, 1):
        score = p.get(metric, p.get('avg_overall', 0))
        output += f"{i}. {p['player_name']} - {score:.1f}/10\n"
        output += f"   {p['player_position']} | {p['player_team']} | {p['player_age']} yaş\n\n"
    
    return output


@tool
def get_statistics() -> str:
    """Veri havuzundaki genel istatistikleri getirir.
    Toplam oyuncu, rapor sayısı ve ortalama puanları gösterir."""
    global _data_lake
    if _data_lake is None:
        return "Veri havuzu başlatılmamış."
    
    stats = _data_lake.get_statistics()
    
    output = "📊 FutVeri Veri Havuzu İstatistikleri:\n\n"
    output += f"• Toplam Oyuncu: {stats['total_players']}\n"
    output += f"• Toplam Rapor: {stats['total_reports']}\n"
    output += f"• Ortalama Puan: {stats['average_rating']}/10\n"
    
    return output


def create_tools(data_lake: DataLake, vector_store: VectorStore) -> list:
    """Create all tools for the agent."""
    global _data_lake, _vector_store
    _data_lake = data_lake
    _vector_store = vector_store
    
    return [
        search_players,
        get_player_info,
        find_similar_players,
        semantic_search,
        get_top_players,
        get_statistics
    ]
