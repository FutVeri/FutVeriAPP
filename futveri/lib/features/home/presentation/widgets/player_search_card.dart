import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:futveri/core/theme/app_theme.dart';
import 'package:futveri/features/home/domain/player_search_result.dart';

class PlayerSearchCard extends StatelessWidget {
  final PlayerSearchResult player;
  final VoidCallback onTap;

  const PlayerSearchCard({
    super.key,
    required this.player,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppTheme.surfaceDark,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            // Player Avatar
            CircleAvatar(
              radius: 28.r,
              backgroundColor: AppTheme.primaryGreen.withOpacity(0.2),
              child: Text(
                player.position,
                style: TextStyle(
                  color: AppTheme.primaryGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ),
            Gap(16.w),
            // Player Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    player.name,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Gap(4.h),
                  Text(
                    '${player.team} • ${player.age} years',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppTheme.textGrey,
                    ),
                  ),
                ],
              ),
            ),
            // Arrow Icon
            Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.textGrey,
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }
}
