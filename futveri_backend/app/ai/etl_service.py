"""
ETL Service for syncing data from Supabase to local Data Lake.
Handles data extraction, transformation, and loading.
"""
from datetime import datetime
from typing import Optional
from collections import defaultdict

from sqlalchemy import select, func
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.scout_report import ScoutReport
from app.ai.data_lake import DataLake
from app.ai.vector_store import VectorStore
from app.ai.summarizer import ReportSummarizer


class ETLService:
    """
    ETL service for syncing Supabase data to local data lake.
    Extracts reports, aggregates player stats, and generates embeddings.
    """
    
    def __init__(
        self,
        data_lake: Optional[DataLake] = None,
        vector_store: Optional[VectorStore] = None,
        summarizer: Optional[ReportSummarizer] = None
    ):
        self.data_lake = data_lake or DataLake()
        self.vector_store = vector_store or VectorStore()
        self.summarizer = summarizer
    
    async def sync_all(self, db: AsyncSession) -> dict:
        """
        Full sync: Extract all reports, aggregate, and store.
        Returns sync statistics.
        """
        stats = {
            "reports_synced": 0,
            "players_updated": 0,
            "embeddings_created": 0,
            "summaries_generated": 0,
            "errors": []
        }
        
        try:
            # 1. Extract all approved reports from Supabase
            reports = await self._extract_reports(db)
            stats["reports_synced"] = len(reports)
            
            # 2. Process each report
            for report in reports:
                try:
                    # Generate AI summary if summarizer available
                    ai_summary = None
                    if self.summarizer:
                        ai_summary = await self.summarizer.summarize_report(report)
                        stats["summaries_generated"] += 1
                    
                    # Store in vector store
                    self.vector_store.add_report(
                        report_id=report.id,
                        player_name=report.player_name,
                        player_position=report.player_position,
                        player_age=report.player_age,
                        player_team=report.player_team,
                        physical_desc=report.physical_description,
                        technical_desc=report.technical_description,
                        tactical_desc=report.tactical_description,
                        mental_desc=report.mental_description,
                        strengths=report.strengths,
                        weaknesses=report.weaknesses,
                        risks=report.risks,
                        recommended_role=report.recommended_role,
                        overall_rating=report.overall_rating,
                        potential_rating=report.potential_rating,
                        scout_id=report.scout_id,
                        description=report.description
                    )
                    stats["embeddings_created"] += 1
                    
                    # Store report summary in data lake
                    self.data_lake.upsert_report_summary(
                        report_id=report.id,
                        player_name=report.player_name,
                        scout_id=report.scout_id,
                        overall_rating=report.overall_rating,
                        potential_rating=report.potential_rating,
                        strengths=report.strengths,
                        weaknesses=report.weaknesses,
                        recommended_role=report.recommended_role,
                        ai_summary=ai_summary,
                        match_date=report.match_date,
                        rival_team=report.rival_team,
                        status=report.status,
                        created_at=report.created_at,
                        embedding_id=report.id
                    )
                    
                except Exception as e:
                    stats["errors"].append(f"Report {report.id}: {str(e)}")
            
            # 3. Aggregate player analytics
            player_stats = await self._aggregate_player_stats(db)
            for player_name, player_data in player_stats.items():
                try:
                    self.data_lake.upsert_player_analytics(**player_data)
                    stats["players_updated"] += 1
                except Exception as e:
                    stats["errors"].append(f"Player {player_name}: {str(e)}")
            
            # 4. Update sync timestamp
            self.data_lake.set_last_sync(datetime.utcnow())
            
        except Exception as e:
            stats["errors"].append(f"General error: {str(e)}")
        
        return stats
    
    async def sync_incremental(self, db: AsyncSession) -> dict:
        """
        Incremental sync: Only sync reports updated since last sync.
        """
        last_sync = self.data_lake.get_last_sync()
        
        if last_sync is None:
            # No previous sync, do full sync
            return await self.sync_all(db)
        
        stats = {
            "reports_synced": 0,
            "players_updated": 0,
            "embeddings_created": 0,
            "summaries_generated": 0,
            "errors": []
        }
        
        try:
            # Get reports updated since last sync
            query = select(ScoutReport).where(
                ScoutReport.updated_at > last_sync,
                ScoutReport.status == "approved"
            )
            result = await db.execute(query)
            reports = result.scalars().all()
            stats["reports_synced"] = len(reports)
            
            # Process each report
            affected_players = set()
            for report in reports:
                try:
                    # Generate AI summary
                    ai_summary = None
                    if self.summarizer:
                        ai_summary = await self.summarizer.summarize_report(report)
                        stats["summaries_generated"] += 1
                    
                    # Update vector store
                    self.vector_store.add_report(
                        report_id=report.id,
                        player_name=report.player_name,
                        player_position=report.player_position,
                        player_age=report.player_age,
                        player_team=report.player_team,
                        physical_desc=report.physical_description,
                        technical_desc=report.technical_description,
                        tactical_desc=report.tactical_description,
                        mental_desc=report.mental_description,
                        strengths=report.strengths,
                        weaknesses=report.weaknesses,
                        risks=report.risks,
                        recommended_role=report.recommended_role,
                        overall_rating=report.overall_rating,
                        potential_rating=report.potential_rating,
                        scout_id=report.scout_id,
                        description=report.description
                    )
                    stats["embeddings_created"] += 1
                    
                    # Update report summary
                    self.data_lake.upsert_report_summary(
                        report_id=report.id,
                        player_name=report.player_name,
                        scout_id=report.scout_id,
                        overall_rating=report.overall_rating,
                        potential_rating=report.potential_rating,
                        strengths=report.strengths,
                        weaknesses=report.weaknesses,
                        recommended_role=report.recommended_role,
                        ai_summary=ai_summary,
                        match_date=report.match_date,
                        rival_team=report.rival_team,
                        status=report.status,
                        created_at=report.created_at,
                        embedding_id=report.id
                    )
                    
                    affected_players.add(report.player_name)
                    
                except Exception as e:
                    stats["errors"].append(f"Report {report.id}: {str(e)}")
            
            # Re-aggregate only affected players
            if affected_players:
                player_stats = await self._aggregate_player_stats(
                    db, player_names=list(affected_players)
                )
                for player_name, player_data in player_stats.items():
                    try:
                        self.data_lake.upsert_player_analytics(**player_data)
                        stats["players_updated"] += 1
                    except Exception as e:
                        stats["errors"].append(f"Player {player_name}: {str(e)}")
            
            # Update sync timestamp
            self.data_lake.set_last_sync(datetime.utcnow())
            
        except Exception as e:
            stats["errors"].append(f"General error: {str(e)}")
        
        return stats
    
    async def _extract_reports(self, db: AsyncSession) -> list[ScoutReport]:
        """Extract approved reports from database."""
        query = select(ScoutReport).where(
            ScoutReport.status == "approved"
        ).order_by(ScoutReport.created_at.desc())
        
        result = await db.execute(query)
        return list(result.scalars().all())
    
    async def _aggregate_player_stats(
        self,
        db: AsyncSession,
        player_names: Optional[list[str]] = None
    ) -> dict:
        """
        Aggregate player statistics from all their reports.
        Returns dict keyed by player_name.
        """
        # Build query
        query = select(ScoutReport).where(ScoutReport.status == "approved")
        if player_names:
            query = query.where(ScoutReport.player_name.in_(player_names))
        
        result = await db.execute(query)
        reports = result.scalars().all()
        
        # Group by player
        player_reports = defaultdict(list)
        for report in reports:
            player_reports[report.player_name].append(report)
        
        # Aggregate stats
        aggregated = {}
        for player_name, reports in player_reports.items():
            if not reports:
                continue
            
            # Take latest report for player info
            latest = max(reports, key=lambda r: r.created_at)
            
            # Calculate averages
            n = len(reports)
            avg_physical = sum(r.physical_rating for r in reports) / n
            avg_technical = sum(r.technical_rating for r in reports) / n
            avg_tactical = sum(r.tactical_rating for r in reports) / n
            avg_mental = sum(r.mental_rating for r in reports) / n
            avg_overall = sum(r.overall_rating for r in reports) / n
            avg_potential = sum(r.potential_rating for r in reports) / n
            
            # Min/Max
            min_overall = min(r.overall_rating for r in reports)
            max_overall = max(r.overall_rating for r in reports)
            
            # Combine text fields
            combined_strengths = " | ".join(set(r.strengths for r in reports))
            combined_weaknesses = " | ".join(set(r.weaknesses for r in reports))
            combined_risks = " | ".join(set(r.risks for r in reports))
            all_roles = " | ".join(set(r.recommended_role for r in reports))
            
            # Dates
            first_date = min(r.created_at for r in reports)
            last_date = max(r.created_at for r in reports)
            
            aggregated[player_name] = {
                "player_name": player_name,
                "player_position": latest.player_position,
                "player_team": latest.player_team,
                "player_age": latest.player_age,
                "avg_physical": round(avg_physical, 2),
                "avg_technical": round(avg_technical, 2),
                "avg_tactical": round(avg_tactical, 2),
                "avg_mental": round(avg_mental, 2),
                "avg_overall": round(avg_overall, 2),
                "avg_potential": round(avg_potential, 2),
                "min_overall": min_overall,
                "max_overall": max_overall,
                "total_reports": n,
                "approved_reports": n,  # Already filtered
                "combined_strengths": combined_strengths[:2000],  # Limit length
                "combined_weaknesses": combined_weaknesses[:2000],
                "combined_risks": combined_risks[:2000],
                "all_recommended_roles": all_roles[:500],
                "first_report_date": first_date,
                "last_report_date": last_date
            }
        
        return aggregated
