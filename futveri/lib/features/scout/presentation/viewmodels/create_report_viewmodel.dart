import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futveri/core/supabase/supabase_client.dart';
import 'package:uuid/uuid.dart';

/// State for the Create Report Form - matches backend scout_reports table exactly
class CreateReportState {
  // Player Information (all required)
  final String playerName;
  final String playerPosition;
  final int playerAge;
  final String playerTeam;
  
  // Match Context (all required)
  final DateTime matchDate;
  final String rivalTeam;
  final String score;
  final int minutePlayed;
  final String matchType;
  
  // Physical (required)
  final int physicalRating;
  final String physicalDescription;
  
  // Technical (required)
  final int technicalRating;
  final String technicalDescription;
  
  // Tactical (required)
  final int tacticalRating;
  final String tacticalDescription;
  
  // Mental (required)
  final int mentalRating;
  final String mentalDescription;
  
  // Overall (required)
  final double overallRating;
  final double potentialRating;
  
  // SWOT Analysis (required)
  final String strengths;
  final String weaknesses;
  final String risks;
  final String recommendedRole;
  
  // Optional fields
  final String description;
  final String notes;
  final List<String> imageUrls;
  
  // Meta
  final bool isSubmitting;
  final String? errorMessage;

  CreateReportState({
    this.playerName = '',
    this.playerPosition = '',
    this.playerAge = 20,
    this.playerTeam = '',
    
    DateTime? matchDate,
    this.rivalTeam = '',
    this.score = '0-0',
    this.minutePlayed = 90,
    this.matchType = 'Stadium',
    
    this.physicalRating = 5,
    this.physicalDescription = '',
    
    this.technicalRating = 5,
    this.technicalDescription = '',
    
    this.tacticalRating = 5,
    this.tacticalDescription = '',
    
    this.mentalRating = 5,
    this.mentalDescription = '',
    
    this.overallRating = 5.0,
    this.potentialRating = 5.0,
    
    this.strengths = '',
    this.weaknesses = '',
    this.risks = '',
    this.recommendedRole = '',
    
    this.description = '',
    this.notes = '',
    this.imageUrls = const [],
    
    this.isSubmitting = false,
    this.errorMessage,
  }) : matchDate = matchDate ?? DateTime.now();

  CreateReportState copyWith({
    String? playerName,
    String? playerPosition,
    int? playerAge,
    String? playerTeam,
    
    DateTime? matchDate,
    String? rivalTeam,
    String? score,
    int? minutePlayed,
    String? matchType,
    
    int? physicalRating,
    String? physicalDescription,
    
    int? technicalRating,
    String? technicalDescription,
    
    int? tacticalRating,
    String? tacticalDescription,
    
    int? mentalRating,
    String? mentalDescription,
    
    double? overallRating,
    double? potentialRating,
    
    String? strengths,
    String? weaknesses,
    String? risks,
    String? recommendedRole,
    
    String? description,
    String? notes,
    List<String>? imageUrls,
    
    bool? isSubmitting,
    String? errorMessage,
    bool clearError = false,
  }) {
    return CreateReportState(
      playerName: playerName ?? this.playerName,
      playerPosition: playerPosition ?? this.playerPosition,
      playerAge: playerAge ?? this.playerAge,
      playerTeam: playerTeam ?? this.playerTeam,
      
      matchDate: matchDate ?? this.matchDate,
      rivalTeam: rivalTeam ?? this.rivalTeam,
      score: score ?? this.score,
      minutePlayed: minutePlayed ?? this.minutePlayed,
      matchType: matchType ?? this.matchType,
      
      physicalRating: physicalRating ?? this.physicalRating,
      physicalDescription: physicalDescription ?? this.physicalDescription,
      
      technicalRating: technicalRating ?? this.technicalRating,
      technicalDescription: technicalDescription ?? this.technicalDescription,
      
      tacticalRating: tacticalRating ?? this.tacticalRating,
      tacticalDescription: tacticalDescription ?? this.tacticalDescription,
      
      mentalRating: mentalRating ?? this.mentalRating,
      mentalDescription: mentalDescription ?? this.mentalDescription,
      
      overallRating: overallRating ?? this.overallRating,
      potentialRating: potentialRating ?? this.potentialRating,
      
      strengths: strengths ?? this.strengths,
      weaknesses: weaknesses ?? this.weaknesses,
      risks: risks ?? this.risks,
      recommendedRole: recommendedRole ?? this.recommendedRole,
      
      description: description ?? this.description,
      notes: notes ?? this.notes,
      imageUrls: imageUrls ?? this.imageUrls,
      
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class CreateReportViewModel extends Notifier<CreateReportState> {
  @override
  CreateReportState build() => CreateReportState();

  // Player Info
  void updatePlayerName(String v) => state = state.copyWith(playerName: v);
  void updatePlayerPosition(String v) => state = state.copyWith(playerPosition: v);
  void updatePlayerAge(int v) => state = state.copyWith(playerAge: v);
  void updatePlayerTeam(String v) => state = state.copyWith(playerTeam: v);

  // Match Context
  void updateMatchDate(DateTime v) => state = state.copyWith(matchDate: v);
  void updateRivalTeam(String v) => state = state.copyWith(rivalTeam: v);
  void updateScore(String v) => state = state.copyWith(score: v);
  void updateMinutePlayed(int v) => state = state.copyWith(minutePlayed: v);
  void updateMatchType(String v) => state = state.copyWith(matchType: v);

  // Ratings
  void updatePhysicalRating(int v) => state = state.copyWith(physicalRating: v);
  void updatePhysicalDescription(String v) => state = state.copyWith(physicalDescription: v);
  void updateTechnicalRating(int v) => state = state.copyWith(technicalRating: v);
  void updateTechnicalDescription(String v) => state = state.copyWith(technicalDescription: v);
  void updateTacticalRating(int v) => state = state.copyWith(tacticalRating: v);
  void updateTacticalDescription(String v) => state = state.copyWith(tacticalDescription: v);
  void updateMentalRating(int v) => state = state.copyWith(mentalRating: v);
  void updateMentalDescription(String v) => state = state.copyWith(mentalDescription: v);
  void updateOverallRating(double v) => state = state.copyWith(overallRating: v);
  void updatePotentialRating(double v) => state = state.copyWith(potentialRating: v);

  // SWOT
  void updateStrengths(String v) => state = state.copyWith(strengths: v);
  void updateWeaknesses(String v) => state = state.copyWith(weaknesses: v);
  void updateRisks(String v) => state = state.copyWith(risks: v);
  void updateRecommendedRole(String v) => state = state.copyWith(recommendedRole: v);

  // Optional
  void updateDescription(String v) => state = state.copyWith(description: v);
  void updateNotes(String v) => state = state.copyWith(notes: v);

  void addImage(String path) {
    state = state.copyWith(imageUrls: [...state.imageUrls, path]);
  }

  void removeImage(int index) {
    final images = [...state.imageUrls]..removeAt(index);
    state = state.copyWith(imageUrls: images);
  }

  Future<String?> submitReport() async {
    // Check if user is logged in
    final currentUser = supabase.currentUser;
    if (currentUser == null) {
      state = state.copyWith(errorMessage: 'Rapor oluşturmak için giriş yapmalısınız');
      return null;
    }
    
    // Validate required fields
    if (state.playerName.isEmpty) {
      state = state.copyWith(errorMessage: 'Oyuncu adı gerekli');
      return null;
    }
    if (state.playerPosition.isEmpty) {
      state = state.copyWith(errorMessage: 'Oyuncu pozisyonu gerekli');
      return null;
    }
    if (state.playerTeam.isEmpty) {
      state = state.copyWith(errorMessage: 'Oyuncu takımı gerekli');
      return null;
    }
    if (state.rivalTeam.isEmpty) {
      state = state.copyWith(errorMessage: 'Rakip takım gerekli');
      return null;
    }
    
    state = state.copyWith(isSubmitting: true, clearError: true);
    
    try {
      final reportId = const Uuid().v4();
      
      print('📋 Creating report: $reportId');
      print('📋 Scout ID: ${currentUser.id}');
      
      // Create report data matching backend scout_reports table EXACTLY
      final reportData = {
        'id': reportId,
        'scout_id': currentUser.id,
        
        // Player Information (NOT NULL)
        'player_name': state.playerName,
        'player_position': state.playerPosition,
        'player_age': state.playerAge,
        'player_team': state.playerTeam,
        
        // Match Context (NOT NULL)
        'match_date': state.matchDate.toIso8601String(),
        'rival_team': state.rivalTeam,
        'score': state.score,
        'minute_played': state.minutePlayed,
        'match_type': state.matchType,
        
        // Ratings (NOT NULL)
        'physical_rating': state.physicalRating,
        'physical_description': state.physicalDescription.isEmpty ? '-' : state.physicalDescription,
        'technical_rating': state.technicalRating,
        'technical_description': state.technicalDescription.isEmpty ? '-' : state.technicalDescription,
        'tactical_rating': state.tacticalRating,
        'tactical_description': state.tacticalDescription.isEmpty ? '-' : state.tacticalDescription,
        'mental_rating': state.mentalRating,
        'mental_description': state.mentalDescription.isEmpty ? '-' : state.mentalDescription,
        'overall_rating': state.overallRating,
        'potential_rating': state.potentialRating,
        
        // SWOT (NOT NULL)
        'strengths': state.strengths.isEmpty ? '-' : state.strengths,
        'weaknesses': state.weaknesses.isEmpty ? '-' : state.weaknesses,
        'risks': state.risks.isEmpty ? '-' : state.risks,
        'recommended_role': state.recommendedRole.isEmpty ? '-' : state.recommendedRole,
        
        // Optional
        'description': state.description.isEmpty ? null : state.description,
        'notes': state.notes.isEmpty ? null : state.notes,
        'image_urls': state.imageUrls.isEmpty ? null : state.imageUrls,
        
        // Status
        'status': 'submitted',
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      };
      
      print('📋 Report data prepared, inserting...');
      await supabase.client.from('scout_reports').insert(reportData);
      
      state = state.copyWith(isSubmitting: false);
      print('✅ Report saved successfully: $reportId');
      return reportId;
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: 'Rapor kaydedilemedi: $e',
      );
      print('❌ Error saving report: $e');
      return null;
    }
  }
  
  void clearError() => state = state.copyWith(clearError: true);
  void reset() => state = CreateReportState();
}

final createReportProvider = NotifierProvider<CreateReportViewModel, CreateReportState>(() {
  return CreateReportViewModel();
});
