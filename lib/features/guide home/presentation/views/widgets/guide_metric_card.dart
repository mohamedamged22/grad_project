import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class GuideMetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color valueColor;

  const GuideMetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? Colors.white : AppColor.primaryColor;
    final boxBg = isDark ? const Color(0xFF19232D) : Colors.white;

    return SizedBox(
      height: 118.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.4.sp,
              color: primaryText,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 44.h,
              width: 44.w,
              decoration: BoxDecoration(
                color: boxBg,
                borderRadius: BorderRadius.circular(9.r),
                border: Border.all(color: const Color(0xFFD2E0E9), width: .9),
              ),
              child: Center(
                child: Icon(icon, size: 18.sp, color: AppColor.secondaryColor),
              ),
            ),
          ),
          SizedBox(height: 11.h),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 86.w,
              padding: EdgeInsets.symmetric(vertical: 3.2.h),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBF7),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: const Color(0xFFF1D1AD), width: .9),
              ),
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: valueColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
