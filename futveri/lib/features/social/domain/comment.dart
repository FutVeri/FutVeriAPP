class Comment {
  final String id;
  final String userId;
  final String userName;
  final String text;
  final DateTime createdAt;

  const Comment({
    required this.id,
    required this.userId,
    required this.userName,
    required this.text,
    required this.createdAt,
  });
  factory Comment.fromJson(Map<String, dynamic> json) {
    // Handle user name from nested user object if it exists
    final userData = json['users'] as Map<String, dynamic>?;
    final userName = userData?['name'] as String? ?? 'Bilinmeyen Kullanıcı';

    return Comment(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      userName: userName,
      text: json['comment_text'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
