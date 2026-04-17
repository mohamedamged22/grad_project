import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_regolar.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_semi_bold.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SuccessCompleteDataView extends StatelessWidget {
  const SuccessCompleteDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 112.h, width: double.infinity),

            SvgPicture.asset(
              'assets/svg/Vector.svg',
              height: 176.h,
              width: 176.w,
            ),

            SizedBox(height: 16.h),
            CustomTextSemiBold(
              text: 'success_profile_submitted'.tr(),
              fontSize: 24,
            ),
            SizedBox(height: 4.h),
            CustomTextRegolar(
              textAlign: TextAlign.center,
              text: 'success_profile_review'.tr(),
            ),

            const Spacer(),

            CustomButton(
              text: 'success_submitted'.tr(),
              width: 260,
              onTap: () {
                Navigator.pushReplacementNamed(context, '/signInView');
              },
            ),

            SizedBox(height: 75.h),
          ],
        ),
      ),
    );
  }
}
