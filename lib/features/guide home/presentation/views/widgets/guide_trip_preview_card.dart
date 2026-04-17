import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class GuideTripPreviewCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String location;
  final String spots;
  final String dateRange;
  final String price;
  final String priceSuffix;
  final String tag;

  const GuideTripPreviewCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.location,
    required this.spots,
    required this.dateRange,
    required this.price,
    this.priceSuffix = ' /person',
    this.tag = 'History',
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = Theme.of(context).cardColor;
    final borderColor = isDark ? const Color(0xFF304250) : AppColor.grey;
    final metaColor = isDark ? const Color(0xFF9FB0BD) : AppColor.softText;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 11.h),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Stack(
              children: [
                Image.asset(
                  imagePath,
                  height: 160.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, AppColor.imageOverlay],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 8.w,
                  top: 8.h,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor.withValues(alpha: .40),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 10.w,
                  right: 10.w,
                  bottom: 10.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColor.white,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: 14.sp,
                            color: AppColor.white,
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            location,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: AppColor.white,
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
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              children: [
                Icon(Icons.person_rounded, size: 14.sp, color: metaColor),
                SizedBox(width: 4.w),
                Text(
                  spots,
                  style: TextStyle(fontSize: 11.sp, color: metaColor),
                ),
                const Spacer(),
                Icon(
                  Icons.calendar_month_rounded,
                  size: 13.sp,
                  color: metaColor,
                ),
                SizedBox(width: 4.w),
                Text(
                  dateRange,
                  style: TextStyle(fontSize: 11.sp, color: metaColor),
                ),
              ],
            ),
          ),
          SizedBox(height: 6.h),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Padding(
              padding: EdgeInsetsDirectional.only(end: 4.w),
              child: RichText(
                text: TextSpan(
                  text: price,
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColor.secondaryColor,
                  ),
                  children: [
                    TextSpan(
                      text: priceSuffix,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: metaColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
