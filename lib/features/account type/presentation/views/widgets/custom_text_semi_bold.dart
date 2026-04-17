import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class CustomTextSemiBold extends StatelessWidget {
  const CustomTextSemiBold({
    super.key,
    required this.text,
    required this.fontSize,
  });
  final String text;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize.sp,
        fontWeight: FontWeight.w600,
        color: isDark ? Colors.white : AppColor.primaryColor,
      ),
    );
  }
}
