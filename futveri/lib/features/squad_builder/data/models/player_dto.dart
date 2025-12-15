import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/player_entity.dart';
import '../../domain/entities/position.dart';

part 'player_dto.g.dart';

/// Player data transfer object
@JsonSerializable()
class PlayerDto {
  final String id;
  final String name;
  final String nationality;
  @JsonKey(name: 'primary_position')
  final String primaryPosition;
  @JsonKey(name: 'alternative_positions')
  final List<String> alternativePositions;
  @JsonKey(name: 'preferred_foot')
  final String preferredFoot;
  @JsonKey(name: 'photo_url')
  final String? photoUrl;
  final int pace;
  final int shooting;
  final int passing;
  final int dribbling;
  final int defending;
  final int physical;
  final int age;
  final String? club;
  @JsonKey(name: 'jersey_number')
  final int? jerseyNumber;

  PlayerDto({
    required this.id,
    required this.name,
    required this.nationality,
    required this.primaryPosition,
    this.alternativePositions = const [],
    required this.preferredFoot,
    this.photoUrl,
    required this.pace,
    required this.shooting,
    required this.passing,
    required this.dribbling,
    required this.defending,
    required this.physical,
    required this.age,
    this.club,
    this.jerseyNumber,
  });

  /// From JSON
  factory PlayerDto.fromJson(Map<String, dynamic> json) =>
      _$PlayerDtoFromJson(json);

  /// To JSON
  Map<String, dynamic> toJson() => _$PlayerDtoToJson(this);

  /// From entity
  factory PlayerDto.fromEntity(PlayerEntity entity) {
    return PlayerDto(
      id: entity.id,
      name: entity.name,
      nationality: entity.nationality,
      primaryPosition: entity.primaryPosition.code,
      alternativePositions:
          entity.alternativePositions.map((p) => p.code).toList(),
      preferredFoot: entity.preferredFoot.name,
      photoUrl: entity.photoUrl,
      pace: entity.pace,
      shooting: entity.shooting,
      passing: entity.passing,
      dribbling: entity.dribbling,
      defending: entity.defending,
      physical: entity.physical,
      age: entity.age,
      club: entity.club,
      jerseyNumber: entity.jerseyNumber,
    );
  }

  /// To entity
  PlayerEntity toEntity() {
    return PlayerEntity(
      id: id,
      name: name,
      nationality: nationality,
      primaryPosition: _parsePosition(primaryPosition),
      alternativePositions:
          alternativePositions.map(_parsePosition).toList(),
      preferredFoot: _parsePreferredFoot(preferredFoot),
      photoUrl: photoUrl,
      pace: pace,
      shooting: shooting,
      passing: passing,
      dribbling: dribbling,
      defending: defending,
      physical: physical,
      age: age,
      club: club,
      jerseyNumber: jerseyNumber,
    );
  }

  /// Parse position from string
  Position _parsePosition(String code) {
    return Position.values.firstWhere(
      (p) => p.code.toLowerCase() == code.toLowerCase(),
      orElse: () => Position.cm,
    );
  }

  /// Parse preferred foot from string
  PreferredFoot _parsePreferredFoot(String foot) {
    return PreferredFoot.values.firstWhere(
      (f) => f.name.toLowerCase() == foot.toLowerCase(),
      orElse: () => PreferredFoot.right,
    );
  }
}
