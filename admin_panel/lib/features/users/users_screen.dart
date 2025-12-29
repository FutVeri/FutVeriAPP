import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/glassmorphism.dart';
import '../../models/user.dart';
import '../../services/mock_data_service.dart';

// Users state
class UsersState {
  final List<AppUser> users;
  final String searchQuery;

  const UsersState({
    required this.users,
    this.searchQuery = '',
  });

  List<AppUser> get filteredUsers {
    if (searchQuery.isEmpty) return users;
    return users.where((u) {
      return u.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          u.email.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  UsersState copyWith({List<AppUser>? users, String? searchQuery}) {
    return UsersState(
      users: users ?? this.users,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

// Users notifier
class UsersNotifier extends Notifier<UsersState> {
  @override
  UsersState build() {
    return UsersState(users: MockDataService().getUsers());
  }

  void search(String query) {
    state = state.copyWith(searchQuery: query);
  }
}

final usersProvider = NotifierProvider<UsersNotifier, UsersState>(() {
  return UsersNotifier();
});

class UsersScreen extends ConsumerWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersState = ref.watch(usersProvider);
    final users = usersState.filteredUsers;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kullanıcı Yönetimi',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textWhite,
                          ),
                    ),
                    const Gap(4),
                    Text(
                      'Tüm kullanıcıları görüntüleyin ve yönetin',
                      style: TextStyle(
                        color: AppTheme.textGrey.withValues(alpha: 0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // Search
                SizedBox(
                  width: 300,
                  child: TextField(
                    onChanged: (value) => ref.read(usersProvider.notifier).search(value),
                    style: const TextStyle(color: AppTheme.textWhite, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Kullanıcı ara...',
                      prefixIcon: const Icon(LucideIcons.search, color: AppTheme.textGrey, size: 18),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      filled: true,
                      fillColor: AppTheme.surfaceLight,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(24),
            // Stats row
            Row(
              children: [
                _buildMiniStat(
                  context,
                  'Toplam',
                  usersState.users.length.toString(),
                  LucideIcons.users,
                  AppTheme.primaryGreen,
                ),
                const Gap(12),
                _buildMiniStat(
                  context,
                  'Online',
                  usersState.users.where((u) => u.isOnline).length.toString(),
                  LucideIcons.wifi,
                  AppTheme.successGreen,
                ),
                const Gap(12),
                _buildMiniStat(
                  context,
                  'Scout',
                  usersState.users.where((u) => u.role == 'scout').length.toString(),
                  LucideIcons.eye,
                  AppTheme.secondaryBlue,
                ),
                const Gap(12),
                _buildMiniStat(
                  context,
                  'Premium',
                  usersState.users.where((u) => u.role == 'premium').length.toString(),
                  LucideIcons.crown,
                  AppTheme.accentPurple,
                ),
              ],
            ),
            const Gap(24),
            // Users table
            Expanded(
              child: GlassCard(
                padding: const EdgeInsets.all(0),
                child: users.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(LucideIcons.userX, color: AppTheme.textGrey, size: 48),
                            Gap(16),
                            Text(
                              'Kullanıcı bulunamadı',
                              style: TextStyle(color: AppTheme.textGrey),
                            ),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        child: DataTable(
                          columnSpacing: 24,
                          horizontalMargin: 20,
                          headingRowHeight: 56,
                          dataRowMinHeight: 64,
                          dataRowMaxHeight: 64,
                          columns: const [
                            DataColumn(label: Text('Kullanıcı')),
                            DataColumn(label: Text('Email')),
                            DataColumn(label: Text('Rol')),
                            DataColumn(label: Text('Rapor')),
                            DataColumn(label: Text('Son Aktif')),
                            DataColumn(label: Text('Kayıt Tarihi')),
                            DataColumn(label: Text('Durum')),
                          ],
                          rows: users.map((user) {
                            return DataRow(
                              cells: [
                                DataCell(
                                  Row(
                                    children: [
                                      Stack(
                                        children: [
                                          CircleAvatar(
                                            radius: 18,
                                            backgroundColor:
                                                _getRoleColor(user.role).withValues(alpha: 0.2),
                                            child: Text(
                                              user.initials,
                                              style: TextStyle(
                                                color: _getRoleColor(user.role),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          if (user.isOnline)
                                            Positioned(
                                              right: 0,
                                              bottom: 0,
                                              child: Container(
                                                width: 10,
                                                height: 10,
                                                decoration: BoxDecoration(
                                                  color: AppTheme.successGreen,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: AppTheme.surfaceDark,
                                                    width: 2,
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      const Gap(12),
                                      Text(
                                        user.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                DataCell(Text(user.email)),
                                DataCell(_buildRoleBadge(user.role)),
                                DataCell(
                                  Text(
                                    user.reportCount.toString(),
                                    style: TextStyle(
                                      color: user.reportCount > 0
                                          ? AppTheme.primaryGreen
                                          : AppTheme.textGrey,
                                      fontWeight: user.reportCount > 0
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                                DataCell(Text(_formatTimeAgo(user.lastActiveAt))),
                                DataCell(Text(_formatDate(user.createdAt))),
                                DataCell(
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: (user.isOnline
                                              ? AppTheme.successGreen
                                              : AppTheme.textGrey)
                                          .withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      user.isOnline ? 'Online' : 'Offline',
                                      style: TextStyle(
                                        color: user.isOnline
                                            ? AppTheme.successGreen
                                            : AppTheme.textGrey,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniStat(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        borderRadius: 12,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const Gap(12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textWhite,
                      ),
                ),
                Text(
                  label,
                  style: const TextStyle(
                    color: AppTheme.textGrey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleBadge(String role) {
    final color = _getRoleColor(role);
    final label = switch (role) {
      'scout' => 'Scout',
      'premium' => 'Premium',
      _ => 'User',
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _getRoleColor(String role) {
    return switch (role) {
      'scout' => AppTheme.primaryGreen,
      'premium' => AppTheme.accentPurple,
      _ => AppTheme.textGrey,
    };
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatTimeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} dk önce';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} saat önce';
    } else {
      return '${diff.inDays} gün önce';
    }
  }
}
