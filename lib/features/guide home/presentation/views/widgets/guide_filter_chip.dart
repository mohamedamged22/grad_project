import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class GuideFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;

  const GuideFilterChip({
    super.key,
    required this.label,
    required this.onTap,
    required this.backgroundColor,
    required this.textColor,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          height: 32.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppColor.secondaryColor : backgroundColor,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColor.secondaryColor, width: .8),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10.5.sp,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : textColor,
            ),
          ),
        ),
      ),
    );
  }
}
