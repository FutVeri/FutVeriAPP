/// Rating details for scout reports
class RatingDetails {
  final int value;
  final String description;

  const RatingDetails({
    required this.value,
    required this.description,
  });
}

/// Scout report model
class ScoutReport {
  final String id;
  final String playerName;
  final String? playerImage;
  final String scoutName;
  final String scoutId;
  final int playerAge;
  final String position;
  final String currentClub;
  final DateTime createdAt;
  final ReportStatus status;
  final RatingDetails physical;
  final RatingDetails technical;
  final RatingDetails tactical;
  final RatingDetails mental;
  final RatingDetails overall;
  final RatingDetails potential;
  final String? notes;

  const ScoutReport({
    required this.id,
    required this.playerName,
    this.playerImage,
    required this.scoutName,
    required this.scoutId,
    required this.playerAge,
    required this.position,
    required this.currentClub,
    required this.createdAt,
    required this.status,
    required this.physical,
    required this.technical,
    required this.tactical,
    required this.mental,
    required this.overall,
    required this.potential,
    this.notes,
  });
}

enum ReportStatus {
  pending,
  approved,
  rejected,
}

extension ReportStatusExtension on ReportStatus {
  String get displayName {
    switch (this) {
      case ReportStatus.pending:
        return 'Beklemede';
      case ReportStatus.approved:
        return 'Onaylandı';
      case ReportStatus.rejected:
        return 'Reddedildi';
    }
  }
}
