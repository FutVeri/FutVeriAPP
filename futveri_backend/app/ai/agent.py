"""
FutVeri AI Agent using LangChain and Ollama.
Full-featured agent for analyzing player reports with Turkish responses.
Uses langgraph for agent orchestration (LangChain 1.x compatible).
"""
from typing import Optional

from langchain_ollama import ChatOllama
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.output_parsers import StrOutputParser
from langgraph.prebuilt import create_react_agent

from app.ai.config import ai_config
from app.ai.data_lake import DataLake
from app.ai.vector_store import VectorStore
from app.ai.tools import create_tools


class FutVeriAgent:
    """
    AI Agent for FutVeri player analysis.
    Uses Ollama (Mistral) with LangGraph ReAct architecture.
    """
    
    SYSTEM_PROMPT = """Sen FutVeri için geliştirilmiş profesyonel bir futbol analiz asistanısın.
Görevin, scout raporlarını analiz ederek kullanıcılara oyuncular hakkında detaylı bilgi vermek.

HER ZAMAN TÜRKÇE YANITLA.

Önemli kurallar:
- Her zaman Türkçe yanıt ver
- Somut veriler kullan, tahmin yapma
- Oyuncu isimlerini doğru yaz
- Puanları 10 üzerinden göster
- Önerilerde bulunurken objektif ol

Araçları kullanarak veri havuzundan bilgi çek ve kullanıcıya yardımcı ol."""
    
    def __init__(
        self,
        data_lake: Optional[DataLake] = None,
        vector_store: Optional[VectorStore] = None,
        model_name: Optional[str] = None
    ):
        self.data_lake = data_lake or DataLake()
        self.vector_store = vector_store or VectorStore()
        self.model_name = model_name or ai_config.OLLAMA_MODEL
        
        self._llm = None
        self._agent = None
    
    @property
    def llm(self) -> ChatOllama:
        """Lazy load LLM."""
        if self._llm is None:
            self._llm = ChatOllama(
                model=self.model_name,
                base_url=ai_config.OLLAMA_BASE_URL,
                temperature=0.1,
            )
        return self._llm
    
    @property
    def agent(self):
        """Lazy load agent."""
        if self._agent is None:
            tools = create_tools(self.data_lake, self.vector_store)
            self._agent = create_react_agent(
                model=self.llm,
                tools=tools,
                prompt=self.SYSTEM_PROMPT
            )
        return self._agent
    
    def query(self, question: str) -> dict:
        """
        Process a natural language query.
        
        Args:
            question: User question in Turkish
            
        Returns:
            Dict with 'answer' and 'sources'
        """
        try:
            # Invoke agent
            result = self.agent.invoke({
                "messages": [("user", question)]
            })
            
            # Extract final answer
            messages = result.get("messages", [])
            answer = ""
            sources = []
            
            for msg in messages:
                if hasattr(msg, 'content'):
                    # Last AI message is the answer
                    if hasattr(msg, 'type') and msg.type == 'ai':
                        answer = msg.content
                    # Tool messages are sources
                    elif hasattr(msg, 'type') and msg.type == 'tool':
                        sources.append({
                            "tool": getattr(msg, 'name', 'unknown'),
                            "output_preview": str(msg.content)[:200]
                        })
            
            if not answer and messages:
                # Fallback: get last message content
                answer = str(messages[-1].content) if hasattr(messages[-1], 'content') else str(messages[-1])
            
            return {
                "answer": answer or "Yanıt oluşturulamadı.",
                "sources": sources,
                "success": True
            }
            
        except Exception as e:
            return {
                "answer": f"Bir hata oluştu: {str(e)}",
                "sources": [],
                "success": False,
                "error": str(e)
            }
    
    def search_players(
        self,
        position: Optional[str] = None,
        min_age: Optional[int] = None,
        max_age: Optional[int] = None,
        min_rating: Optional[float] = None,
        team: Optional[str] = None,
        limit: int = 20
    ) -> list[dict]:
        """Direct player search without LLM."""
        return self.data_lake.search_players(
            position=position,
            min_age=min_age,
            max_age=max_age,
            min_rating=min_rating,
            team=team,
            limit=limit
        )
    
    def get_player_info(self, player_name: str) -> Optional[dict]:
        """Get player analytics directly."""
        return self.data_lake.get_player_analytics(player_name)
    
    def find_similar_players(self, player_name: str, count: int = 5) -> list[dict]:
        """Find similar players directly."""
        return self.vector_store.find_similar_players(player_name, n_results=count)
    
    def semantic_search(self, query: str, count: int = 5) -> list[dict]:
        """Semantic search directly."""
        return self.vector_store.search_similar(query, n_results=count)
    
    def get_top_players(self, metric: str = "avg_overall", count: int = 10) -> list[dict]:
        """Get top players directly."""
        return self.data_lake.get_top_players(metric=metric, limit=count)
    
    def get_statistics(self) -> dict:
        """Get overall statistics."""
        return self.data_lake.get_statistics()
