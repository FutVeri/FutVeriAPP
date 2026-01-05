"""
FutVeri AI Agent using LangChain and Ollama.
Full-featured agent for analyzing player reports with Turkish responses.
"""
from typing import Optional

from langchain_ollama import OllamaLLM
from langchain.agents import AgentExecutor, create_react_agent
from langchain_core.prompts import PromptTemplate

from app.ai.config import ai_config
from app.ai.data_lake import DataLake
from app.ai.vector_store import VectorStore
from app.ai.tools import create_tools


class FutVeriAgent:
    """
    AI Agent for FutVeri player analysis.
    Uses Ollama (Mistral) with LangChain ReAct architecture.
    """
    
    AGENT_PROMPT = PromptTemplate.from_template("""Sen FutVeri için geliştirilmiş profesyonel bir futbol analiz asistanısın.
Görevin, scout raporlarını analiz ederek kullanıcılara oyuncular hakkında detaylı bilgi vermek.

HER ZAMAN TÜRKÇE YANITLA.

Kullanılabilir araçlar:
{tools}

Araç isimleri: {tool_names}

Düşünme süreci:
1. Kullanıcının sorusunu anla
2. Hangi aracı kullanman gerektiğine karar ver
3. Aracı kullan ve sonucu değerlendir
4. Gerekirse başka araçlar kullan
5. Sonucu Türkçe olarak özetle

Format:
Question: kullanıcı sorusu
Thought: ne yapmalıyım?
Action: kullanılacak araç adı
Action Input: araç için girdi (JSON formatında)
Observation: araç sonucu
... (bu döngü gerektiği kadar tekrar edebilir)
Thought: Artık cevabı biliyorum
Final Answer: kullanıcıya Türkçe cevap

Önemli kurallar:
- Her zaman Türkçe yanıt ver
- Somut veriler kullan, tahmin yapma
- Oyuncu isimlerini doğru yaz
- Puanları 10 üzerinden göster
- Önerilerde bulunurken objektif ol

Başla!

Question: {input}
Thought: {agent_scratchpad}""")
    
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
        self._agent_executor = None
    
    @property
    def llm(self) -> OllamaLLM:
        """Lazy load LLM."""
        if self._llm is None:
            self._llm = OllamaLLM(
                model=self.model_name,
                base_url=ai_config.OLLAMA_BASE_URL,
                temperature=0.1,  # Low for consistent responses
                num_ctx=4096,  # Context window
            )
        return self._llm
    
    @property
    def agent_executor(self) -> AgentExecutor:
        """Lazy load agent executor."""
        if self._agent_executor is None:
            # Create tools
            tools = create_tools(self.data_lake, self.vector_store)
            
            # Create ReAct agent
            agent = create_react_agent(
                llm=self.llm,
                tools=tools,
                prompt=self.AGENT_PROMPT
            )
            
            # Create executor
            self._agent_executor = AgentExecutor(
                agent=agent,
                tools=tools,
                verbose=True,
                handle_parsing_errors=True,
                max_iterations=5,
                return_intermediate_steps=True
            )
        
        return self._agent_executor
    
    def query(self, question: str) -> dict:
        """
        Process a natural language query.
        
        Args:
            question: User question in Turkish
            
        Returns:
            Dict with 'answer' and 'sources'
        """
        try:
            result = self.agent_executor.invoke({"input": question})
            
            # Extract sources from intermediate steps
            sources = []
            for step in result.get("intermediate_steps", []):
                if len(step) >= 2:
                    action, observation = step[0], step[1]
                    sources.append({
                        "tool": action.tool,
                        "input": action.tool_input,
                        "output_preview": str(observation)[:200]
                    })
            
            return {
                "answer": result.get("output", "Yanıt oluşturulamadı."),
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
