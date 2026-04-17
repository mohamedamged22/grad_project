import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/core/utils/widgets/snack_bar.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_semi_bold.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/manger/Verification/verification_cubit.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/step_progress_indicator.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/upload_photo_container.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationView extends StatefulWidget {
  const VerificationView({super.key});

  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerificationCubit, VerificationState>(
      listener: (context, state) {
        if (state is VerificationLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is VerificationSuccess) {
          Navigator.of(context).pop(); // close loading
          Navigator.pushReplacementNamed(context, '/successCompleteDataView');
        } else if (state is VerificationError) {
          if (Navigator.of(context).canPop()) Navigator.of(context).pop();
          showSnackBar(context, state.message, isSuccess: false);
        }
      },
      builder: (context, state) {
        final cubit = context.read<VerificationCubit>();

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30.h),
                      const StepProgressIndicator(currentStep: 5),
                      SizedBox(height: 30.h),

                      CustomTextSemiBold(
                        fontSize: 16,
                        text: 'verify_upload_id'.tr(),
                      ),
                      const SizedBox(height: 16),
                      UploadPhotoContainer(
                        onFileSelected: (file) {
                          cubit.idFile = file; // ✅
                        },
                      ),

                      const SizedBox(height: 16),
                      CustomTextSemiBold(
                        fontSize: 16,
                        text: 'verify_upload_license'.tr(),
                      ),
                      const SizedBox(height: 16),
                      UploadPhotoContainer(
                        onFileSelected: (file) {
                          cubit.licenseFile = file; // ✅
                        },
                      ),

                      const SizedBox(height: 16),
                      CustomTextSemiBold(
                        fontSize: 16,
                        text: 'verify_upload_photo'.tr(),
                      ),
                      const SizedBox(height: 16),
                      UploadPhotoContainer(
                        onFileSelected: (file) {
                          cubit.photoFile = file; // ✅
                        },
                      ),

                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          Image.asset(
                            'assets/icons/i.png',
                            width: 24.w,
                            height: 24.w,
                          ),
                          SizedBox(width: 8.w),
                          CustomTextSemiBold(
                            text: 'verify_data_secure'.tr(),
                            fontSize: 12,
                          ),
                        ],
                      ),
                      SizedBox(height: 100.h),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: SizedBox(
              height: 100.h,
              child: Center(
                child: CustomButton(
                  text: 'next'.tr(),
                  width: 230,
                  onTap: () => cubit.submitAll(), // ✅
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
