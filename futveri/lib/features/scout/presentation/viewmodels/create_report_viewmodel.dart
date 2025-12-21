import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futveri/features/scout/domain/scout_report.dart';
import 'package:uuid/uuid.dart';

// State for the Create Report Form
class CreateReportState {
  final String playerName;
  final String playerPosition;
  final String rivalTeam;
  final Map<String, int> ratings;
  final bool isSubmitting;

  CreateReportState({
    this.playerName = '',
    this.playerPosition = '',
    this.rivalTeam = '',
    this.ratings = const {
      'Technique': 5,
      'Pace': 5,
      'Passing': 5,
      'Dribbling': 5,
      'Defense': 5,
      'Physicality': 5,
      'Heading': 5,
      'Finishing': 5,
      'Vision': 5,
      'Aggression': 5,
    },
    this.isSubmitting = false,
  });

  CreateReportState copyWith({
    String? playerName,
    String? playerPosition,
    String? rivalTeam,
    Map<String, int>? ratings,
    bool? isSubmitting,
  }) {
    return CreateReportState(
      playerName: playerName ?? this.playerName,
      playerPosition: playerPosition ?? this.playerPosition,
      rivalTeam: rivalTeam ?? this.rivalTeam,
      ratings: ratings ?? this.ratings,
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

  void updateRating(String parameter, int value) {
    final newRatings = Map<String, int>.from(state.ratings);
    newRatings[parameter] = value;
    state = state.copyWith(ratings: newRatings);
  }

  Future<String?> submitReport() async {
    state = state.copyWith(isSubmitting: true);
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    // Here we would construct the ScoutReport object and save it
    
    state = state.copyWith(isSubmitting: false);
    return '123'; // Return mock ID
  }
}

final createReportProvider = NotifierProvider<CreateReportViewModel, CreateReportState>(() {
  return CreateReportViewModel();
});
