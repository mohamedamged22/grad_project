import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/mock/tourist_home_mock_data.dart';
import 'package:flutter/material.dart';

class TouristLandmarkTripCompactCard extends StatelessWidget {
  final TouristGroupTrip trip;
  final VoidCallback? onTap;
  final VoidCallback? onBookNowTap;

  const TouristLandmarkTripCompactCard({
    super.key,
    required this.trip,
    this.onTap,
    this.onBookNowTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(6.w),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isDark ? const Color(0xFF2F3D49) : const Color(0xFFE4EBF0),
          ),
        ),
        child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.asset(
              trip.imagePath,
              width: 68.w,
              height: 68.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trip.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : AppColor.primaryColor,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  trip.date,
                  style: TextStyle(
                    fontSize: 8.sp,
                    color:
                        isDark
                            ? const Color(0xFFB2C0CC)
                            : const Color(0xFF607281),
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text(
                      trip.price,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColor.secondaryColor,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 22.h,
                      child: FilledButton(
                        onPressed: onBookNowTap ?? onTap ?? () {},
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColor.secondaryColor,
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                        child: Text(
                          'Book Now',
                          style: TextStyle(
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w700,
                          ),
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
