"""
AI Configuration settings for FutVeri Data Lake.
"""
import os
from pathlib import Path
from pydantic_settings import BaseSettings


class AIConfig(BaseSettings):
    """AI module configuration."""
    
    # Ollama Settings
    OLLAMA_MODEL: str = "mistral"
    OLLAMA_BASE_URL: str = "http://localhost:11434"
    
    # Data Lake Settings
    DUCKDB_PATH: str = "./data/futveri_lake.db"
    
    # Vector Store Settings
    CHROMA_PATH: str = "./data/chroma"
    EMBEDDING_MODEL: str = "all-MiniLM-L6-v2"  # Lightweight, works offline
    
    # Agent Settings
    AGENT_LANGUAGE: str = "tr"  # Turkish responses
    MAX_CONTEXT_REPORTS: int = 10
    
    # ETL Settings
    SYNC_INTERVAL_MINUTES: int = 30
    
    class Config:
        env_prefix = "AI_"
        env_file = ".env"
        extra = "ignore"
    
    @property
    def duckdb_path(self) -> Path:
        """Get DuckDB path as Path object."""
        path = Path(self.DUCKDB_PATH)
        path.parent.mkdir(parents=True, exist_ok=True)
        return path
    
    @property
    def chroma_path(self) -> Path:
        """Get ChromaDB path as Path object."""
        path = Path(self.CHROMA_PATH)
        path.mkdir(parents=True, exist_ok=True)
        return path


# Global config instance
ai_config = AIConfig()
