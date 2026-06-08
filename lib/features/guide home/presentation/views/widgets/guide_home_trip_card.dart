import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/guide%20home/data/model/guide_trip_summary_model.dart';
import 'package:flutter/material.dart';

class GuideHomeTripCard extends StatelessWidget {
  final GuideTripSummaryModel trip;
  const GuideHomeTripCard({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = Theme.of(context).cardColor;
    final primaryText = isDark ? Colors.white : AppColor.primaryColor;
    final secondaryText =
        isDark ? const Color(0xFFB2C0CC) : const Color(0xFF1D2B36);

    final imageUrl = trip.normalizedCoverImageUrl;

    return Container(
      width: 170.w,
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColor.secondaryColor, width: .75),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(6.w, 6.h, 6.w, 5.h),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: const Color(0xFFE7EEF3), width: 1.w),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: SizedBox(
                height: 120.h,
                width: double.infinity,
                child: imageUrl != null
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return Container(
                            color: const Color(0xFFE7EEF3),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              color: AppColor.secondaryColor,
                              size: 24.sp,
                            ),
                          );
                        },
                      )
                    : Container(
                        color: const Color(0xFFE7EEF3),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: AppColor.secondaryColor,
                          size: 24.sp,
                        ),
                      ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8.w, 6.h, 8.w, 6.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trip.title.isNotEmpty ? trip.title : 'Trip',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 9.8.sp,
                    color: primaryText,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      size: 11.sp,
                      color: AppColor.secondaryColor,
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Text(
                        trip.city.isNotEmpty ? trip.city : 'Egypt',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 8.sp,
                          color: secondaryText,
                        ),
                      ),
                    ),
                    if (trip.duration != null && trip.duration!.isNotEmpty) ...[
                      const Spacer(),
                      Text(
                        trip.duration!,
                        style: TextStyle(
                          fontSize: 8.sp,
                          color: secondaryText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      size: 11.sp,
                      color: AppColor.secondaryColor,
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Text(
                        trip.startDate ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 8.sp, color: secondaryText),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                if (trip.pricePerTourist != null)
                  Align(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      text: TextSpan(
                        text:
                            '${trip.pricePerTourist!.toInt() == trip.pricePerTourist ? trip.pricePerTourist!.toInt() : trip.pricePerTourist}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColor.secondaryColor,
                        ),
                        children: [
                          TextSpan(
                            text: ' /person',
                            style: TextStyle(
                              fontSize: 8.sp,
                              color: secondaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}