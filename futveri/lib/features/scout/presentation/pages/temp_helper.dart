
  Widget _buildCategorySection({
    required int rating,
    required String description,
    required Function(int) onRatingChanged,
    required Function(String) onDescriptionChanged,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RatingSlider(
            label: 'Rating',
            value: rating,
            onChanged: onRatingChanged,
          ),
          Gap(16.h),
          Text(
            'Analysis / Description',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
            ),
          ),
          Gap(8.h),
          TextField(
            onChanged: onDescriptionChanged,
            maxLines: 3,
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
            decoration: InputDecoration(
              hintText: 'Enter detailed analysis...',
              filled: true,
              fillColor: Colors.black.withOpacity(0.2),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.all(12.w),
            ),
            controller: TextEditingController(text: description)
              ..selection = TextSelection.fromPosition(
                  TextPosition(offset: description.length)
              ),
          ),
        ],
      ),
    );
  }
