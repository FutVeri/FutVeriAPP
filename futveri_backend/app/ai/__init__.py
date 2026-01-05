"""
AI module for FutVeri Data Lake and Agent.
Provides intelligent analysis of player reports using local LLM (Ollama).
"""
from app.ai.config import AIConfig
from app.ai.data_lake import DataLake
from app.ai.vector_store import VectorStore
from app.ai.agent import FutVeriAgent

__all__ = ["AIConfig", "DataLake", "VectorStore", "FutVeriAgent"]
