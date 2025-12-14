import '../../domain/entities/team_entity.dart';

/// Team DTO for JSON serialization
class TeamDto {
  final String id;
  final String name;
  final String? logo;
  final String? formation;

  TeamDto({
    required this.id,
    required this.name,
    this.logo,
    this.formation,
  });

  factory TeamDto.fromJson(Map<String, dynamic> json) {
    return TeamDto(
      id: json['id'] as String,
      name: json['name'] as String,
      logo: json['logo'] as String?,
      formation: json['formation'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
      'formation': formation,
    };
  }

  TeamEntity toEntity() {
    return TeamEntity(
      id: id,
      name: name,
      logo: logo,
      formation: formation,
    );
  }

  factory TeamDto.fromEntity(TeamEntity entity) {
    return TeamDto(
      id: entity.id,
      name: entity.name,
      logo: entity.logo,
      formation: entity.formation,
    );
  }
}
