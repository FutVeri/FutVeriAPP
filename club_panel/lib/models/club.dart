/// Club model for authenticated club
class Club {
  final String id;
  final String name;
  final String email;
  final String? logoUrl;
  final String? city;
  final String? country;
  final String? league;
  final DateTime createdAt;

  const Club({
    required this.id,
    required this.name,
    required this.email,
    this.logoUrl,
    this.city,
    this.country,
    this.league,
    required this.createdAt,
  });
}

/// Scout model
class Scout {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final String region;
  final int totalReports;
  final int activeAssignments;
  final DateTime joinedAt;
  final bool isActive;

  const Scout({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    required this.region,
    this.totalReports = 0,
    this.activeAssignments = 0,
    required this.joinedAt,
    this.isActive = true,
  });
}

/// Player model
class Player {
  final String id;
  final String name;
  final String? imageUrl;
  final int age;
  final String position;
  final String currentClub;
  final String nationality;
  final double? marketValue;
  final int reportsCount;
  final double? averageRating;

  const Player({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.age,
    required this.position,
    required this.currentClub,
    required this.nationality,
    this.marketValue,
    this.reportsCount = 0,
    this.averageRating,
  });
}
