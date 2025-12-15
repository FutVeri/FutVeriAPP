// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'squad_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SquadDto _$SquadDtoFromJson(Map<String, dynamic> json) => SquadDto(
      id: json['id'] as String,
      name: json['name'] as String,
      formationId: json['formation_id'] as String,
      lineup: Map<String, String?>.from(json['lineup'] as Map),
      benchIds: (json['bench_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$SquadDtoToJson(SquadDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'formation_id': instance.formationId,
      'lineup': instance.lineup,
      'bench_ids': instance.benchIds,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
