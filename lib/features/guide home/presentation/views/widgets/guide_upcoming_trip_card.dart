import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class TripData {
  final String imagePath;
  final String title;
  final String date;
  final String tourists;
  final String duration;
  final String applicants;

  const TripData({
    required this.imagePath,
    required this.title,
    required this.date,
    required this.tourists,
    this.duration = '7 Days',
    this.applicants = '500 Applicants',
  });
}

class GuideUpcomingTripCard extends StatelessWidget {
  final TripData data;
  const GuideUpcomingTripCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = Theme.of(context).cardColor;
    final primaryText = isDark ? Colors.white : AppColor.primaryColor;
    final secondaryText =
        isDark ? const Color(0xFFB2C0CC) : const Color(0xFF1D2B36);

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
                child: Image.asset(
                  data.imagePath,
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
                  data.title,
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
                      Icons.calendar_month,
                      size: 11.sp,
                      color: AppColor.secondaryColor,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      data.date,
                      style: TextStyle(fontSize: 8.sp, color: secondaryText),
                    ),
                    const Spacer(),
                    Text(
                      data.duration,
                      style: TextStyle(
                        fontSize: 8.sp,
                        color: secondaryText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    ...List.generate(4, (index) {
                      final images = [
                        'assets/images/2th.jpg',
                        'assets/images/3th.jpg',
                        'assets/images/4th.jpg',
                        'assets/images/5th.jpg',
                      ];

                      return Transform.translate(
                        offset: Offset(index == 0 ? 0 : (-7.w * index), 0),
                        child: Container(
                          width: 16.w,
                          height: 16.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1),
                            image: DecorationImage(
                              image: AssetImage(images[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    }),
                    Transform.translate(
                      offset: Offset(-28.w, 0),
                      child: Container(
                        width: 16.w,
                        height: 16.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFE9EEF2),
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        child: Center(
                          child: Text(
                            '+',
                            style: TextStyle(
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF5C6D7A),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(-22.w, 0),
                      child: Text(
                        data.applicants,
                        style: TextStyle(
                          fontSize: 8.sp,
                          color: const Color(0xFF8A99A5),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 24.h,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: AppColor.secondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          child: Text(
                            'Confirmed',
                            style: TextStyle(
                              fontSize: 8.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'View Details',
                      style: TextStyle(
                        fontSize: 7.8.sp,
                        color: AppColor.secondaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
