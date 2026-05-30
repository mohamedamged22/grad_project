import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/model/tourist_landmark_list_item.dart';
import 'package:flutter/material.dart';

class TouristLandmarkHomeCard extends StatelessWidget {
  final TouristLandmarkListItem landmark;

  const TouristLandmarkHomeCard({super.key, required this.landmark});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = Theme.of(context).cardColor;

    return Container(
      width: 142.w,
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark ? const Color(0xFF2F3D49) : const Color(0xFFE4EBF0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: _LandmarkImage(
                imageUrl: landmark.normalizedImageUrl,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              landmark.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : AppColor.primaryColor,
                height: 1.25,
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 14.sp,
                  color: AppColor.secondaryColor,
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Text(
                    landmark.city,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color:
                          isDark
                              ? const Color(0xFFB2C0CC)
                              : const Color(0xFF4A5A67),
                    ),
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

class _LandmarkImage extends StatelessWidget {
  final String? imageUrl;

  const _LandmarkImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final resolved = imageUrl?.trim();
    if (resolved == null || resolved.isEmpty) {
      return Image.asset(
        'assets/images/2th.jpg',
        height: 74.h,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }

    if (resolved.startsWith('http://') || resolved.startsWith('https://')) {
      return Image.network(
        resolved,
        height: 74.h,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Image.asset(
          'assets/images/2th.jpg',
          height: 74.h,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }

    return Image.asset(
      resolved,
      height: 74.h,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
