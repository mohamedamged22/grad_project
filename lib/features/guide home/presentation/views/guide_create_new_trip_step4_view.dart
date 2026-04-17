import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_semi_bold.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/step_progress_indicator.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/upload_photo_container.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class GuideCreateNewTripStep4View extends StatelessWidget {
  const GuideCreateNewTripStep4View({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pageBg = Theme.of(context).scaffoldBackgroundColor;
    final primaryText = isDark ? Colors.white : AppColor.primaryColor;

    return Scaffold(
      backgroundColor: pageBg,
      appBar: AppBar(
        backgroundColor: pageBg,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColor.primaryColor,
            size: 18.sp,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Create New Trip',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: primaryText,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.bookmark_border_rounded,
              color: AppColor.secondaryColor,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 4.w),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 6.h),
              const StepProgressIndicator(currentStep: 4, totalSteps: 4),
              SizedBox(height: 16.h),

              Row(
                children: [
                  CustomTextSemiBold(text: 'Trip Cover', fontSize: 15.sp),
                  SizedBox(width: 4.w),
                  Text(
                    '(Optional)',
                    style: TextStyle(
                      color: const Color(0xFFE8A242),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),

              const UploadPhotoContainer(),

              const Spacer(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 14.h),
          child: CustomButton(
            text: 'Publish Trip',
            onTap: () {
              Navigator.pushNamed(context, '/guideCreateNewTripSuccessView');
            },
          ),
        ),
      ),
    );
  }
}
