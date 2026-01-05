"""
ChromaDB Vector Store for semantic search on player reports.
Enables similarity search and RAG for AI agent.
"""
import chromadb
from chromadb.config import Settings
from sentence_transformers import SentenceTransformer
from typing import Optional
from pathlib import Path

from app.ai.config import ai_config


class VectorStore:
    """
    ChromaDB-based vector store for semantic search.
    Stores embeddings of report texts for similarity queries.
    """
    
    COLLECTION_NAME = "futveri_reports"
    
    def __init__(self, persist_path: Optional[Path] = None):
        self.persist_path = persist_path or ai_config.chroma_path
        
        # Initialize ChromaDB with persistence
        self.client = chromadb.PersistentClient(
            path=str(self.persist_path),
            settings=Settings(anonymized_telemetry=False)
        )
        
        # Get or create collection
        self.collection = self.client.get_or_create_collection(
            name=self.COLLECTION_NAME,
            metadata={"description": "FutVeri player report embeddings"}
        )
        
        # Initialize embedding model (lightweight, works offline)
        self._embedding_model = None
    
    @property
    def embedding_model(self) -> SentenceTransformer:
        """Lazy load embedding model."""
        if self._embedding_model is None:
            self._embedding_model = SentenceTransformer(
                ai_config.EMBEDDING_MODEL
            )
        return self._embedding_model
    
    def _create_report_text(
        self,
        player_name: str,
        player_position: str,
        player_age: int,
        player_team: str,
        physical_desc: str,
        technical_desc: str,
        tactical_desc: str,
        mental_desc: str,
        strengths: str,
        weaknesses: str,
        risks: str,
        recommended_role: str,
        description: Optional[str] = None
    ) -> str:
        """Create searchable text from report data."""
        text = f"""
Oyuncu: {player_name}
Pozisyon: {player_position}
Yaş: {player_age}
Takım: {player_team}

Fiziksel Değerlendirme: {physical_desc}
Teknik Değerlendirme: {technical_desc}
Taktik Değerlendirme: {tactical_desc}
Mental Değerlendirme: {mental_desc}

Güçlü Yönler: {strengths}
Zayıf Yönler: {weaknesses}
Riskler: {risks}
Önerilen Rol: {recommended_role}
"""
        if description:
            text += f"\nGenel Değerlendirme: {description}"
        
        return text.strip()
    
    def add_report(
        self,
        report_id: str,
        player_name: str,
        player_position: str,
        player_age: int,
        player_team: str,
        physical_desc: str,
        technical_desc: str,
        tactical_desc: str,
        mental_desc: str,
        strengths: str,
        weaknesses: str,
        risks: str,
        recommended_role: str,
        overall_rating: float,
        potential_rating: float,
        scout_id: str,
        description: Optional[str] = None
    ) -> str:
        """Add or update a report in the vector store."""
        # Create searchable text
        text = self._create_report_text(
            player_name, player_position, player_age, player_team,
            physical_desc, technical_desc, tactical_desc, mental_desc,
            strengths, weaknesses, risks, recommended_role, description
        )
        
        # Generate embedding
        embedding = self.embedding_model.encode(text).tolist()
        
        # Metadata for filtering
        metadata = {
            "player_name": player_name,
            "player_position": player_position,
            "player_age": player_age,
            "player_team": player_team,
            "overall_rating": overall_rating,
            "potential_rating": potential_rating,
            "scout_id": scout_id,
            "recommended_role": recommended_role
        }
        
        # Upsert to collection
        self.collection.upsert(
            ids=[report_id],
            embeddings=[embedding],
            documents=[text],
            metadatas=[metadata]
        )
        
        return report_id
    
    def search_similar(
        self,
        query: str,
        n_results: int = 5,
        filter_position: Optional[str] = None,
        filter_min_age: Optional[int] = None,
        filter_max_age: Optional[int] = None,
        filter_min_rating: Optional[float] = None
    ) -> list[dict]:
        """
        Search for reports similar to the query.
        Returns list of matching reports with scores.
        """
        # Build where filter
        where_filter = {}
        if filter_position:
            where_filter["player_position"] = {"$contains": filter_position}
        if filter_min_age:
            where_filter["player_age"] = {"$gte": filter_min_age}
        if filter_max_age:
            if "player_age" in where_filter:
                where_filter["$and"] = [
                    {"player_age": {"$gte": filter_min_age}},
                    {"player_age": {"$lte": filter_max_age}}
                ]
                del where_filter["player_age"]
            else:
                where_filter["player_age"] = {"$lte": filter_max_age}
        if filter_min_rating:
            where_filter["overall_rating"] = {"$gte": filter_min_rating}
        
        # Generate query embedding
        query_embedding = self.embedding_model.encode(query).tolist()
        
        # Search
        results = self.collection.query(
            query_embeddings=[query_embedding],
            n_results=n_results,
            where=where_filter if where_filter else None,
            include=["documents", "metadatas", "distances"]
        )
        
        # Format results
        formatted = []
        if results["ids"] and results["ids"][0]:
            for i, report_id in enumerate(results["ids"][0]):
                formatted.append({
                    "report_id": report_id,
                    "document": results["documents"][0][i] if results["documents"] else None,
                    "metadata": results["metadatas"][0][i] if results["metadatas"] else None,
                    "distance": results["distances"][0][i] if results["distances"] else None,
                    "similarity": 1 - (results["distances"][0][i] if results["distances"] else 0)
                })
        
        return formatted
    
    def find_similar_players(
        self,
        player_name: str,
        n_results: int = 5
    ) -> list[dict]:
        """Find players similar to the given player."""
        # First get the player's reports
        results = self.collection.get(
            where={"player_name": player_name},
            include=["documents", "embeddings"]
        )
        
        if not results["embeddings"]:
            return []
        
        # Use average embedding of all the player's reports
        import numpy as np
        avg_embedding = np.mean(results["embeddings"], axis=0).tolist()
        
        # Search for similar (excluding the same player)
        similar = self.collection.query(
            query_embeddings=[avg_embedding],
            n_results=n_results + 5,  # Get extras to filter
            include=["metadatas", "distances"]
        )
        
        # Filter out same player and format
        formatted = []
        seen_players = {player_name}
        
        if similar["ids"] and similar["ids"][0]:
            for i, report_id in enumerate(similar["ids"][0]):
                meta = similar["metadatas"][0][i] if similar["metadatas"] else {}
                pname = meta.get("player_name", "")
                
                if pname not in seen_players:
                    seen_players.add(pname)
                    formatted.append({
                        "player_name": pname,
                        "player_position": meta.get("player_position"),
                        "player_team": meta.get("player_team"),
                        "overall_rating": meta.get("overall_rating"),
                        "similarity": 1 - (similar["distances"][0][i] if similar["distances"] else 0)
                    })
                    
                    if len(formatted) >= n_results:
                        break
        
        return formatted
    
    def get_report_count(self) -> int:
        """Get total number of reports in vector store."""
        return self.collection.count()
    
    def delete_report(self, report_id: str):
        """Delete a report from vector store."""
        self.collection.delete(ids=[report_id])
    
    def clear_all(self):
        """Clear all reports from vector store."""
        self.client.delete_collection(self.COLLECTION_NAME)
        self.collection = self.client.create_collection(
            name=self.COLLECTION_NAME,
            metadata={"description": "FutVeri player report embeddings"}
        )
