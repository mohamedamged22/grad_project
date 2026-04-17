import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_trip_preview_card.dart';
import 'package:flutter/material.dart';

class GuideCreateNewTripSuccessView extends StatelessWidget {
  const GuideCreateNewTripSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    final pageBg = AppColor.white;
    final titleColor = AppColor.primaryColor;
    final subtitleColor = AppColor.secondaryColor;

    return Scaffold(
      backgroundColor: pageBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(14.w, 6.h, 14.w, 20.h),
          child: Column(
            children: [
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: IconButton(
                  onPressed: () => Navigator.maybePop(context),
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 17.sp,
                    color: titleColor,
                  ),
                  splashRadius: 20,
                ),
              ),

              SizedBox(height: 2.h),
              Icon(
                Icons.verified_rounded,
                color: AppColor.secondaryColor,
                size: 40.sp,
              ),
              SizedBox(height: 14.h),
              Text(
                'Your trip has been created successfully!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24.sp,
                  height: 1.0,
                  fontWeight: FontWeight.w600,
                  color: AppColor.primaryColor,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'It\'s now live and open for booking.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.sp,
                  height: 1.0,
                  fontWeight: FontWeight.w400,
                  color: subtitleColor,
                ),
              ),

              SizedBox(height: 22.h),
              GuideTripPreviewCard(
                imagePath: 'assets/images/2th.jpg',
                title: 'Ancient Wonder of Aswan',
                location: 'Aswan',
                spots: '0/20 Spots',
                dateRange: '1 Feb - 15 Feb, 2026',
                price: '\$150',
                priceSuffix: ' /person',
                tag: 'History',
              ),

              SizedBox(height: 20.h),
              SizedBox(
                width: 182.w,
                height: 40.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/guideHomeRootView',
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.secondaryColor,
                    foregroundColor: AppColor.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.r),
                    ),
                  ),
                  child: Text(
                    'View My Trips',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                width: 182.w,
                height: 36.h,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/guideCreateNewTripView',
                      (route) => false,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColor.secondaryColor,
                    side: BorderSide(color: AppColor.secondaryColor, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.r),
                    ),
                  ),
                  child: Text(
                    'Create Another Trip',
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              SizedBox(
                width: 182.w,
                height: 36.h,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/guideHomeRootView',
                      (route) => false,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColor.secondaryColor,
                    side: BorderSide(color: AppColor.secondaryColor, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.r),
                    ),
                  ),
                  child: Text(
                    'Back to home',
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
