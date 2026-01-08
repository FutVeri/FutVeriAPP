/// League system data models for FutVeri
/// Models for league members, badges, and league information

/// Badge types for league achievements
enum LeagueBadgeType {
  gold,
  silver,
  bronze,
}

/// Extension for badge display properties
extension LeagueBadgeTypeX on LeagueBadgeType {
  String get displayName {
    switch (this) {
      case LeagueBadgeType.gold:
        return 'Altın';
      case LeagueBadgeType.silver:
        return 'Gümüş';
      case LeagueBadgeType.bronze:
        return 'Bronz';
    }
  }

  String get emoji {
    switch (this) {
      case LeagueBadgeType.gold:
        return '🥇';
      case LeagueBadgeType.silver:
        return '🥈';
      case LeagueBadgeType.bronze:
        return '🥉';
    }
  }

  int get rank {
    switch (this) {
      case LeagueBadgeType.gold:
        return 1;
      case LeagueBadgeType.silver:
        return 2;
      case LeagueBadgeType.bronze:
        return 3;
    }
  }
}

/// League badge earned by a user
class LeagueBadge {
  final String id;
  final LeagueBadgeType type;
  final DateTime earnedAt;
  final String leaguePeriod; // e.g., "Ocak 2026"

  const LeagueBadge({
    required this.id,
    required this.type,
    required this.earnedAt,
    required this.leaguePeriod,
  });

  factory LeagueBadge.fromJson(Map<String, dynamic> json) {
    return LeagueBadge(
      id: json['id'] as String,
      type: LeagueBadgeType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => LeagueBadgeType.bronze,
      ),
      earnedAt: DateTime.parse(json['earned_at'] as String),
      leaguePeriod: json['league_period'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'earned_at': earnedAt.toIso8601String(),
      'league_period': leaguePeriod,
    };
  }
}

/// League member with ranking information
class LeagueMember {
  final String id;
  final String name;
  final String? avatarUrl;
  final int rank;
  final int points;
  final int reportCount;
  final List<LeagueBadge> badges;
  final bool isCurrentUser;

  const LeagueMember({
    required this.id,
    required this.name,
    this.avatarUrl,
    required this.rank,
    required this.points,
    required this.reportCount,
    this.badges = const [],
    this.isCurrentUser = false,
  });

  factory LeagueMember.fromJson(Map<String, dynamic> json) {
    return LeagueMember(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatar_url'] as String?,
      rank: json['rank'] as int,
      points: json['points'] as int,
      reportCount: json['report_count'] as int,
      badges: (json['badges'] as List<dynamic>?)
              ?.map((e) => LeagueBadge.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      isCurrentUser: json['is_current_user'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar_url': avatarUrl,
      'rank': rank,
      'points': points,
      'report_count': reportCount,
      'badges': badges.map((e) => e.toJson()).toList(),
      'is_current_user': isCurrentUser,
    };
  }
}

/// League information with period and members
class League {
  final String id;
  final String name;
  final String period; // e.g., "Ocak 2026"
  final DateTime startDate;
  final DateTime endDate;
  final List<LeagueMember> members;

  const League({
    required this.id,
    required this.name,
    required this.period,
    required this.startDate,
    required this.endDate,
    required this.members,
  });

  /// Get remaining days in the league period
  int get remainingDays {
    final now = DateTime.now();
    if (now.isAfter(endDate)) return 0;
    return endDate.difference(now).inDays;
  }

  /// Get remaining hours (for last day)
  int get remainingHours {
    final now = DateTime.now();
    if (now.isAfter(endDate)) return 0;
    return endDate.difference(now).inHours % 24;
  }

  /// Get top 3 members (podium)
  List<LeagueMember> get podium => members.where((m) => m.rank <= 3).toList();

  /// Get remaining members (4-30)
  List<LeagueMember> get otherMembers => members.where((m) => m.rank > 3).toList();

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['id'] as String,
      name: json['name'] as String,
      period: json['period'] as String,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      members: (json['members'] as List<dynamic>)
          .map((e) => LeagueMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'period': period,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'members': members.map((e) => e.toJson()).toList(),
    };
  }
}
