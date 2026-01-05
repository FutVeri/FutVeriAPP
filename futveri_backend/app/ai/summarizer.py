"""
Report Summarizer using Ollama LLM.
Generates concise Turkish summaries of player reports.
"""
from typing import Optional

from langchain_ollama import OllamaLLM
from langchain_core.prompts import PromptTemplate

from app.ai.config import ai_config


class ReportSummarizer:
    """
    Generates AI summaries of player reports using Ollama.
    Produces concise Turkish summaries.
    """
    
    SUMMARY_PROMPT = PromptTemplate(
        input_variables=[
            "player_name", "player_position", "player_age", "player_team",
            "physical_rating", "physical_desc",
            "technical_rating", "technical_desc",
            "tactical_rating", "tactical_desc",
            "mental_rating", "mental_desc",
            "strengths", "weaknesses", "risks",
            "overall_rating", "potential_rating", "recommended_role"
        ],
        template="""Sen profesyonel bir futbol analistisin. Aşağıdaki oyuncu raporunu analiz et ve 2-3 cümlelik özlü bir Türkçe özet yaz.

OYUNCU BİLGİLERİ:
- İsim: {player_name}
- Pozisyon: {player_position}
- Yaş: {player_age}
- Takım: {player_team}

DEĞERLENDİRMELER (1-10):
- Fiziksel: {physical_rating}/10 - {physical_desc}
- Teknik: {technical_rating}/10 - {technical_desc}
- Taktik: {tactical_rating}/10 - {tactical_desc}
- Mental: {mental_rating}/10 - {mental_desc}

SWOT ANALİZİ:
- Güçlü Yönler: {strengths}
- Zayıf Yönler: {weaknesses}
- Riskler: {risks}

SONUÇ:
- Genel Puan: {overall_rating}/10
- Potansiyel: {potential_rating}/10
- Önerilen Rol: {recommended_role}

ÖZET (2-3 cümle, Türkçe):"""
    )
    
    def __init__(self, model_name: Optional[str] = None):
        self.model_name = model_name or ai_config.OLLAMA_MODEL
        self._llm = None
    
    @property
    def llm(self) -> OllamaLLM:
        """Lazy load LLM."""
        if self._llm is None:
            self._llm = OllamaLLM(
                model=self.model_name,
                base_url=ai_config.OLLAMA_BASE_URL,
                temperature=0.3,  # Lower for more consistent summaries
            )
        return self._llm
    
    async def summarize_report(self, report) -> str:
        """
        Generate a summary for a scout report.
        
        Args:
            report: ScoutReport model instance
            
        Returns:
            Turkish summary string
        """
        try:
            prompt = self.SUMMARY_PROMPT.format(
                player_name=report.player_name,
                player_position=report.player_position,
                player_age=report.player_age,
                player_team=report.player_team,
                physical_rating=report.physical_rating,
                physical_desc=report.physical_description[:200],
                technical_rating=report.technical_rating,
                technical_desc=report.technical_description[:200],
                tactical_rating=report.tactical_rating,
                tactical_desc=report.tactical_description[:200],
                mental_rating=report.mental_rating,
                mental_desc=report.mental_description[:200],
                strengths=report.strengths[:300],
                weaknesses=report.weaknesses[:300],
                risks=report.risks[:300],
                overall_rating=report.overall_rating,
                potential_rating=report.potential_rating,
                recommended_role=report.recommended_role
            )
            
            # Run synchronously (Ollama doesn't have native async)
            response = self.llm.invoke(prompt)
            
            # Clean up response
            summary = response.strip()
            if len(summary) > 500:
                summary = summary[:500] + "..."
            
            return summary
            
        except Exception as e:
            return f"Özet oluşturulamadı: {str(e)}"
    
    def summarize_report_sync(self, report) -> str:
        """Synchronous version for non-async contexts."""
        try:
            prompt = self.SUMMARY_PROMPT.format(
                player_name=report.player_name,
                player_position=report.player_position,
                player_age=report.player_age,
                player_team=report.player_team,
                physical_rating=report.physical_rating,
                physical_desc=report.physical_description[:200],
                technical_rating=report.technical_rating,
                technical_desc=report.technical_description[:200],
                tactical_rating=report.tactical_rating,
                tactical_desc=report.tactical_description[:200],
                mental_rating=report.mental_rating,
                mental_desc=report.mental_description[:200],
                strengths=report.strengths[:300],
                weaknesses=report.weaknesses[:300],
                risks=report.risks[:300],
                overall_rating=report.overall_rating,
                potential_rating=report.potential_rating,
                recommended_role=report.recommended_role
            )
            
            response = self.llm.invoke(prompt)
            summary = response.strip()
            
            if len(summary) > 500:
                summary = summary[:500] + "..."
            
            return summary
            
        except Exception as e:
            return f"Özet oluşturulamadı: {str(e)}"
