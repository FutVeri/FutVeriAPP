import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futveri/features/scout/domain/scout_report.dart';
import 'package:uuid/uuid.dart';

// State for the Create Report Form
class CreateReportState {
  final String playerName;
  final String playerPosition;
  final String rivalTeam;
  
  // Physical
  final int physicalRating;
  final String physicalDescription;
  
  // Technical
  final int technicalRating;
  final String technicalDescription;
  
  // Tactical
  final int tacticalRating;
  final String tacticalDescription;
  
  // Mental
  final int mentalRating;
  final String mentalDescription;
  
  // Overall
  final double overallRating;
  final double potentialRating;

  final List<String> selectedImagePaths;
  final bool isSubmitting;

  CreateReportState({
    this.playerName = '',
    this.playerPosition = '',
    this.rivalTeam = '',
    
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

    this.selectedImagePaths = const [],
    this.isSubmitting = false,
  });

  CreateReportState copyWith({
    String? playerName,
    String? playerPosition,
    String? rivalTeam,
    
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

    List<String>? selectedImagePaths,
    bool? isSubmitting,
  }) {
    return CreateReportState(
      playerName: playerName ?? this.playerName,
      playerPosition: playerPosition ?? this.playerPosition,
      rivalTeam: rivalTeam ?? this.rivalTeam,
      
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

      selectedImagePaths: selectedImagePaths ?? this.selectedImagePaths,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}

class CreateReportViewModel extends Notifier<CreateReportState> {
  @override
  CreateReportState build() {
    return CreateReportState();
  }

  void updatePlayerName(String name) {
    state = state.copyWith(playerName: name);
  }

  void updatePhysicalRating(int value) {
    state = state.copyWith(physicalRating: value);
  }
  
  void updatePhysicalDescription(String value) {
    state = state.copyWith(physicalDescription: value);
  }

  void updateTechnicalRating(int value) {
    state = state.copyWith(technicalRating: value);
  }
  
  void updateTechnicalDescription(String value) {
    state = state.copyWith(technicalDescription: value);
  }

  void updateTacticalRating(int value) {
    state = state.copyWith(tacticalRating: value);
  }
  
  void updateTacticalDescription(String value) {
    state = state.copyWith(tacticalDescription: value);
  }

  void updateMentalRating(int value) {
    state = state.copyWith(mentalRating: value);
  }
  
  void updateMentalDescription(String value) {
    state = state.copyWith(mentalDescription: value);
  }

  void updateOverallRating(double value) {
    state = state.copyWith(overallRating: value);
  }
  
  void updatePotentialRating(double value) {
    state = state.copyWith(potentialRating: value);
  }

  void addImage(String path) {
    state = state.copyWith(
      selectedImagePaths: [...state.selectedImagePaths, path],
    );
  }

  void removeImage(int index) {
    final images = [...state.selectedImagePaths];
    images.removeAt(index);
    state = state.copyWith(selectedImagePaths: images);
  }

  Future<String?> submitReport() async {
    state = state.copyWith(isSubmitting: true);
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    // Here we would construct the ScoutReport object and save it
    // Example:
    /*
    final report = ScoutReport(
      // ... IDs ...
      physicalRating: state.physicalRating,
      physicalDescription: state.physicalDescription,
      // ... etc
    );
    */
    
    state = state.copyWith(isSubmitting: false);
    return '123'; // Return mock ID
  }
}

final createReportProvider = NotifierProvider<CreateReportViewModel, CreateReportState>(() {
  return CreateReportViewModel();
});
