"""
DuckDB-based Data Lake for aggregated player analytics.
Stores processed report data for fast querying by AI agent.
"""
import duckdb
from datetime import datetime
from typing import Optional
from pathlib import Path

from app.ai.config import ai_config


class DataLake:
    """
    Local data lake using DuckDB for player analytics.
    Aggregates data from scout reports for AI analysis.
    """
    
    def __init__(self, db_path: Optional[Path] = None):
        self.db_path = db_path or ai_config.duckdb_path
        self._ensure_tables()
    
    def _get_connection(self) -> duckdb.DuckDBPyConnection:
        """Get DuckDB connection."""
        return duckdb.connect(str(self.db_path))
    
    def _ensure_tables(self):
        """Create tables if they don't exist."""
        with self._get_connection() as conn:
            # Player Analytics - Aggregated stats per player
            conn.execute("""
                CREATE TABLE IF NOT EXISTS player_analytics (
                    player_name VARCHAR PRIMARY KEY,
                    player_position VARCHAR,
                    player_team VARCHAR,
                    player_age INTEGER,
                    
                    -- Aggregated Ratings (averages from all reports)
                    avg_physical FLOAT,
                    avg_technical FLOAT,
                    avg_tactical FLOAT,
                    avg_mental FLOAT,
                    avg_overall FLOAT,
                    avg_potential FLOAT,
                    
                    -- Min/Max for range
                    min_overall FLOAT,
                    max_overall FLOAT,
                    
                    -- Report counts
                    total_reports INTEGER,
                    approved_reports INTEGER,
                    
                    -- Aggregated text (for semantic search)
                    combined_strengths TEXT,
                    combined_weaknesses TEXT,
                    combined_risks TEXT,
                    all_recommended_roles TEXT,
                    
                    -- Timestamps
                    first_report_date TIMESTAMP,
                    last_report_date TIMESTAMP,
                    last_synced_at TIMESTAMP
                )
            """)
            
            # Report Summaries - Lightweight report data
            conn.execute("""
                CREATE TABLE IF NOT EXISTS report_summaries (
                    report_id VARCHAR PRIMARY KEY,
                    player_name VARCHAR,
                    scout_id VARCHAR,
                    
                    -- Key ratings
                    overall_rating FLOAT,
                    potential_rating FLOAT,
                    
                    -- SWOT summary
                    strengths TEXT,
                    weaknesses TEXT,
                    recommended_role VARCHAR,
                    
                    -- AI-generated summary
                    ai_summary TEXT,
                    
                    -- Match context
                    match_date TIMESTAMP,
                    rival_team VARCHAR,
                    
                    -- Status
                    status VARCHAR,
                    created_at TIMESTAMP,
                    
                    -- Vector reference
                    embedding_id VARCHAR
                )
            """)
            
            # Sync metadata
            conn.execute("""
                CREATE TABLE IF NOT EXISTS sync_metadata (
                    key VARCHAR PRIMARY KEY,
                    value VARCHAR,
                    updated_at TIMESTAMP
                )
            """)
    
    def upsert_player_analytics(
        self,
        player_name: str,
        player_position: str,
        player_team: str,
        player_age: int,
        avg_physical: float,
        avg_technical: float,
        avg_tactical: float,
        avg_mental: float,
        avg_overall: float,
        avg_potential: float,
        min_overall: float,
        max_overall: float,
        total_reports: int,
        approved_reports: int,
        combined_strengths: str,
        combined_weaknesses: str,
        combined_risks: str,
        all_recommended_roles: str,
        first_report_date: datetime,
        last_report_date: datetime
    ):
        """Insert or update player analytics."""
        with self._get_connection() as conn:
            conn.execute("""
                INSERT OR REPLACE INTO player_analytics VALUES (
                    ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?
                )
            """, [
                player_name, player_position, player_team, player_age,
                avg_physical, avg_technical, avg_tactical, avg_mental,
                avg_overall, avg_potential, min_overall, max_overall,
                total_reports, approved_reports,
                combined_strengths, combined_weaknesses, combined_risks,
                all_recommended_roles,
                first_report_date, last_report_date, datetime.utcnow()
            ])
    
    def upsert_report_summary(
        self,
        report_id: str,
        player_name: str,
        scout_id: str,
        overall_rating: float,
        potential_rating: float,
        strengths: str,
        weaknesses: str,
        recommended_role: str,
        ai_summary: Optional[str],
        match_date: datetime,
        rival_team: str,
        status: str,
        created_at: datetime,
        embedding_id: Optional[str] = None
    ):
        """Insert or update report summary."""
        with self._get_connection() as conn:
            conn.execute("""
                INSERT OR REPLACE INTO report_summaries VALUES (
                    ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?
                )
            """, [
                report_id, player_name, scout_id,
                overall_rating, potential_rating,
                strengths, weaknesses, recommended_role, ai_summary,
                match_date, rival_team, status, created_at, embedding_id
            ])
    
    def get_player_analytics(self, player_name: str) -> Optional[dict]:
        """Get analytics for a specific player."""
        with self._get_connection() as conn:
            result = conn.execute(
                "SELECT * FROM player_analytics WHERE player_name = ?",
                [player_name]
            ).fetchone()
            if result:
                columns = [desc[0] for desc in conn.description]
                return dict(zip(columns, result))
        return None
    
    def search_players(
        self,
        position: Optional[str] = None,
        min_age: Optional[int] = None,
        max_age: Optional[int] = None,
        min_rating: Optional[float] = None,
        team: Optional[str] = None,
        limit: int = 20
    ) -> list[dict]:
        """Search players with filters."""
        query = "SELECT * FROM player_analytics WHERE 1=1"
        params = []
        
        if position:
            query += " AND player_position ILIKE ?"
            params.append(f"%{position}%")
        if min_age:
            query += " AND player_age >= ?"
            params.append(min_age)
        if max_age:
            query += " AND player_age <= ?"
            params.append(max_age)
        if min_rating:
            query += " AND avg_overall >= ?"
            params.append(min_rating)
        if team:
            query += " AND player_team ILIKE ?"
            params.append(f"%{team}%")
        
        query += f" ORDER BY avg_overall DESC LIMIT {limit}"
        
        with self._get_connection() as conn:
            results = conn.execute(query, params).fetchall()
            columns = [desc[0] for desc in conn.description]
            return [dict(zip(columns, row)) for row in results]
    
    def get_top_players(
        self,
        metric: str = "avg_overall",
        limit: int = 10
    ) -> list[dict]:
        """Get top players by a specific metric."""
        valid_metrics = [
            "avg_overall", "avg_potential", "avg_physical",
            "avg_technical", "avg_tactical", "avg_mental"
        ]
        if metric not in valid_metrics:
            metric = "avg_overall"
        
        with self._get_connection() as conn:
            results = conn.execute(f"""
                SELECT * FROM player_analytics
                ORDER BY {metric} DESC
                LIMIT ?
            """, [limit]).fetchall()
            columns = [desc[0] for desc in conn.description]
            return [dict(zip(columns, row)) for row in results]
    
    def get_all_reports(self, limit: int = 100) -> list[dict]:
        """Get all report summaries."""
        with self._get_connection() as conn:
            results = conn.execute("""
                SELECT * FROM report_summaries
                ORDER BY created_at DESC
                LIMIT ?
            """, [limit]).fetchall()
            columns = [desc[0] for desc in conn.description]
            return [dict(zip(columns, row)) for row in results]
    
    def get_statistics(self) -> dict:
        """Get overall statistics."""
        with self._get_connection() as conn:
            players = conn.execute(
                "SELECT COUNT(*) FROM player_analytics"
            ).fetchone()[0]
            reports = conn.execute(
                "SELECT COUNT(*) FROM report_summaries"
            ).fetchone()[0]
            avg_rating = conn.execute(
                "SELECT AVG(avg_overall) FROM player_analytics"
            ).fetchone()[0]
            
            return {
                "total_players": players,
                "total_reports": reports,
                "average_rating": round(avg_rating, 2) if avg_rating else 0
            }
    
    def set_last_sync(self, timestamp: datetime):
        """Set last sync timestamp."""
        with self._get_connection() as conn:
            conn.execute("""
                INSERT OR REPLACE INTO sync_metadata VALUES (?, ?, ?)
            """, ["last_sync", timestamp.isoformat(), datetime.utcnow()])
    
    def get_last_sync(self) -> Optional[datetime]:
        """Get last sync timestamp."""
        with self._get_connection() as conn:
            result = conn.execute(
                "SELECT value FROM sync_metadata WHERE key = 'last_sync'"
            ).fetchone()
            if result:
                return datetime.fromisoformat(result[0])
        return None
