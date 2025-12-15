import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/squad_entity.dart';
import '../../domain/entities/formation_entity.dart';
import '../../domain/entities/position.dart';
import '../../domain/entities/player_entity.dart';
import 'player_dto.dart';

part 'squad_dto.g.dart';

/// Squad data transfer object
@JsonSerializable()
class SquadDto {
  final String id;
  final String name;
  @JsonKey(name: 'formation_id')
  final String formationId;
  final Map<String, String?> lineup; // Position code -> Player ID
  @JsonKey(name: 'bench_ids')
  final List<String> benchIds;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  SquadDto({
    required this.id,
    required this.name,
    required this.formationId,
    required this.lineup,
    this.benchIds = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  /// From JSON
  factory SquadDto.fromJson(Map<String, dynamic> json) =>
      _$SquadDtoFromJson(json);

  /// To JSON
  Map<String, dynamic> toJson() => _$SquadDtoToJson(this);

  /// From entity
  factory SquadDto.fromEntity(SquadEntity entity) {
    final lineupMap = <String, String?>{};
    
    entity.lineup.forEach((position, player) {
      lineupMap[position.code] = player?.id;
    });

    return SquadDto(
      id: entity.id,
      name: entity.name,
      formationId: entity.formation.id,
      lineup: lineupMap,
      benchIds: entity.bench.map((p) => p.id).toList(),
      createdAt: entity.createdAt.toIso8601String(),
      updatedAt: entity.updatedAt.toIso8601String(),
    );
  }

  /// To entity (requires formation and players)
  SquadEntity toEntity({
    required FormationEntity formation,
    required Map<String, PlayerDto> playersById,
  }) {
    final lineupMap = <Position, PlayerEntity?>{};
    
    lineup.forEach((positionCode, playerId) {
      final position = Position.values.firstWhere(
        (p) => p.code.toLowerCase() == positionCode.toLowerCase(),
        orElse: () => Position.cm,
      );
      
      final player = playerId != null ? playersById[playerId]?.toEntity() : null;
      lineupMap[position] = player;
    });

    final benchPlayers = benchIds
        .map((id) => playersById[id]?.toEntity())
        .whereType<PlayerEntity>()
        .toList();

    return SquadEntity(
      id: id,
      name: name,
      formation: formation,
      lineup: lineupMap,
      bench: benchPlayers,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
    );
  }
}
