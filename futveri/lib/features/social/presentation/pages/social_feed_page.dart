import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:futveri/features/social/presentation/widgets/feed_post_widget.dart';
import 'package:futveri/features/social/presentation/widgets/feed_filter_sheet.dart';
import 'package:futveri/core/theme/app_theme.dart';
import 'package:gap/gap.dart';

class SocialFeedPage extends StatelessWidget {
  const SocialFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FutVeri Feed'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.bell),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(LucideIcons.messageCircle),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Search & Filter Bar
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search players, scouts...',
                      prefixIcon: const Icon(LucideIcons.search, color: AppTheme.textGrey),
                      contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                  ),
                ),
                Gap(12.w),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (context) => const FeedFilterSheet(),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceDark,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white10),
                    ),
                    child: const Icon(LucideIcons.filter, size: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          
          // Feed List
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: const [
                FeedPostWidget(
                  scoutName: 'Ahmet Yılmaz',
                  playerName: 'Semih Kılıçsoy',
                  playerInfo: 'Beşiktaş • FW • 19 yo',
                  rating: 8.5,
                  comment: 'Incredible finishing ability for his age. Needs to improve decision making in tight spaces.',
                  likes: 124,
                ),
                FeedPostWidget(
                  scoutName: 'Global Scout',
                  playerName: 'Can Uzun',
                  playerInfo: 'FC Nürnberg • CAM • 18 yo',
                  rating: 9.0,
                  comment: 'Top class vision. A true number 10 potential.',
                  likes: 350,
                ),
                FeedPostWidget(
                  scoutName: 'FutVeri Analytics',
                  playerName: 'Enis Destan',
                  playerInfo: 'Trabzonspor • ST • 21 yo',
                  rating: 7.8,
                  comment: 'Strong aerial ability. Holding play is developing well.',
                  likes: 89,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
