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
    );
  }
}
