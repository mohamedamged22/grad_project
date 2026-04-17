import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class CustomTextRegolar extends StatelessWidget {
  const CustomTextRegolar({
    super.key,
    required this.text,
    this.textAlign,
    this.fontSize = 14,
    this.color,
  });
  final String text;
  final TextAlign? textAlign;
  final double? fontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: (fontSize ?? 14).sp,
        fontWeight: FontWeight.w400,
        color:
            color ??
            (isDark ? const Color(0xFFB2C0CC) : AppColor.secondaryColor),
      ),
    );
  }
}
