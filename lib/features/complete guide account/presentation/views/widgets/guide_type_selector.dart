import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class TwoTypeSelector extends StatelessWidget {
  final String selectedType;
  final String title1;
  final String title2;
  final ValueChanged<String> onTypeSelected;

  const TwoTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
    required this.title1,
    required this.title2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GuideTypeCard(
            title: title1,
            isSelected: selectedType == title1,
            onTap: () => onTypeSelected(title1),
          ),
        ),
        SizedBox(width: 4.w),
        Expanded(
          child: GuideTypeCard(
            title: title2,
            isSelected: selectedType == title2,
            onTap: () => onTypeSelected(title2),
          ),
        ),
      ],
    );
  }
}

class GuideTypeCard extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const GuideTypeCard({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.secondaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColor.secondaryColor, width: 1.25),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : AppColor.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
