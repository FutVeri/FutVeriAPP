import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_theme.dart';
import '../theme/glassmorphism.dart';
import '../constants/app_constants.dart';
import '../../services/auth_service.dart';

class ClubScaffold extends ConsumerStatefulWidget {
  final Widget child;

  const ClubScaffold({super.key, required this.child});

  @override
  ConsumerState<ClubScaffold> createState() => _ClubScaffoldState();
}

class _ClubScaffoldState extends ConsumerState<ClubScaffold> {
  bool _isSidebarExpanded = true;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final currentPath = GoRouterState.of(context).matchedLocation;

    return Scaffold(
      backgroundColor: AppTheme.backgroundBlack,
      body: Row(
        children: [
          // Sidebar
          AnimatedContainer(
            duration: AppConstants.animationNormal,
            width: _isSidebarExpanded
                ? AppConstants.sidebarWidth
                : AppConstants.sidebarCollapsedWidth,
            child: GlassmorphicContainer(
              borderRadius: 0,
              padding: const EdgeInsets.symmetric(vertical: 20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.surfaceDark,
                  AppTheme.surfaceDark.withValues(alpha: 0.95),
                ],
              ),
              child: Column(
                children: [
                  // Logo / App Name
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                AppTheme.primaryGreen,
                                AppTheme.secondaryBlue,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            LucideIcons.shield,
                            color: Colors.black,
                            size: 22,
                          ),
                        ),
                        if (_isSidebarExpanded) ...[
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'FutVeri Club',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.textWhite,
                                  ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Navigation Items
                  _buildNavItem(
                    icon: LucideIcons.layoutDashboard,
                    label: 'Dashboard',
                    path: '/dashboard',
                    currentPath: currentPath,
                  ),
                  _buildNavItem(
                    icon: LucideIcons.users,
                    label: 'Oyuncular',
                    path: '/players',
                    currentPath: currentPath,
                  ),
                  _buildNavItem(
                    icon: LucideIcons.fileText,
                    label: 'Raporlar',
                    path: '/reports',
                    currentPath: currentPath,
                  ),
                  _buildNavItem(
                    icon: LucideIcons.scan,
                    label: 'Scoutlar',
                    path: '/scouts',
                    currentPath: currentPath,
                  ),
                  _buildNavItem(
                    icon: LucideIcons.settings,
                    label: 'Ayarlar',
                    path: '/settings',
                    currentPath: currentPath,
                  ),
                  const Spacer(),
                  // Toggle Sidebar
                  _buildNavItem(
                    icon: _isSidebarExpanded
                        ? LucideIcons.panelLeftClose
                        : LucideIcons.panelLeftOpen,
                    label: 'Daralt',
                    onTap: () {
                      setState(() {
                        _isSidebarExpanded = !_isSidebarExpanded;
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  // Logout
                  _buildNavItem(
                    icon: LucideIcons.logOut,
                    label: 'Çıkış Yap',
                    onTap: () {
                      ref.read(authProvider.notifier).logout();
                      context.go('/login');
                    },
                    isDestructive: true,
                  ),
                  const SizedBox(height: 16),
                  // Club Info
                  if (_isSidebarExpanded && authState.currentClub != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceLight,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppTheme.glassBorder),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: AppTheme.primaryGreen,
                              child: Text(
                                authState.currentClub!.name[0],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    authState.currentClub!.name,
                                    style: const TextStyle(
                                      color: AppTheme.textWhite,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    authState.currentClub!.league ?? 'Kulüp',
                                    style: const TextStyle(
                                      color: AppTheme.textGrey,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          // Main Content
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topRight,
                  radius: 1.5,
                  colors: [
                    AppTheme.primaryGreen.withValues(alpha: 0.05),
                    AppTheme.backgroundBlack,
                  ],
                ),
              ),
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    String? path,
    String? currentPath,
    VoidCallback? onTap,
    bool isDestructive = false,
  }) {
    final isSelected = path != null && path == currentPath;
    final color = isDestructive
        ? AppTheme.errorRed
        : isSelected
            ? AppTheme.primaryGreen
            : AppTheme.textGrey;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap ?? (path != null ? () => context.go(path) : null),
          borderRadius: BorderRadius.circular(12),
          hoverColor: AppTheme.surfaceLight,
          child: AnimatedContainer(
            duration: AppConstants.animationFast,
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: _isSidebarExpanded ? 12 : 14,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppTheme.primaryGreen.withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: isSelected
                  ? Border.all(
                      color: AppTheme.primaryGreen.withValues(alpha: 0.3))
                  : null,
            ),
            child: Row(
              mainAxisAlignment: _isSidebarExpanded
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: 20),
                if (_isSidebarExpanded) ...[
                  const SizedBox(width: 12),
                  Text(
                    label,
                    style: TextStyle(
                      color: color,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
