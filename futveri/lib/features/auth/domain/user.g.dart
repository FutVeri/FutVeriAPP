// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: json['id'] as String,
  email: json['email'] as String,
  name: json['name'] as String,
  avatarUrl: json['avatarUrl'] as String?,
  role: json['role'] as String,
  isActive: json['isActive'] as bool,
  isVerified: json['isVerified'] as bool,
  region: json['region'] as String?,
  clubName: json['clubName'] as String?,
  clubLogoUrl: json['clubLogoUrl'] as String?,
  city: json['city'] as String?,
  country: json['country'] as String?,
  league: json['league'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  lastActiveAt: json['lastActiveAt'] == null
      ? null
      : DateTime.parse(json['lastActiveAt'] as String),
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'name': instance.name,
  'avatarUrl': instance.avatarUrl,
  'role': instance.role,
  'isActive': instance.isActive,
  'isVerified': instance.isVerified,
  'region': instance.region,
  'clubName': instance.clubName,
  'clubLogoUrl': instance.clubLogoUrl,
  'city': instance.city,
  'country': instance.country,
  'league': instance.league,
  'createdAt': instance.createdAt.toIso8601String(),
  'lastActiveAt': instance.lastActiveAt?.toIso8601String(),
};

_AuthTokens _$AuthTokensFromJson(Map<String, dynamic> json) => _AuthTokens(
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String,
  tokenType: json['tokenType'] as String? ?? 'bearer',
);

Map<String, dynamic> _$AuthTokensToJson(_AuthTokens instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'tokenType': instance.tokenType,
    };

_LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) =>
    _LoginRequest(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginRequestToJson(_LoginRequest instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};

_RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    _RegisterRequest(
      email: json['email'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      role: json['role'] as String? ?? 'user',
      region: json['region'] as String?,
    );

Map<String, dynamic> _$RegisterRequestToJson(_RegisterRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'role': instance.role,
      'region': instance.region,
    };
