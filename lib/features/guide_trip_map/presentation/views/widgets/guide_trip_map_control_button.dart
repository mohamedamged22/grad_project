import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class GuideTripMapControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const GuideTripMapControlButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: SizedBox(
          width: 40.w,
          height: 40.w,
          child: Icon(icon, size: 20.sp, color: AppColor.primaryColor),
        ),
      ),
    );
  }
}
