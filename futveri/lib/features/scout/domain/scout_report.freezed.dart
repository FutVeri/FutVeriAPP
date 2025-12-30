// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scout_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ScoutReport {

 String get id; String get playerId; String get playerName; String get playerPosition; int get playerAge; String get playerTeam;// Match Context
 DateTime get matchDate; String get rivalTeam; String get score; int get minutePlayed; String get matchType;// Stadium, TV, etc.
// Physical
 int get physicalRating; String get physicalDescription;// Technical
 int get technicalRating; String get technicalDescription;// Tactical
 int get tacticalRating; String get tacticalDescription;// Mental
 int get mentalRating; String get mentalDescription;// Overall
 double get overallRating; double get potentialRating;// SWOT
 String get strengths; String get weaknesses; String get risks; String get recommendedRole;// Meta
 String get scoutId; DateTime get createdAt; String get description; List<String> get imageUrls; String get status;
/// Create a copy of ScoutReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScoutReportCopyWith<ScoutReport> get copyWith => _$ScoutReportCopyWithImpl<ScoutReport>(this as ScoutReport, _$identity);

  /// Serializes this ScoutReport to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScoutReport&&(identical(other.id, id) || other.id == id)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.playerName, playerName) || other.playerName == playerName)&&(identical(other.playerPosition, playerPosition) || other.playerPosition == playerPosition)&&(identical(other.playerAge, playerAge) || other.playerAge == playerAge)&&(identical(other.playerTeam, playerTeam) || other.playerTeam == playerTeam)&&(identical(other.matchDate, matchDate) || other.matchDate == matchDate)&&(identical(other.rivalTeam, rivalTeam) || other.rivalTeam == rivalTeam)&&(identical(other.score, score) || other.score == score)&&(identical(other.minutePlayed, minutePlayed) || other.minutePlayed == minutePlayed)&&(identical(other.matchType, matchType) || other.matchType == matchType)&&(identical(other.physicalRating, physicalRating) || other.physicalRating == physicalRating)&&(identical(other.physicalDescription, physicalDescription) || other.physicalDescription == physicalDescription)&&(identical(other.technicalRating, technicalRating) || other.technicalRating == technicalRating)&&(identical(other.technicalDescription, technicalDescription) || other.technicalDescription == technicalDescription)&&(identical(other.tacticalRating, tacticalRating) || other.tacticalRating == tacticalRating)&&(identical(other.tacticalDescription, tacticalDescription) || other.tacticalDescription == tacticalDescription)&&(identical(other.mentalRating, mentalRating) || other.mentalRating == mentalRating)&&(identical(other.mentalDescription, mentalDescription) || other.mentalDescription == mentalDescription)&&(identical(other.overallRating, overallRating) || other.overallRating == overallRating)&&(identical(other.potentialRating, potentialRating) || other.potentialRating == potentialRating)&&(identical(other.strengths, strengths) || other.strengths == strengths)&&(identical(other.weaknesses, weaknesses) || other.weaknesses == weaknesses)&&(identical(other.risks, risks) || other.risks == risks)&&(identical(other.recommendedRole, recommendedRole) || other.recommendedRole == recommendedRole)&&(identical(other.scoutId, scoutId) || other.scoutId == scoutId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.imageUrls, imageUrls)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,playerId,playerName,playerPosition,playerAge,playerTeam,matchDate,rivalTeam,score,minutePlayed,matchType,physicalRating,physicalDescription,technicalRating,technicalDescription,tacticalRating,tacticalDescription,mentalRating,mentalDescription,overallRating,potentialRating,strengths,weaknesses,risks,recommendedRole,scoutId,createdAt,description,const DeepCollectionEquality().hash(imageUrls),status]);

@override
String toString() {
  return 'ScoutReport(id: $id, playerId: $playerId, playerName: $playerName, playerPosition: $playerPosition, playerAge: $playerAge, playerTeam: $playerTeam, matchDate: $matchDate, rivalTeam: $rivalTeam, score: $score, minutePlayed: $minutePlayed, matchType: $matchType, physicalRating: $physicalRating, physicalDescription: $physicalDescription, technicalRating: $technicalRating, technicalDescription: $technicalDescription, tacticalRating: $tacticalRating, tacticalDescription: $tacticalDescription, mentalRating: $mentalRating, mentalDescription: $mentalDescription, overallRating: $overallRating, potentialRating: $potentialRating, strengths: $strengths, weaknesses: $weaknesses, risks: $risks, recommendedRole: $recommendedRole, scoutId: $scoutId, createdAt: $createdAt, description: $description, imageUrls: $imageUrls, status: $status)';
}


}

/// @nodoc
abstract mixin class $ScoutReportCopyWith<$Res>  {
  factory $ScoutReportCopyWith(ScoutReport value, $Res Function(ScoutReport) _then) = _$ScoutReportCopyWithImpl;
@useResult
$Res call({
 String id, String playerId, String playerName, String playerPosition, int playerAge, String playerTeam, DateTime matchDate, String rivalTeam, String score, int minutePlayed, String matchType, int physicalRating, String physicalDescription, int technicalRating, String technicalDescription, int tacticalRating, String tacticalDescription, int mentalRating, String mentalDescription, double overallRating, double potentialRating, String strengths, String weaknesses, String risks, String recommendedRole, String scoutId, DateTime createdAt, String description, List<String> imageUrls, String status
});




}
/// @nodoc
class _$ScoutReportCopyWithImpl<$Res>
    implements $ScoutReportCopyWith<$Res> {
  _$ScoutReportCopyWithImpl(this._self, this._then);

  final ScoutReport _self;
  final $Res Function(ScoutReport) _then;

/// Create a copy of ScoutReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? playerId = null,Object? playerName = null,Object? playerPosition = null,Object? playerAge = null,Object? playerTeam = null,Object? matchDate = null,Object? rivalTeam = null,Object? score = null,Object? minutePlayed = null,Object? matchType = null,Object? physicalRating = null,Object? physicalDescription = null,Object? technicalRating = null,Object? technicalDescription = null,Object? tacticalRating = null,Object? tacticalDescription = null,Object? mentalRating = null,Object? mentalDescription = null,Object? overallRating = null,Object? potentialRating = null,Object? strengths = null,Object? weaknesses = null,Object? risks = null,Object? recommendedRole = null,Object? scoutId = null,Object? createdAt = null,Object? description = null,Object? imageUrls = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,playerName: null == playerName ? _self.playerName : playerName // ignore: cast_nullable_to_non_nullable
as String,playerPosition: null == playerPosition ? _self.playerPosition : playerPosition // ignore: cast_nullable_to_non_nullable
as String,playerAge: null == playerAge ? _self.playerAge : playerAge // ignore: cast_nullable_to_non_nullable
as int,playerTeam: null == playerTeam ? _self.playerTeam : playerTeam // ignore: cast_nullable_to_non_nullable
as String,matchDate: null == matchDate ? _self.matchDate : matchDate // ignore: cast_nullable_to_non_nullable
as DateTime,rivalTeam: null == rivalTeam ? _self.rivalTeam : rivalTeam // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as String,minutePlayed: null == minutePlayed ? _self.minutePlayed : minutePlayed // ignore: cast_nullable_to_non_nullable
as int,matchType: null == matchType ? _self.matchType : matchType // ignore: cast_nullable_to_non_nullable
as String,physicalRating: null == physicalRating ? _self.physicalRating : physicalRating // ignore: cast_nullable_to_non_nullable
as int,physicalDescription: null == physicalDescription ? _self.physicalDescription : physicalDescription // ignore: cast_nullable_to_non_nullable
as String,technicalRating: null == technicalRating ? _self.technicalRating : technicalRating // ignore: cast_nullable_to_non_nullable
as int,technicalDescription: null == technicalDescription ? _self.technicalDescription : technicalDescription // ignore: cast_nullable_to_non_nullable
as String,tacticalRating: null == tacticalRating ? _self.tacticalRating : tacticalRating // ignore: cast_nullable_to_non_nullable
as int,tacticalDescription: null == tacticalDescription ? _self.tacticalDescription : tacticalDescription // ignore: cast_nullable_to_non_nullable
as String,mentalRating: null == mentalRating ? _self.mentalRating : mentalRating // ignore: cast_nullable_to_non_nullable
as int,mentalDescription: null == mentalDescription ? _self.mentalDescription : mentalDescription // ignore: cast_nullable_to_non_nullable
as String,overallRating: null == overallRating ? _self.overallRating : overallRating // ignore: cast_nullable_to_non_nullable
as double,potentialRating: null == potentialRating ? _self.potentialRating : potentialRating // ignore: cast_nullable_to_non_nullable
as double,strengths: null == strengths ? _self.strengths : strengths // ignore: cast_nullable_to_non_nullable
as String,weaknesses: null == weaknesses ? _self.weaknesses : weaknesses // ignore: cast_nullable_to_non_nullable
as String,risks: null == risks ? _self.risks : risks // ignore: cast_nullable_to_non_nullable
as String,recommendedRole: null == recommendedRole ? _self.recommendedRole : recommendedRole // ignore: cast_nullable_to_non_nullable
as String,scoutId: null == scoutId ? _self.scoutId : scoutId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,imageUrls: null == imageUrls ? _self.imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ScoutReport].
extension ScoutReportPatterns on ScoutReport {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScoutReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScoutReport() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScoutReport value)  $default,){
final _that = this;
switch (_that) {
case _ScoutReport():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScoutReport value)?  $default,){
final _that = this;
switch (_that) {
case _ScoutReport() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String playerId,  String playerName,  String playerPosition,  int playerAge,  String playerTeam,  DateTime matchDate,  String rivalTeam,  String score,  int minutePlayed,  String matchType,  int physicalRating,  String physicalDescription,  int technicalRating,  String technicalDescription,  int tacticalRating,  String tacticalDescription,  int mentalRating,  String mentalDescription,  double overallRating,  double potentialRating,  String strengths,  String weaknesses,  String risks,  String recommendedRole,  String scoutId,  DateTime createdAt,  String description,  List<String> imageUrls,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScoutReport() when $default != null:
return $default(_that.id,_that.playerId,_that.playerName,_that.playerPosition,_that.playerAge,_that.playerTeam,_that.matchDate,_that.rivalTeam,_that.score,_that.minutePlayed,_that.matchType,_that.physicalRating,_that.physicalDescription,_that.technicalRating,_that.technicalDescription,_that.tacticalRating,_that.tacticalDescription,_that.mentalRating,_that.mentalDescription,_that.overallRating,_that.potentialRating,_that.strengths,_that.weaknesses,_that.risks,_that.recommendedRole,_that.scoutId,_that.createdAt,_that.description,_that.imageUrls,_that.status);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String playerId,  String playerName,  String playerPosition,  int playerAge,  String playerTeam,  DateTime matchDate,  String rivalTeam,  String score,  int minutePlayed,  String matchType,  int physicalRating,  String physicalDescription,  int technicalRating,  String technicalDescription,  int tacticalRating,  String tacticalDescription,  int mentalRating,  String mentalDescription,  double overallRating,  double potentialRating,  String strengths,  String weaknesses,  String risks,  String recommendedRole,  String scoutId,  DateTime createdAt,  String description,  List<String> imageUrls,  String status)  $default,) {final _that = this;
switch (_that) {
case _ScoutReport():
return $default(_that.id,_that.playerId,_that.playerName,_that.playerPosition,_that.playerAge,_that.playerTeam,_that.matchDate,_that.rivalTeam,_that.score,_that.minutePlayed,_that.matchType,_that.physicalRating,_that.physicalDescription,_that.technicalRating,_that.technicalDescription,_that.tacticalRating,_that.tacticalDescription,_that.mentalRating,_that.mentalDescription,_that.overallRating,_that.potentialRating,_that.strengths,_that.weaknesses,_that.risks,_that.recommendedRole,_that.scoutId,_that.createdAt,_that.description,_that.imageUrls,_that.status);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String playerId,  String playerName,  String playerPosition,  int playerAge,  String playerTeam,  DateTime matchDate,  String rivalTeam,  String score,  int minutePlayed,  String matchType,  int physicalRating,  String physicalDescription,  int technicalRating,  String technicalDescription,  int tacticalRating,  String tacticalDescription,  int mentalRating,  String mentalDescription,  double overallRating,  double potentialRating,  String strengths,  String weaknesses,  String risks,  String recommendedRole,  String scoutId,  DateTime createdAt,  String description,  List<String> imageUrls,  String status)?  $default,) {final _that = this;
switch (_that) {
case _ScoutReport() when $default != null:
return $default(_that.id,_that.playerId,_that.playerName,_that.playerPosition,_that.playerAge,_that.playerTeam,_that.matchDate,_that.rivalTeam,_that.score,_that.minutePlayed,_that.matchType,_that.physicalRating,_that.physicalDescription,_that.technicalRating,_that.technicalDescription,_that.tacticalRating,_that.tacticalDescription,_that.mentalRating,_that.mentalDescription,_that.overallRating,_that.potentialRating,_that.strengths,_that.weaknesses,_that.risks,_that.recommendedRole,_that.scoutId,_that.createdAt,_that.description,_that.imageUrls,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScoutReport implements ScoutReport {
  const _ScoutReport({required this.id, required this.playerId, required this.playerName, required this.playerPosition, required this.playerAge, required this.playerTeam, required this.matchDate, required this.rivalTeam, required this.score, required this.minutePlayed, required this.matchType, required this.physicalRating, required this.physicalDescription, required this.technicalRating, required this.technicalDescription, required this.tacticalRating, required this.tacticalDescription, required this.mentalRating, required this.mentalDescription, required this.overallRating, required this.potentialRating, required this.strengths, required this.weaknesses, required this.risks, required this.recommendedRole, required this.scoutId, required this.createdAt, required this.description, required final  List<String> imageUrls, this.status = 'draft'}): _imageUrls = imageUrls;
  factory _ScoutReport.fromJson(Map<String, dynamic> json) => _$ScoutReportFromJson(json);

@override final  String id;
@override final  String playerId;
@override final  String playerName;
@override final  String playerPosition;
@override final  int playerAge;
@override final  String playerTeam;
// Match Context
@override final  DateTime matchDate;
@override final  String rivalTeam;
@override final  String score;
@override final  int minutePlayed;
@override final  String matchType;
// Stadium, TV, etc.
// Physical
@override final  int physicalRating;
@override final  String physicalDescription;
// Technical
@override final  int technicalRating;
@override final  String technicalDescription;
// Tactical
@override final  int tacticalRating;
@override final  String tacticalDescription;
// Mental
@override final  int mentalRating;
@override final  String mentalDescription;
// Overall
@override final  double overallRating;
@override final  double potentialRating;
// SWOT
@override final  String strengths;
@override final  String weaknesses;
@override final  String risks;
@override final  String recommendedRole;
// Meta
@override final  String scoutId;
@override final  DateTime createdAt;
@override final  String description;
 final  List<String> _imageUrls;
@override List<String> get imageUrls {
  if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_imageUrls);
}

@override@JsonKey() final  String status;

/// Create a copy of ScoutReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScoutReportCopyWith<_ScoutReport> get copyWith => __$ScoutReportCopyWithImpl<_ScoutReport>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScoutReportToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScoutReport&&(identical(other.id, id) || other.id == id)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.playerName, playerName) || other.playerName == playerName)&&(identical(other.playerPosition, playerPosition) || other.playerPosition == playerPosition)&&(identical(other.playerAge, playerAge) || other.playerAge == playerAge)&&(identical(other.playerTeam, playerTeam) || other.playerTeam == playerTeam)&&(identical(other.matchDate, matchDate) || other.matchDate == matchDate)&&(identical(other.rivalTeam, rivalTeam) || other.rivalTeam == rivalTeam)&&(identical(other.score, score) || other.score == score)&&(identical(other.minutePlayed, minutePlayed) || other.minutePlayed == minutePlayed)&&(identical(other.matchType, matchType) || other.matchType == matchType)&&(identical(other.physicalRating, physicalRating) || other.physicalRating == physicalRating)&&(identical(other.physicalDescription, physicalDescription) || other.physicalDescription == physicalDescription)&&(identical(other.technicalRating, technicalRating) || other.technicalRating == technicalRating)&&(identical(other.technicalDescription, technicalDescription) || other.technicalDescription == technicalDescription)&&(identical(other.tacticalRating, tacticalRating) || other.tacticalRating == tacticalRating)&&(identical(other.tacticalDescription, tacticalDescription) || other.tacticalDescription == tacticalDescription)&&(identical(other.mentalRating, mentalRating) || other.mentalRating == mentalRating)&&(identical(other.mentalDescription, mentalDescription) || other.mentalDescription == mentalDescription)&&(identical(other.overallRating, overallRating) || other.overallRating == overallRating)&&(identical(other.potentialRating, potentialRating) || other.potentialRating == potentialRating)&&(identical(other.strengths, strengths) || other.strengths == strengths)&&(identical(other.weaknesses, weaknesses) || other.weaknesses == weaknesses)&&(identical(other.risks, risks) || other.risks == risks)&&(identical(other.recommendedRole, recommendedRole) || other.recommendedRole == recommendedRole)&&(identical(other.scoutId, scoutId) || other.scoutId == scoutId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._imageUrls, _imageUrls)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,playerId,playerName,playerPosition,playerAge,playerTeam,matchDate,rivalTeam,score,minutePlayed,matchType,physicalRating,physicalDescription,technicalRating,technicalDescription,tacticalRating,tacticalDescription,mentalRating,mentalDescription,overallRating,potentialRating,strengths,weaknesses,risks,recommendedRole,scoutId,createdAt,description,const DeepCollectionEquality().hash(_imageUrls),status]);

@override
String toString() {
  return 'ScoutReport(id: $id, playerId: $playerId, playerName: $playerName, playerPosition: $playerPosition, playerAge: $playerAge, playerTeam: $playerTeam, matchDate: $matchDate, rivalTeam: $rivalTeam, score: $score, minutePlayed: $minutePlayed, matchType: $matchType, physicalRating: $physicalRating, physicalDescription: $physicalDescription, technicalRating: $technicalRating, technicalDescription: $technicalDescription, tacticalRating: $tacticalRating, tacticalDescription: $tacticalDescription, mentalRating: $mentalRating, mentalDescription: $mentalDescription, overallRating: $overallRating, potentialRating: $potentialRating, strengths: $strengths, weaknesses: $weaknesses, risks: $risks, recommendedRole: $recommendedRole, scoutId: $scoutId, createdAt: $createdAt, description: $description, imageUrls: $imageUrls, status: $status)';
}


}

/// @nodoc
abstract mixin class _$ScoutReportCopyWith<$Res> implements $ScoutReportCopyWith<$Res> {
  factory _$ScoutReportCopyWith(_ScoutReport value, $Res Function(_ScoutReport) _then) = __$ScoutReportCopyWithImpl;
@override @useResult
$Res call({
 String id, String playerId, String playerName, String playerPosition, int playerAge, String playerTeam, DateTime matchDate, String rivalTeam, String score, int minutePlayed, String matchType, int physicalRating, String physicalDescription, int technicalRating, String technicalDescription, int tacticalRating, String tacticalDescription, int mentalRating, String mentalDescription, double overallRating, double potentialRating, String strengths, String weaknesses, String risks, String recommendedRole, String scoutId, DateTime createdAt, String description, List<String> imageUrls, String status
});




}
/// @nodoc
class __$ScoutReportCopyWithImpl<$Res>
    implements _$ScoutReportCopyWith<$Res> {
  __$ScoutReportCopyWithImpl(this._self, this._then);

  final _ScoutReport _self;
  final $Res Function(_ScoutReport) _then;

/// Create a copy of ScoutReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? playerId = null,Object? playerName = null,Object? playerPosition = null,Object? playerAge = null,Object? playerTeam = null,Object? matchDate = null,Object? rivalTeam = null,Object? score = null,Object? minutePlayed = null,Object? matchType = null,Object? physicalRating = null,Object? physicalDescription = null,Object? technicalRating = null,Object? technicalDescription = null,Object? tacticalRating = null,Object? tacticalDescription = null,Object? mentalRating = null,Object? mentalDescription = null,Object? overallRating = null,Object? potentialRating = null,Object? strengths = null,Object? weaknesses = null,Object? risks = null,Object? recommendedRole = null,Object? scoutId = null,Object? createdAt = null,Object? description = null,Object? imageUrls = null,Object? status = null,}) {
  return _then(_ScoutReport(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,playerName: null == playerName ? _self.playerName : playerName // ignore: cast_nullable_to_non_nullable
as String,playerPosition: null == playerPosition ? _self.playerPosition : playerPosition // ignore: cast_nullable_to_non_nullable
as String,playerAge: null == playerAge ? _self.playerAge : playerAge // ignore: cast_nullable_to_non_nullable
as int,playerTeam: null == playerTeam ? _self.playerTeam : playerTeam // ignore: cast_nullable_to_non_nullable
as String,matchDate: null == matchDate ? _self.matchDate : matchDate // ignore: cast_nullable_to_non_nullable
as DateTime,rivalTeam: null == rivalTeam ? _self.rivalTeam : rivalTeam // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as String,minutePlayed: null == minutePlayed ? _self.minutePlayed : minutePlayed // ignore: cast_nullable_to_non_nullable
as int,matchType: null == matchType ? _self.matchType : matchType // ignore: cast_nullable_to_non_nullable
as String,physicalRating: null == physicalRating ? _self.physicalRating : physicalRating // ignore: cast_nullable_to_non_nullable
as int,physicalDescription: null == physicalDescription ? _self.physicalDescription : physicalDescription // ignore: cast_nullable_to_non_nullable
as String,technicalRating: null == technicalRating ? _self.technicalRating : technicalRating // ignore: cast_nullable_to_non_nullable
as int,technicalDescription: null == technicalDescription ? _self.technicalDescription : technicalDescription // ignore: cast_nullable_to_non_nullable
as String,tacticalRating: null == tacticalRating ? _self.tacticalRating : tacticalRating // ignore: cast_nullable_to_non_nullable
as int,tacticalDescription: null == tacticalDescription ? _self.tacticalDescription : tacticalDescription // ignore: cast_nullable_to_non_nullable
as String,mentalRating: null == mentalRating ? _self.mentalRating : mentalRating // ignore: cast_nullable_to_non_nullable
as int,mentalDescription: null == mentalDescription ? _self.mentalDescription : mentalDescription // ignore: cast_nullable_to_non_nullable
as String,overallRating: null == overallRating ? _self.overallRating : overallRating // ignore: cast_nullable_to_non_nullable
as double,potentialRating: null == potentialRating ? _self.potentialRating : potentialRating // ignore: cast_nullable_to_non_nullable
as double,strengths: null == strengths ? _self.strengths : strengths // ignore: cast_nullable_to_non_nullable
as String,weaknesses: null == weaknesses ? _self.weaknesses : weaknesses // ignore: cast_nullable_to_non_nullable
as String,risks: null == risks ? _self.risks : risks // ignore: cast_nullable_to_non_nullable
as String,recommendedRole: null == recommendedRole ? _self.recommendedRole : recommendedRole // ignore: cast_nullable_to_non_nullable
as String,scoutId: null == scoutId ? _self.scoutId : scoutId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,imageUrls: null == imageUrls ? _self._imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
