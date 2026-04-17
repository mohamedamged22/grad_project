import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_regolar.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_semi_bold.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.text,
    required this.des,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final String text, des;
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isSelected ? AppColor.secondaryColor : Colors.grey.shade400,
          width: isSelected ? 2 : 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: CustomTextSemiBold(text: text, fontSize: 20)),
              Radio<String>(
                value: value,
                groupValue: groupValue,
                activeColor: AppColor.secondaryColor,
                onChanged: onChanged,
              ),
            ],
          ),

          const SizedBox(height: 8),

          CustomTextRegolar(text: des),
        ],
      ),
    );
  }
}
