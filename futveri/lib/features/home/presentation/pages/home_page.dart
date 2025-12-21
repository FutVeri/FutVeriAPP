import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:futveri/core/theme/app_theme.dart';
import 'package:futveri/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:futveri/features/home/presentation/widgets/search_bar_widget.dart';
import 'package:futveri/features/home/presentation/widgets/player_search_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider);
    final viewModel = ref.read(homeProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('FutVeri Scout'),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.plusCircle),
            onPressed: () => context.push('/create-report'),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            SearchBarWidget(
              hintText: 'Search players by name, position, or team...',
              onChanged: viewModel.updateSearchQuery,
              onClear: viewModel.clearSearch,
            ),
            Gap(24.h),

            // Results or Empty State
            if (state.searchQuery.isEmpty)
              _buildEmptyState(context)
            else if (state.isSearching)
              const Expanded(
                child: Center(child: CircularProgressIndicator()),
              )
            else if (state.searchResults.isEmpty)
              _buildNoResults()
            else
              Expanded(
                child: ListView.builder(
                  itemCount: state.searchResults.length,
                  itemBuilder: (context, index) {
                    final player = state.searchResults[index];
                    return PlayerSearchCard(
                      player: player,
                      onTap: () {
                        // Navigate to create report with player pre-filled
                        context.push('/create-report');
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LucideIcons.search,
              size: 64.sp,
              color: AppTheme.textGrey,
            ),
            Gap(16.h),
            Text(
              'Search for Players',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Gap(8.h),
            Text(
              'Start typing to find players',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppTheme.textGrey,
              ),
            ),
            Gap(32.h),
            ElevatedButton.icon(
              onPressed: () => context.push('/create-report'),
              icon: const Icon(LucideIcons.plusCircle),
              label: const Text('Create New Report'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGreen,
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoResults() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LucideIcons.searchX,
              size: 64.sp,
              color: AppTheme.textGrey,
            ),
            Gap(16.h),
            Text(
              'No Players Found',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Gap(8.h),
            Text(
              'Try a different search term',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppTheme.textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
