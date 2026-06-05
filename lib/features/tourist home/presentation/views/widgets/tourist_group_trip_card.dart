import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/model/tourist_public_trip.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TouristGroupTripCard extends StatelessWidget {
  final TouristPublicTrip trip;
  final VoidCallback? onTap;
  final VoidCallback? onBookNowTap;

  const TouristGroupTripCard({
    super.key,
    required this.trip,
    this.onTap,
    this.onBookNowTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = Theme.of(context).cardColor;
    final mutedText =
        isDark ? const Color(0xFFB2C0CC) : const Color(0xFF778996);
    final coverUrl = trip.normalizedImageUrl;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(7.w),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isDark ? const Color(0xFF2F3D49) : const Color(0xFFE4EBF0),
          ),
        ),
        child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: coverUrl != null
                ? Image.network(
                    coverUrl,
                    width: 104.w,
                    height: 104.w,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 104.w,
                    height: 104.w,
                    color: isDark
                        ? const Color(0xFF1C2732)
                        : const Color(0xFFE6EEF2),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.image_outlined,
                      size: 28.sp,
                      color: AppColor.secondaryColor,
                    ),
                  ),
          ),
          SizedBox(width: 9.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trip.title,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : AppColor.primaryColor,
                    height: 1.08,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'tourist_trip_card_subtitle'.tr(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w500,
                    color: mutedText,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  trip.city,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: mutedText,
                  ),
                ),
                SizedBox(height: 5.h),
                Wrap(
                  spacing: 6.w,
                  runSpacing: 2.h,
                  children: [
                    if (trip.duration.trim().isNotEmpty)
                      _InfoItem(
                        icon: Icons.schedule_rounded,
                        value: trip.duration,
                      ),
                    if (trip.category.trim().isNotEmpty)
                      _InfoItem(
                        icon: Icons.category_outlined,
                        value: trip.category,
                      ),
                    if (trip.status.trim().isNotEmpty)
                      _InfoItem(
                        icon: Icons.verified_outlined,
                        value: trip.status,
                      ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '\$ ${trip.formattedPrice}',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColor.secondaryColor,
                        height: 0.95,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 24.h,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 13.w),
                          backgroundColor: AppColor.secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.r),
                          ),
                        ),
                        onPressed: onBookNowTap ?? onTap ?? () {},
                        child: Text(
                          'tourist_book_now'.tr(),
                          style: TextStyle(fontSize: 9.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String value;

  const _InfoItem({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12.sp, color: AppColor.secondaryColor),
        SizedBox(width: 2.w),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 9.sp,
            fontWeight: FontWeight.w500,
            color: isDark ? const Color(0xFFB2C0CC) : const Color(0xFF607281),
          ),
        ),
      ],
    );
  }
}
