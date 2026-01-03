import 'api_client.dart';

/// Players API service
class PlayersApi {
  final ApiClient _client = ApiClient.instance;
  
  /// Get paginated list of players
  Future<PlayersListResponse> getPlayers({
    int page = 1,
    int size = 20,
    String? name,
    String? position,
    String? nationality,
    String? club,
    int? minAge,
    int? maxAge,
  }) async {
    final response = await _client.get(
      '/players',
      queryParameters: {
        'page': page,
        'size': size,
        if (name != null) 'name': name,
        if (position != null) 'position': position,
        if (nationality != null) 'nationality': nationality,
        if (club != null) 'club': club,
        if (minAge != null) 'min_age': minAge,
        if (maxAge != null) 'max_age': maxAge,
      },
    );
    
    return PlayersListResponse.fromJson(response.data);
  }
  
  /// Get single player by ID
  Future<PlayerResponse> getPlayer(String id) async {
    final response = await _client.get('/players/$id');
    return PlayerResponse.fromJson(response.data);
  }
  
  /// Search players by name
  Future<PlayersListResponse> searchPlayers(String query) async {
    return getPlayers(name: query);
  }
}

/// Player response model
class PlayerResponse {
  final String id;
  final String name;
  final String? imageUrl;
  final int age;
  final DateTime? dateOfBirth;
  final String nationality;
  final String position;
  final String? preferredFoot;
  final String currentClub;
  final String? currentClubId;
  final DateTime? contractUntil;
  final double? marketValue;
  final int? height;
  final int? weight;
  final int reportsCount;
  final double? averageRating;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  PlayerResponse({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.age,
    this.dateOfBirth,
    required this.nationality,
    required this.position,
    this.preferredFoot,
    required this.currentClub,
    this.currentClubId,
    this.contractUntil,
    this.marketValue,
    this.height,
    this.weight,
    this.reportsCount = 0,
    this.averageRating,
    required this.createdAt,
    required this.updatedAt,
  });
  
  factory PlayerResponse.fromJson(Map<String, dynamic> json) {
    return PlayerResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String?,
      age: json['age'] as int,
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'] as String)
          : null,
      nationality: json['nationality'] as String,
      position: json['position'] as String,
      preferredFoot: json['preferred_foot'] as String?,
      currentClub: json['current_club'] as String,
      currentClubId: json['current_club_id'] as String?,
      contractUntil: json['contract_until'] != null
          ? DateTime.parse(json['contract_until'] as String)
          : null,
      marketValue: (json['market_value'] as num?)?.toDouble(),
      height: json['height'] as int?,
      weight: json['weight'] as int?,
      reportsCount: json['reports_count'] as int? ?? 0,
      averageRating: (json['average_rating'] as num?)?.toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}

/// Paginated players list response
class PlayersListResponse {
  final List<PlayerResponse> items;
  final int total;
  final int page;
  final int size;
  final int pages;
  
  PlayersListResponse({
    required this.items,
    required this.total,
    required this.page,
    required this.size,
    required this.pages,
  });
  
  factory PlayersListResponse.fromJson(Map<String, dynamic> json) {
    return PlayersListResponse(
      items: (json['items'] as List<dynamic>)
          .map((e) => PlayerResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int,
      page: json['page'] as int,
      size: json['size'] as int,
      pages: json['pages'] as int,
    );
  }
}
