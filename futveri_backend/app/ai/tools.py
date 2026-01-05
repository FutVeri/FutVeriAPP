"""
LangChain Tools for FutVeri AI Agent.
Provides structured tools for player search, comparison, and analysis.
"""
from typing import Optional, Type
from pydantic import BaseModel, Field

from langchain_core.tools import BaseTool

from app.ai.data_lake import DataLake
from app.ai.vector_store import VectorStore


# ============== Tool Input Schemas ==============

class SearchPlayersInput(BaseModel):
    """Input for player search."""
    position: Optional[str] = Field(None, description="Oyuncu pozisyonu (örn: 'Forvet', 'Orta Saha', 'Defans')")
    min_age: Optional[int] = Field(None, description="Minimum yaş")
    max_age: Optional[int] = Field(None, description="Maksimum yaş")
    min_rating: Optional[float] = Field(None, description="Minimum genel puan (1-10)")
    team: Optional[str] = Field(None, description="Takım adı")
    limit: int = Field(10, description="Maksimum sonuç sayısı")


class PlayerInfoInput(BaseModel):
    """Input for player info lookup."""
    player_name: str = Field(..., description="Oyuncu adı")


class SimilarPlayersInput(BaseModel):
    """Input for finding similar players."""
    player_name: str = Field(..., description="Referans oyuncu adı")
    count: int = Field(5, description="Benzer oyuncu sayısı")


class SemanticSearchInput(BaseModel):
    """Input for semantic search."""
    query: str = Field(..., description="Arama sorgusu (Türkçe)")
    count: int = Field(5, description="Sonuç sayısı")


class TopPlayersInput(BaseModel):
    """Input for top players query."""
    metric: str = Field("avg_overall", description="Sıralama metriği: avg_overall, avg_potential, avg_physical, avg_technical, avg_tactical, avg_mental")
    count: int = Field(10, description="Oyuncu sayısı")


# ============== Tool Implementations ==============

class SearchPlayersTool(BaseTool):
    """Tool for searching players with filters."""
    
    name: str = "search_players"
    description: str = """Oyuncuları filtrelerle arar. 
    Pozisyon, yaş aralığı, minimum puan ve takım filtresi kullanabilirsin.
    Örnek: 18 yaş altı forvetleri bul, 7+ puana sahip orta saha oyuncuları"""
    args_schema: Type[BaseModel] = SearchPlayersInput
    
    data_lake: DataLake = None
    
    def __init__(self, data_lake: DataLake):
        super().__init__()
        self.data_lake = data_lake
    
    def _run(
        self,
        position: Optional[str] = None,
        min_age: Optional[int] = None,
        max_age: Optional[int] = None,
        min_rating: Optional[float] = None,
        team: Optional[str] = None,
        limit: int = 10
    ) -> str:
        results = self.data_lake.search_players(
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


class GetPlayerInfoTool(BaseTool):
    """Tool for getting detailed player info."""
    
    name: str = "get_player_info"
    description: str = """Belirli bir oyuncunun detaylı bilgilerini getirir.
    Ortalama puanlar, güçlü/zayıf yönler ve rapor istatistiklerini içerir."""
    args_schema: Type[BaseModel] = PlayerInfoInput
    
    data_lake: DataLake = None
    
    def __init__(self, data_lake: DataLake):
        super().__init__()
        self.data_lake = data_lake
    
    def _run(self, player_name: str) -> str:
        player = self.data_lake.get_player_analytics(player_name)
        
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
        output += f"✅ Güçlü Yönler: {player['combined_strengths'][:300]}\n"
        output += f"⚠️ Zayıf Yönler: {player['combined_weaknesses'][:300]}\n"
        output += f"🚨 Riskler: {player['combined_risks'][:200]}\n"
        output += f"🎯 Önerilen Roller: {player['all_recommended_roles']}\n\n"
        
        output += f"📈 Toplam Rapor: {player['total_reports']}\n"
        
        return output


class FindSimilarPlayersTool(BaseTool):
    """Tool for finding similar players."""
    
    name: str = "find_similar_players"
    description: str = """Bir oyuncuya benzer oyuncuları bulur.
    Oyun tarzı, güçlü yönler ve özellikler bazında benzerlik analizi yapar."""
    args_schema: Type[BaseModel] = SimilarPlayersInput
    
    vector_store: VectorStore = None
    
    def __init__(self, vector_store: VectorStore):
        super().__init__()
        self.vector_store = vector_store
    
    def _run(self, player_name: str, count: int = 5) -> str:
        similar = self.vector_store.find_similar_players(player_name, n_results=count)
        
        if not similar:
            return f"'{player_name}' için benzer oyuncu bulunamadı. Oyuncunun raporu olmayabilir."
        
        output = f"'{player_name}' oyuncusuna benzer {len(similar)} oyuncu:\n\n"
        for i, p in enumerate(similar, 1):
            similarity_pct = p['similarity'] * 100
            output += f"{i}. {p['player_name']}\n"
            output += f"   Pozisyon: {p['player_position']} | Takım: {p['player_team']}\n"
            output += f"   Puan: {p['overall_rating']:.1f}/10 | Benzerlik: %{similarity_pct:.0f}\n\n"
        
        return output


class SemanticSearchTool(BaseTool):
    """Tool for semantic search on reports."""
    
    name: str = "semantic_search"
    description: str = """Raporlarda anlam bazlı arama yapar.
    Doğal dil sorguları ile oyuncu ve rapor arar.
    Örnek: 'hızlı ve teknik yetenekli kanat oyuncuları', 'liderlik özellikleri güçlü oyuncular'"""
    args_schema: Type[BaseModel] = SemanticSearchInput
    
    vector_store: VectorStore = None
    
    def __init__(self, vector_store: VectorStore):
        super().__init__()
        self.vector_store = vector_store
    
    def _run(self, query: str, count: int = 5) -> str:
        results = self.vector_store.search_similar(query, n_results=count)
        
        if not results:
            return "Arama sonucu bulunamadı."
        
        output = f"'{query}' araması için {len(results)} sonuç:\n\n"
        for i, r in enumerate(results, 1):
            meta = r.get('metadata', {})
            similarity_pct = r.get('similarity', 0) * 100
            output += f"{i}. {meta.get('player_name', 'Bilinmeyen')}\n"
            output += f"   Pozisyon: {meta.get('player_position')} | Takım: {meta.get('player_team')}\n"
            output += f"   Puan: {meta.get('overall_rating', 'N/A')}/10 | Eşleşme: %{similarity_pct:.0f}\n\n"
        
        return output


class GetTopPlayersTool(BaseTool):
    """Tool for getting top players by metric."""
    
    name: str = "get_top_players"
    description: str = """Belirli bir metriğe göre en iyi oyuncuları listeler.
    Metrikler: avg_overall (genel), avg_potential (potansiyel), 
    avg_physical (fiziksel), avg_technical (teknik), 
    avg_tactical (taktik), avg_mental (mental)"""
    args_schema: Type[BaseModel] = TopPlayersInput
    
    data_lake: DataLake = None
    
    def __init__(self, data_lake: DataLake):
        super().__init__()
        self.data_lake = data_lake
    
    def _run(self, metric: str = "avg_overall", count: int = 10) -> str:
        results = self.data_lake.get_top_players(metric=metric, limit=count)
        
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
            score = p.get(metric, p['avg_overall'])
            output += f"{i}. {p['player_name']} - {score:.1f}/10\n"
            output += f"   {p['player_position']} | {p['player_team']} | {p['player_age']} yaş\n\n"
        
        return output


class GetStatisticsTool(BaseTool):
    """Tool for getting overall statistics."""
    
    name: str = "get_statistics"
    description: str = """Veri havuzundaki genel istatistikleri getirir.
    Toplam oyuncu, rapor sayısı ve ortalama puanları gösterir."""
    
    data_lake: DataLake = None
    
    def __init__(self, data_lake: DataLake):
        super().__init__()
        self.data_lake = data_lake
    
    def _run(self) -> str:
        stats = self.data_lake.get_statistics()
        
        output = "📊 FutVeri Veri Havuzu İstatistikleri:\n\n"
        output += f"• Toplam Oyuncu: {stats['total_players']}\n"
        output += f"• Toplam Rapor: {stats['total_reports']}\n"
        output += f"• Ortalama Puan: {stats['average_rating']}/10\n"
        
        return output


def create_tools(data_lake: DataLake, vector_store: VectorStore) -> list[BaseTool]:
    """Create all tools for the agent."""
    return [
        SearchPlayersTool(data_lake=data_lake),
        GetPlayerInfoTool(data_lake=data_lake),
        FindSimilarPlayersTool(vector_store=vector_store),
        SemanticSearchTool(vector_store=vector_store),
        GetTopPlayersTool(data_lake=data_lake),
        GetStatisticsTool(data_lake=data_lake)
    ]
