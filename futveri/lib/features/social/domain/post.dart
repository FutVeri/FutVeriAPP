class Post {
  final String id;
  final String scoutId;
  final String scoutName;
  final String playerName;
  final String playerInfo;
  final double rating;
  final String comment;
  final List<String> imageUrls;
  final int likes;
  final int commentCount;
  final DateTime createdAt;
  final bool isLiked;

  final String? reportId;

  const Post({
    required this.id,
    required this.scoutId,
    required this.scoutName,
    required this.playerName,
    required this.playerInfo,
    required this.rating,
    required this.comment,
    this.imageUrls = const [],
    required this.likes,
    required this.commentCount,
    required this.createdAt,
    this.isLiked = false,
    this.reportId,
  });

  Post copyWith({
    String? id,
    String? scoutId,
    String? scoutName,
    String? playerName,
    String? playerInfo,
    double? rating,
    String? comment,
    List<String>? imageUrls,
    int? likes,
    int? commentCount,
    DateTime? createdAt,
    bool? isLiked,
    String? reportId,
  }) {
    return Post(
      id: id ?? this.id,
      scoutId: scoutId ?? this.scoutId,
      scoutName: scoutName ?? this.scoutName,
      playerName: playerName ?? this.playerName,
      playerInfo: playerInfo ?? this.playerInfo,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      imageUrls: imageUrls ?? this.imageUrls,
      likes: likes ?? this.likes,
      commentCount: commentCount ?? this.commentCount,
      createdAt: createdAt ?? this.createdAt,
      isLiked: isLiked ?? this.isLiked,
      reportId: reportId ?? this.reportId,
    );
  }
  factory Post.fromJson(Map<String, dynamic> json) {
    // Handle scout name from nested user object if it exists
    final scoutData = json['users'] as Map<String, dynamic>?;
    final scoutName = scoutData?['name'] as String? ?? 'Bilinmeyen Scout';

    return Post(
      id: json['id'] as String,
      scoutId: json['scout_id'] as String,
      scoutName: scoutName,
      playerName: json['player_name'] as String? ?? 'Bilinmeyen Oyuncu',
      playerInfo: json['player_info'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      comment: json['comment'] as String? ?? '',
      imageUrls: (json['image_urls'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      likes: json['likes_count'] as int? ?? 0,
      commentCount: json['comments_count'] as int? ?? 0,
      createdAt: DateTime.parse(json['created_at'] as String),
      isLiked: false, // This would need a separate favorites/likes table check
      reportId: json['report_id'] as String?,
    );
  }
}
