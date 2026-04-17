import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class GuideHomeTopBar extends StatelessWidget {
  const GuideHomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Icon(
          Icons.location_on_rounded,
          size: 20.sp,
          color: AppColor.secondaryColor,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
          decoration: BoxDecoration(
            color: const Color(0xFFF89422),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            'Luxor, Egypt',
            style: TextStyle(
              color: isDark ? const Color(0xFFF2F7FA) : Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 10.sp,
            ),
          ),
        ),
        const Spacer(),
        IconButton(
          visualDensity: VisualDensity.compact,
          onPressed: () {},
          icon: Icon(
            Icons.notifications_none_rounded,
            size: 24.sp,
            color: AppColor.secondaryColor,
          ),
        ),
        CircleAvatar(
          backgroundColor: AppColor.secondaryColor,
          radius: 20.r,
          backgroundImage: const AssetImage('assets/images/2th.jpg'),
        ),
      ],
    );
  }
}
