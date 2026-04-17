import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class GuideTripMapSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final bool isSearching;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onSearchTap;
  final VoidCallback onBackTap;

  const GuideTripMapSearchBar({
    super.key,
    required this.controller,
    required this.isSearching,
    required this.onSubmitted,
    required this.onSearchTap,
    required this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Row(
          children: [
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              child: InkWell(
                borderRadius: BorderRadius.circular(12.r),
                onTap: onBackTap,
                child: SizedBox(
                  width: 40.w,
                  height: 40.w,
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 16.sp,
                    color: AppColor.primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Container(
                height: 40.h,
                padding: EdgeInsetsDirectional.only(start: 8.w, end: 4.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 12,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: const Color(0xFF8A8A8A),
                      size: 18.sp,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: TextField(
                        controller: controller,
                        textInputAction: TextInputAction.search,
                        onSubmitted: onSubmitted,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColor.primaryColor,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search place name',
                          hintStyle: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFF8A8A8A),
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                    isSearching
                        ? SizedBox(
                          width: 18.w,
                          height: 18.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                        : IconButton(
                          onPressed: onSearchTap,
                          icon: Icon(
                            Icons.arrow_circle_right_outlined,
                            size: 20.sp,
                            color: AppColor.secondaryColor,
                          ),
                          splashRadius: 18,
                        ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
