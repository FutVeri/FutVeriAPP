/// User model for regular app users
class AppUser {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final String role; // user, scout, premium
  final DateTime createdAt;
  final DateTime lastActiveAt;
  final bool isOnline;
  final int reportCount;

  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    required this.role,
    required this.createdAt,
    required this.lastActiveAt,
    this.isOnline = false,
    this.reportCount = 0,
  });

  String get initials {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }
}

/// Admin user model
class Admin {
  final String id;
  final String username;
  final String name;
  final String role; // admin, superadmin
  final DateTime createdAt;

  const Admin({
    required this.id,
    required this.username,
    required this.name,
    required this.role,
    required this.createdAt,
  });
}
