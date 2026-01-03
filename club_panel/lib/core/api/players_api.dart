import 'api_client.dart';
import '../../models/club.dart';

/// Players API service for Club Panel
class PlayersApi {
  final ApiClient _client = ApiClient.instance;
  
  /// Get paginated list of players
  Future<PlayersListResponse> getPlayers({
    int page = 1,
    int size = 20,
    String? name,
    String? position,
    String? nationality,
  }) async {
    final response = await _client.get(
      '/players',
      queryParameters: {
        'page': page,
        'size': size,
        if (name != null) 'name': name,
        if (position != null) 'position': position,
        if (nationality != null) 'nationality': nationality,
      },
    );
    
    return PlayersListResponse.fromJson(response.data);
  }
  
  /// Get single player by ID
  Future<Player> getPlayer(String id) async {
    final response = await _client.get('/players/$id');
    return _parsePlayer(response.data);
  }
  
  Player _parsePlayer(Map<String, dynamic> json) {
    return Player(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String?,
      age: json['age'] as int,
      position: json['position'] as String,
      currentClub: json['current_club'] as String,
      nationality: json['nationality'] as String,
      marketValue: (json['market_value'] as num?)?.toDouble(),
      reportsCount: json['reports_count'] as int? ?? 0,
      averageRating: (json['average_rating'] as num?)?.toDouble(),
    );
  }
}

/// Paginated players list response
class PlayersListResponse {
  final List<Player> items;
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
    final playersApi = PlayersApi();
    return PlayersListResponse(
      items: (json['items'] as List<dynamic>)
          .map((e) => playersApi._parsePlayer(e as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int,
      page: json['page'] as int,
      size: json['size'] as int,
      pages: json['pages'] as int,
    );
  }
}
