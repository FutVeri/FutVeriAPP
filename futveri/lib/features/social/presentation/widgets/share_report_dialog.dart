import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:futveri/core/theme/app_theme.dart';
import 'package:futveri/features/scout/domain/scout_report.dart';
import 'package:futveri/features/social/presentation/viewmodels/social_feed_viewmodel.dart';

class ShareReportDialog extends ConsumerStatefulWidget {
  final ScoutReport report;

  const ShareReportDialog({
    super.key,
    required this.report,
  });

  @override
  ConsumerState<ShareReportDialog> createState() => _ShareReportDialogState();
}

class _ShareReportDialogState extends ConsumerState<ShareReportDialog> {
  final TextEditingController _captionController = TextEditingController();

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(socialFeedProvider);

    return Dialog(
      backgroundColor: AppTheme.surfaceDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Raporu Paylaş',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Gap(8.h),
            Text(
              '${widget.report.playerName} hakkındaki bu raporu ScoutHub feed\'inde paylaşmak için bir açıklama ekleyin.',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppTheme.textGrey,
              ),
            ),
            Gap(16.h),
            TextField(
              controller: _captionController,
              maxLines: 4,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Düşüncelerinizi buraya yazın...',
                hintStyle: const TextStyle(color: AppTheme.textGrey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Colors.white10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Colors.white10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: AppTheme.primaryGreen),
                ),
              ),
            ),
            Gap(24.h),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('İptal', style: TextStyle(color: Colors.white70)),
                  ),
                ),
                Gap(12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: state.isLoading
                        ? null
                        : () async {
                            print('🔘 ShareDialog: Paylaş button clicked');
                            print('🔘 ShareDialog: Caption: "${_captionController.text}"');
                            final success = await ref
                                .read(socialFeedProvider.notifier)
                                .shareReport(
                                  report: widget.report,
                                  caption: _captionController.text,
                                );
                            print('🔘 ShareDialog: Result: $success');
                            if (success && mounted) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Rapor ScoutHub\'da paylaşıldı!')),
                              );
                            } else if (!success && mounted) {
                              print('❌ ShareDialog: Sharing failed.');
                              final error = ref.read(socialFeedProvider).errorMessage;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Paylaşım hatası: ${error ?? 'Bilinmeyen hata'}'),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryGreen,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: state.isLoading
                        ? SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(Colors.black),
                            ),
                          )
                        : const Text('Paylaş'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
