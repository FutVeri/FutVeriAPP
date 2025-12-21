import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:futveri/core/theme/app_theme.dart';

class FeedPostWidget extends StatelessWidget {
  final String postId;
  final String scoutName;
  final String playerName;
  final String playerInfo;
  final double rating;
  final String comment;
  final int likes;

  const FeedPostWidget({
    super.key,
    this.postId = '1',
    required this.scoutName,
    required this.playerName,
    required this.playerInfo,
    required this.rating,
    required this.comment,
    required this.likes,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/post-detail/$postId'),
      child: Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              CircleAvatar(
                radius: 16.r,
                backgroundColor: Colors.white10,
                child: Icon(LucideIcons.user, size: 16.sp, color: Colors.white),
              ),
              Gap(10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    scoutName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '2 hours ago',
                    style: TextStyle(color: AppTheme.textGrey, fontSize: 10.sp),
                  ),
                ],
              ),
              const Spacer(),
              Icon(LucideIcons.moreHorizontal, color: AppTheme.textGrey),
            ],
          ),
          Gap(12.h),

          // Player Card Content
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, AppTheme.surfaceDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: rating >= 8 ? AppTheme.primaryGreen.withOpacity(0.5) : AppTheme.secondaryBlue.withOpacity(0.5),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                       image: NetworkImage('https://placeholder.com'), // Placeholder
                       fit: BoxFit.cover,
                    ),
                  ),
                  child: const  Icon(LucideIcons.user, color: Colors.white24),
                ),
                Gap(12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      playerName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      playerInfo,
                      style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: rating >= 8 ? AppTheme.primaryGreen : AppTheme.secondaryBlue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    rating.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Gap(12.h),
          
          // Comment Text
          Text(
            comment,
            style: TextStyle(color: Colors.white, fontSize: 14.sp, height: 1.4),
          ),
          Gap(16.h),

          // Actions
          Row(
            children: [
              _buildAction(LucideIcons.heart, '$likes'),
              Gap(20.w),
              _buildAction(LucideIcons.messageSquare, 'Comm..'),
              Gap(20.w),
              _buildAction(LucideIcons.share2, 'Share'),
            ],
          ),
        ],
      ),
    ),
    );
  }

  Widget _buildAction(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 18.sp, color: AppTheme.textGrey),
        Gap(6.w),
        Text(
          label,
          style: TextStyle(color: AppTheme.textGrey, fontSize: 12.sp),
        ),
      ],
    );
  }
}
