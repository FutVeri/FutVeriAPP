import 'package:equatable/equatable.dart';

/// Team entity
class TeamEntity extends Equatable {
  final String id;
  final String name;
  final String? logo;
  final String? formation;

  const TeamEntity({
    required this.id,
    required this.name,
    this.logo,
    this.formation,
  });

  @override
  List<Object?> get props => [id, name, logo, formation];
}
