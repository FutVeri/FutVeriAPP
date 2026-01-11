// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_analysis.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MatchAnalysis {

 String get id; String get userId; String get homeTeam; String get awayTeam; String get scorePrediction; String get analysisContent; DateTime get matchDate; DateTime get createdAt;
/// Create a copy of MatchAnalysis
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchAnalysisCopyWith<MatchAnalysis> get copyWith => _$MatchAnalysisCopyWithImpl<MatchAnalysis>(this as MatchAnalysis, _$identity);

  /// Serializes this MatchAnalysis to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchAnalysis&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.homeTeam, homeTeam) || other.homeTeam == homeTeam)&&(identical(other.awayTeam, awayTeam) || other.awayTeam == awayTeam)&&(identical(other.scorePrediction, scorePrediction) || other.scorePrediction == scorePrediction)&&(identical(other.analysisContent, analysisContent) || other.analysisContent == analysisContent)&&(identical(other.matchDate, matchDate) || other.matchDate == matchDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,homeTeam,awayTeam,scorePrediction,analysisContent,matchDate,createdAt);

@override
String toString() {
  return 'MatchAnalysis(id: $id, userId: $userId, homeTeam: $homeTeam, awayTeam: $awayTeam, scorePrediction: $scorePrediction, analysisContent: $analysisContent, matchDate: $matchDate, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $MatchAnalysisCopyWith<$Res>  {
  factory $MatchAnalysisCopyWith(MatchAnalysis value, $Res Function(MatchAnalysis) _then) = _$MatchAnalysisCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String homeTeam, String awayTeam, String scorePrediction, String analysisContent, DateTime matchDate, DateTime createdAt
});




}
/// @nodoc
class _$MatchAnalysisCopyWithImpl<$Res>
    implements $MatchAnalysisCopyWith<$Res> {
  _$MatchAnalysisCopyWithImpl(this._self, this._then);

  final MatchAnalysis _self;
  final $Res Function(MatchAnalysis) _then;

/// Create a copy of MatchAnalysis
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? homeTeam = null,Object? awayTeam = null,Object? scorePrediction = null,Object? analysisContent = null,Object? matchDate = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,homeTeam: null == homeTeam ? _self.homeTeam : homeTeam // ignore: cast_nullable_to_non_nullable
as String,awayTeam: null == awayTeam ? _self.awayTeam : awayTeam // ignore: cast_nullable_to_non_nullable
as String,scorePrediction: null == scorePrediction ? _self.scorePrediction : scorePrediction // ignore: cast_nullable_to_non_nullable
as String,analysisContent: null == analysisContent ? _self.analysisContent : analysisContent // ignore: cast_nullable_to_non_nullable
as String,matchDate: null == matchDate ? _self.matchDate : matchDate // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [MatchAnalysis].
extension MatchAnalysisPatterns on MatchAnalysis {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchAnalysis value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchAnalysis() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchAnalysis value)  $default,){
final _that = this;
switch (_that) {
case _MatchAnalysis():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchAnalysis value)?  $default,){
final _that = this;
switch (_that) {
case _MatchAnalysis() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String homeTeam,  String awayTeam,  String scorePrediction,  String analysisContent,  DateTime matchDate,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchAnalysis() when $default != null:
return $default(_that.id,_that.userId,_that.homeTeam,_that.awayTeam,_that.scorePrediction,_that.analysisContent,_that.matchDate,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String homeTeam,  String awayTeam,  String scorePrediction,  String analysisContent,  DateTime matchDate,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _MatchAnalysis():
return $default(_that.id,_that.userId,_that.homeTeam,_that.awayTeam,_that.scorePrediction,_that.analysisContent,_that.matchDate,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String homeTeam,  String awayTeam,  String scorePrediction,  String analysisContent,  DateTime matchDate,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _MatchAnalysis() when $default != null:
return $default(_that.id,_that.userId,_that.homeTeam,_that.awayTeam,_that.scorePrediction,_that.analysisContent,_that.matchDate,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _MatchAnalysis implements MatchAnalysis {
  const _MatchAnalysis({required this.id, required this.userId, required this.homeTeam, required this.awayTeam, required this.scorePrediction, required this.analysisContent, required this.matchDate, required this.createdAt});
  factory _MatchAnalysis.fromJson(Map<String, dynamic> json) => _$MatchAnalysisFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String homeTeam;
@override final  String awayTeam;
@override final  String scorePrediction;
@override final  String analysisContent;
@override final  DateTime matchDate;
@override final  DateTime createdAt;

/// Create a copy of MatchAnalysis
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchAnalysisCopyWith<_MatchAnalysis> get copyWith => __$MatchAnalysisCopyWithImpl<_MatchAnalysis>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchAnalysisToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchAnalysis&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.homeTeam, homeTeam) || other.homeTeam == homeTeam)&&(identical(other.awayTeam, awayTeam) || other.awayTeam == awayTeam)&&(identical(other.scorePrediction, scorePrediction) || other.scorePrediction == scorePrediction)&&(identical(other.analysisContent, analysisContent) || other.analysisContent == analysisContent)&&(identical(other.matchDate, matchDate) || other.matchDate == matchDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,homeTeam,awayTeam,scorePrediction,analysisContent,matchDate,createdAt);

@override
String toString() {
  return 'MatchAnalysis(id: $id, userId: $userId, homeTeam: $homeTeam, awayTeam: $awayTeam, scorePrediction: $scorePrediction, analysisContent: $analysisContent, matchDate: $matchDate, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$MatchAnalysisCopyWith<$Res> implements $MatchAnalysisCopyWith<$Res> {
  factory _$MatchAnalysisCopyWith(_MatchAnalysis value, $Res Function(_MatchAnalysis) _then) = __$MatchAnalysisCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String homeTeam, String awayTeam, String scorePrediction, String analysisContent, DateTime matchDate, DateTime createdAt
});




}
/// @nodoc
class __$MatchAnalysisCopyWithImpl<$Res>
    implements _$MatchAnalysisCopyWith<$Res> {
  __$MatchAnalysisCopyWithImpl(this._self, this._then);

  final _MatchAnalysis _self;
  final $Res Function(_MatchAnalysis) _then;

/// Create a copy of MatchAnalysis
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? homeTeam = null,Object? awayTeam = null,Object? scorePrediction = null,Object? analysisContent = null,Object? matchDate = null,Object? createdAt = null,}) {
  return _then(_MatchAnalysis(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,homeTeam: null == homeTeam ? _self.homeTeam : homeTeam // ignore: cast_nullable_to_non_nullable
as String,awayTeam: null == awayTeam ? _self.awayTeam : awayTeam // ignore: cast_nullable_to_non_nullable
as String,scorePrediction: null == scorePrediction ? _self.scorePrediction : scorePrediction // ignore: cast_nullable_to_non_nullable
as String,analysisContent: null == analysisContent ? _self.analysisContent : analysisContent // ignore: cast_nullable_to_non_nullable
as String,matchDate: null == matchDate ? _self.matchDate : matchDate // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
