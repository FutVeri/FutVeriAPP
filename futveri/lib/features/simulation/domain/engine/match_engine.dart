/// Match Engine for 2D FM-style match simulation
/// Handles real-time match progression, events, and player movements

import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import '../models/match_simulation_models.dart';
import '../models/simulation_models.dart';
import '../models/weekly_matches_mock.dart';

/// Match engine controller that handles simulation
class MatchEngine extends ChangeNotifier {
  MatchState? _state;
  Timer? _timer;
  final Random _random = Random();
  
  MatchState? get state => _state;
  bool get isRunning => _timer?.isActive ?? false;
  
  /// Initialize match with teams and user's team choice
  void initializeMatch({
    required WeeklyMatch match,
    required String userTeamId,
  }) {
    _state = MatchState(
      matchId: match.id,
      homeTeam: match.homeTeam,
      awayTeam: match.awayTeam,
      userTeamId: userTeamId,
      minute: 0,
      homePositions: WeeklyMatchesMock.getHomeFormationPositions(match.homeTeam),
      awayPositions: WeeklyMatchesMock.getAwayFormationPositions(match.awayTeam),
      isPlaying: false,
    );
    notifyListeners();
  }
  
  /// Start or resume the match
  void startMatch() {
    if (_state == null) return;
    
    _state = _state!.copyWith(isPlaying: true);
    
    // Add kickoff event if minute is 0
    if (_state!.minute == 0) {
      _addEvent(MatchEventType.kickoff, _state!.homeTeam.id, 'Maç başladı!');
    }
    
    // 1 second = 1 minute of match time
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
    notifyListeners();
  }
  
  /// Pause the match
  void pauseMatch() {
    _timer?.cancel();
    if (_state != null) {
      _state = _state!.copyWith(isPlaying: false);
    }
    notifyListeners();
  }
  
  /// Resume match after pause
  void resumeMatch() {
    startMatch();
  }
  
  /// Apply tactical intervention
  void applyIntervention(TacticalIntervention intervention) {
    if (_state == null) return;
    
    switch (intervention.type) {
      case 'mentality':
        _state = _state!.copyWith(currentTactic: intervention.mentality);
        _addEvent(
          MatchEventType.possession, 
          _state!.userTeamId, 
          'Taktik değişikliği: ${_getMentalityName(intervention.mentality)}'
        );
        break;
      case 'substitution':
        _addEvent(
          MatchEventType.substitution,
          _state!.userTeamId,
          'Oyuncu değişikliği yapıldı',
        );
        break;
      case 'formation':
        _addEvent(
          MatchEventType.possession,
          _state!.userTeamId,
          'Formasyon: ${intervention.newFormation}',
        );
        break;
    }
    
    notifyListeners();
  }
  
  String _getMentalityName(String? mentality) {
    switch (mentality) {
      case 'defensive': return 'Defansif';
      case 'attacking': return 'Hücum';
      default: return 'Dengeli';
    }
  }
  
  /// Clean up
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  
  /// Main tick function - called every second (1 sec = 1 match minute)
  void _tick() {
    if (_state == null) return;
    
    final newMinute = _state!.minute + 1;
    
    // Check for half time
    if (newMinute == 45 && !_state!.isHalfTime) {
      pauseMatch();
      _state = _state!.copyWith(
        minute: 45,
        isHalfTime: true,
      );
      _addEvent(MatchEventType.halfTime, '', 'İlk yarı sona erdi');
      notifyListeners();
      return;
    }
    
    // Check for full time
    if (newMinute >= 90) {
      pauseMatch();
      _state = _state!.copyWith(
        minute: 90,
        isFullTime: true,
      );
      _addEvent(MatchEventType.fullTime, '', 'Maç sona erdi!');
      notifyListeners();
      return;
    }
    
    // Update minute
    _state = _state!.copyWith(minute: newMinute);
    
    // Generate random events
    _generateRandomEvents();
    
    // Update player positions randomly
    _updatePlayerPositions();
    
    // Update possession
    _updatePossession();
    
    notifyListeners();
  }
  
  /// Generate random match events based on probabilities
  void _generateRandomEvents() {
    if (_state == null) return;
    
    final roll = _random.nextDouble() * 100;
    
    // Adjust probabilities based on team strengths
    final homeStrength = _state!.homeTeam.overallRating;
    final awayStrength = _state!.awayTeam.overallRating;
    final homeBias = homeStrength / (homeStrength + awayStrength);
    
    final isHomeEvent = _random.nextDouble() < homeBias;
    final teamId = isHomeEvent ? _state!.homeTeam.id : _state!.awayTeam.id;
    final team = isHomeEvent ? _state!.homeTeam : _state!.awayTeam;
    
    // Event probabilities per minute
    if (roll < 1.5) {
      // GOAL! (1.5% chance per minute ≈ 2.7 goals per match)
      _handleGoal(isHomeEvent, team);
    } else if (roll < 4) {
      // Shot on target
      _handleShotOnTarget(isHomeEvent, team);
    } else if (roll < 8) {
      // Shot off target
      _handleShot(isHomeEvent, team);
    } else if (roll < 12) {
      // Foul
      _handleFoul(isHomeEvent, team);
    } else if (roll < 13) {
      // Yellow card
      _handleYellowCard(isHomeEvent, team);
    } else if (roll < 13.1) {
      // Red card (very rare)
      _handleRedCard(isHomeEvent, team);
    } else if (roll < 15) {
      // Corner
      _handleCorner(isHomeEvent, team);
    }
  }
  
  void _handleGoal(bool isHome, SimulationTeam team) {
    final scorer = team.players.where((p) => p.position != 'GK').toList();
    final goalScorer = scorer.isNotEmpty 
        ? scorer[_random.nextInt(scorer.length)]
        : null;
    
    _state = _state!.copyWith(
      homeScore: isHome ? _state!.homeScore + 1 : _state!.homeScore,
      awayScore: !isHome ? _state!.awayScore + 1 : _state!.awayScore,
    );
    
    _addEvent(
      MatchEventType.goal,
      team.id,
      '⚽ GOL! ${goalScorer?.name ?? team.name}',
      playerId: goalScorer?.id,
      playerName: goalScorer?.name,
    );
  }
  
  void _handleShotOnTarget(bool isHome, SimulationTeam team) {
    _state = _state!.copyWith(
      homeShotsOnTarget: isHome ? _state!.homeShotsOnTarget + 1 : _state!.homeShotsOnTarget,
      awayShotsOnTarget: !isHome ? _state!.awayShotsOnTarget + 1 : _state!.awayShotsOnTarget,
      homeShots: isHome ? _state!.homeShots + 1 : _state!.homeShots,
      awayShots: !isHome ? _state!.awayShots + 1 : _state!.awayShots,
    );
    
    _addEvent(MatchEventType.shotOnTarget, team.id, '${team.shortName} kaleyi yokladı');
  }
  
  void _handleShot(bool isHome, SimulationTeam team) {
    _state = _state!.copyWith(
      homeShots: isHome ? _state!.homeShots + 1 : _state!.homeShots,
      awayShots: !isHome ? _state!.awayShots + 1 : _state!.awayShots,
    );
    
    _addEvent(MatchEventType.shot, team.id, '${team.shortName} şut çekti, auta gitti');
  }
  
  void _handleFoul(bool isHome, SimulationTeam team) {
    _state = _state!.copyWith(
      homeFouls: isHome ? _state!.homeFouls + 1 : _state!.homeFouls,
      awayFouls: !isHome ? _state!.awayFouls + 1 : _state!.awayFouls,
    );
  }
  
  void _handleYellowCard(bool isHome, SimulationTeam team) {
    final players = team.players;
    final player = players.isNotEmpty ? players[_random.nextInt(players.length)] : null;
    
    _state = _state!.copyWith(
      homeYellowCards: isHome ? _state!.homeYellowCards + 1 : _state!.homeYellowCards,
      awayYellowCards: !isHome ? _state!.awayYellowCards + 1 : _state!.awayYellowCards,
    );
    
    _addEvent(
      MatchEventType.yellowCard,
      team.id,
      '🟨 Sarı kart: ${player?.name ?? "Oyuncu"}',
      playerId: player?.id,
      playerName: player?.name,
    );
  }
  
  void _handleRedCard(bool isHome, SimulationTeam team) {
    final players = team.players;
    final player = players.isNotEmpty ? players[_random.nextInt(players.length)] : null;
    
    _state = _state!.copyWith(
      homeRedCards: isHome ? _state!.homeRedCards + 1 : _state!.homeRedCards,
      awayRedCards: !isHome ? _state!.awayRedCards + 1 : _state!.awayRedCards,
    );
    
    _addEvent(
      MatchEventType.redCard,
      team.id,
      '🟥 Kırmızı kart: ${player?.name ?? "Oyuncu"}',
      playerId: player?.id,
      playerName: player?.name,
    );
  }
  
  void _handleCorner(bool isHome, SimulationTeam team) {
    _state = _state!.copyWith(
      homeCorners: isHome ? _state!.homeCorners + 1 : _state!.homeCorners,
      awayCorners: !isHome ? _state!.awayCorners + 1 : _state!.awayCorners,
    );
    
    _addEvent(MatchEventType.corner, team.id, '${team.shortName} korner kazandı');
  }
  
  void _updatePossession() {
    if (_state == null) return;
    
    // Slightly random possession changes
    final change = (_random.nextDouble() - 0.5) * 3;
    var newPossession = (_state!.homePossession + change).clamp(30.0, 70.0);
    
    _state = _state!.copyWith(homePossession: newPossession);
  }
  
  void _updatePlayerPositions() {
    if (_state == null) return;
    
    // Update home positions with small random movements
    final newHomePositions = _state!.homePositions.map((p) {
      final dx = (_random.nextDouble() - 0.5) * 5;
      final dy = (_random.nextDouble() - 0.5) * 5;
      return p.copyWith(
        x: (p.x + dx).clamp(0.0, 100.0),
        y: (p.y + dy).clamp(0.0, 100.0),
      );
    }).toList();
    
    // Update away positions
    final newAwayPositions = _state!.awayPositions.map((p) {
      final dx = (_random.nextDouble() - 0.5) * 5;
      final dy = (_random.nextDouble() - 0.5) * 5;
      return p.copyWith(
        x: (p.x + dx).clamp(0.0, 100.0),
        y: (p.y + dy).clamp(0.0, 100.0),
      );
    }).toList();
    
    _state = _state!.copyWith(
      homePositions: newHomePositions,
      awayPositions: newAwayPositions,
    );
  }
  
  void _addEvent(MatchEventType type, String teamId, String description, {String? playerId, String? playerName}) {
    if (_state == null) return;
    
    final event = MatchEvent(
      minute: _state!.minute,
      type: type,
      teamId: teamId,
      description: description,
      timestamp: DateTime.now(),
      playerId: playerId,
      playerName: playerName,
    );
    
    final newEvents = [..._state!.events, event];
    _state = _state!.copyWith(events: newEvents);
  }
}
