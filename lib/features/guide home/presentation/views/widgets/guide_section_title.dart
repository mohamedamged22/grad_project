import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_semi_bold.dart';
import 'package:flutter/material.dart';

class GuideSectionTitle extends StatelessWidget {
  final String title;
  final Function()? onTap;
  const GuideSectionTitle({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextSemiBold(text: title, fontSize: 16.sp),
        GestureDetector(
          onTap: onTap,
          child: Text(
            'See All',

            style: TextStyle(
              fontSize: 12.sp,
              color: AppColor.secondaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
