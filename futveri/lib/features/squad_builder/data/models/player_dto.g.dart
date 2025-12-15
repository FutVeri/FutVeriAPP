// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerDto _$PlayerDtoFromJson(Map<String, dynamic> json) => PlayerDto(
      id: json['id'] as String,
      name: json['name'] as String,
      nationality: json['nationality'] as String,
      primaryPosition: json['primary_position'] as String,
      alternativePositions: (json['alternative_positions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      preferredFoot: json['preferred_foot'] as String,
      photoUrl: json['photo_url'] as String?,
      pace: (json['pace'] as num).toInt(),
      shooting: (json['shooting'] as num).toInt(),
      passing: (json['passing'] as num).toInt(),
      dribbling: (json['dribbling'] as num).toInt(),
      defending: (json['defending'] as num).toInt(),
      physical: (json['physical'] as num).toInt(),
      age: (json['age'] as num).toInt(),
      club: json['club'] as String?,
      jerseyNumber: (json['jersey_number'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PlayerDtoToJson(PlayerDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nationality': instance.nationality,
      'primary_position': instance.primaryPosition,
      'alternative_positions': instance.alternativePositions,
      'preferred_foot': instance.preferredFoot,
      'photo_url': instance.photoUrl,
      'pace': instance.pace,
      'shooting': instance.shooting,
      'passing': instance.passing,
      'dribbling': instance.dribbling,
      'defending': instance.defending,
      'physical': instance.physical,
      'age': instance.age,
      'club': instance.club,
      'jersey_number': instance.jerseyNumber,
    };
