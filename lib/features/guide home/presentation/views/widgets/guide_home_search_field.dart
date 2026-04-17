import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class GuideHomeSearchField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  const GuideHomeSearchField({
    super.key,
    this.hintText = 'Search places',
    this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: TextStyle(color: isDark ? Colors.white : AppColor.primaryColor),
      decoration: InputDecoration(
        filled: true,
        fillColor: isDark ? const Color(0xFF19232D) : Colors.white,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 12.sp,
          color: isDark ? const Color(0xFF8FA0AE) : null,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          child: SizedBox(
            height: 28.w,
            width: 28.w,
            child: Image.asset(
              'assets/icons/search-02.png',
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) {
                return Icon(
                  Icons.search_rounded,
                  color: AppColor.secondaryColor,
                  size: 20.sp,
                );
              },
            ),
          ),
        ),
        prefixIconConstraints: BoxConstraints(minHeight: 40.h, minWidth: 48.w),
        contentPadding: EdgeInsets.symmetric(vertical: 14.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(26.r),
          borderSide: BorderSide(color: AppColor.secondaryColor, width: 1.75),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(26.r),
          borderSide: BorderSide(color: AppColor.secondaryColor, width: 1.2),
        ),
      ),
    );
  }
}
