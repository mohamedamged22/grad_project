import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/core/utils/widgets/snack_bar.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_semi_bold.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/step_progress_indicator.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/upload_photo_container.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/manager/Tourist%20Profile%20Photo/tourist_profile_photo_cubit.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TouristProfilePhotoView extends StatelessWidget {
  const TouristProfilePhotoView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TouristProfilePhotoCubit, TouristProfilePhotoState>(
      listener: (context, state) {
        if (state.status == TouristProfilePhotoStatus.loading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
          return;
        }

        if (state.status == TouristProfilePhotoStatus.success) {
          if (Navigator.of(context).canPop()) Navigator.of(context).pop();
          showSnackBar(
            context,
            state.successMessage ?? 'Profile photo uploaded',
            isSuccess: true,
          );
          Navigator.pushReplacementNamed(context, '/tripDetailsView');
          return;
        }

        if (state.status == TouristProfilePhotoStatus.failure) {
          if (Navigator.of(context).canPop()) Navigator.of(context).pop();
          showSnackBar(
            context,
            state.errorMessage ?? 'Failed to upload profile photo',
            isSuccess: false,
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<TouristProfilePhotoCubit>();

        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.h),
                  const StepProgressIndicator(currentStep: 2),
                  SizedBox(height: 36.h),
                  CustomTextSemiBold(
                    fontSize: 16.sp,
                    text: 'Upload your profile photo',
                  ),
                  SizedBox(height: 12.h),
                  UploadPhotoContainer(
                    allowedExtensions: const ['jpg', 'jpeg', 'png', 'webp'],
                    fileInfoText: 'Accepted formats: jpg, png, webp',
                    onFileSelected: cubit.setSelectedFile,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'This photo will appear on your public profile.',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF7A8794),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: SizedBox(
            height: 100.h,
            child: Center(
              child: CustomButton(
                text: 'next'.tr(),
                width: 230.w,
                onTap: cubit.submitPhoto,
              ),
            ),
          ),
        );
      },
    );
  }
}
