class PlayerSearchResult {
  final String id;
  final String name;
  final String position;
  final int age;
  final String team;
  final String? imageUrl;

  const PlayerSearchResult({
    required this.id,
    required this.name,
    required this.position,
    required this.age,
    required this.team,
    this.imageUrl,
  });
}
