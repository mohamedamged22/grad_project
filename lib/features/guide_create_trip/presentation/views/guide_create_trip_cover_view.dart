import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/core/utils/widgets/loading_overlay.dart';
import 'package:beyond_the_pramids/core/utils/widgets/snack_bar.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_semi_bold.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/step_progress_indicator.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/upload_photo_container.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/presentation/manager/guide_create_trip_cover_cubit/guide_create_trip_cover_cubit.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/widgets/custom_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuideCreateTripCoverView extends StatelessWidget {
  const GuideCreateTripCoverView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GuideCreateTripCoverCubit>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pageBg = Theme.of(context).scaffoldBackgroundColor;
    final primaryText = isDark ? Colors.white : AppColor.primaryColor;

    return BlocConsumer<GuideCreateTripCoverCubit, GuideCreateTripCoverState>(
      listener: (context, state) {
        if (state.status == GuideCreateTripCoverStatus.loading) {
          showLoadingOverlay(context);
          return;
        }

        if (state.status == GuideCreateTripCoverStatus.success) {
          hideLoadingOverlay(context);
          showSnackBar(context, state.message ?? 'Image uploaded successfully', isSuccess: true);
          Navigator.pushNamed(
            context,
            '/guideCreateTripSuccessView',
            arguments: state.uploadedImagePath,
          );
          return;
        }

        if (state.status == GuideCreateTripCoverStatus.failure) {
          hideLoadingOverlay(context);
          showSnackBar(
            context,
            state.message ?? 'Failed to upload cover',
            isSuccess: false,
          );
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            if (state.status == GuideCreateTripCoverStatus.failure) {
              showSnackBar(
                context,
                'Please fix the current error first',
                isSuccess: false,
              );
              return false;
            }
            return true;
          },
          child: Scaffold(
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
              onPressed: () {
                if (state.status == GuideCreateTripCoverStatus.failure) {
                  showSnackBar(
                    context,
                    'Please fix the current error first',
                    isSuccess: false,
                  );
                  return;
                }
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Create New Trip',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: primaryText,
              ),
            ),
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
                  UploadPhotoContainer(
                    allowedExtensions: const [
                      'jpg',
                      'jpeg',
                      'png',
                      'webp',
                      'jfif',
                    ],
                    fileInfoText:
                        'JPG, JPEG, PNG, WEBP or JFIF, file size no more than 10MB',
                    onFileSelected: (PlatformFile file) {
                      cubit.setSelectedFilePath(file.path);
                    },
                  ),
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
                onTap: cubit.uploadCover,
              ),
            ),
            ),
          ),
        );
      },
    );
  }
}
