import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/core/utils/widgets/loading_overlay.dart';
import 'package:beyond_the_pramids/core/utils/widgets/snack_bar.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_regolar.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_semi_bold.dart';
import 'package:beyond_the_pramids/features/auth/presentation/manger/auth_cubit/auth_cubit.dart';
import 'package:beyond_the_pramids/features/auth/presentation/manger/auth_cubit/auth_state.dart';
import 'package:beyond_the_pramids/features/auth/presentation/views/widgets/custom_text_button.dart';
import 'package:beyond_the_pramids/features/auth/presentation/views/widgets/otp_boxes.dart';
import 'package:beyond_the_pramids/features/auth/presentation/views/widgets/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final fromProfileFlow =
        args is Map<String, dynamic> && args['fromProfileFlow'] == true;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showLoadingOverlay(context);
        } else if (state is OtpSuccess) {
          hideLoadingOverlay(context);
          showSnackBar(context, state.message, isSuccess: true);
          Navigator.pushReplacementNamed(
            context,
            '/resetNewPasswordView',
            arguments: {'fromProfileFlow': fromProfileFlow},
          );
        } else if (state is ForgetPasswordSuccess) {
          hideLoadingOverlay(context);
          showSnackBar(context, 'auth_otp_resent'.tr(), isSuccess: true);

          // امسح الـ OTP القديم
          context.read<AuthCubit>().otpController.clear();
        } else if (state is AuthError) {
          hideLoadingOverlay(context);
          showSnackBar(context, state.message, isSuccess: false);
        }
      },
      builder: (context, state) {
        final cubit = context.read<AuthCubit>();
        final hasError = state is AuthError;

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed:
                    () => Navigator.pushReplacementNamed(
                      context,
                      '/forgetPasswordView',
                      arguments: {'fromProfileFlow': fromProfileFlow},
                    ),
                icon: Icon(
                  Icons.chevron_left,
                  size: 32.w,
                  color: AppColor.primaryColor,
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    CustomTextSemiBold(
                      text: 'enter_code_title'.tr(),
                      fontSize: 24,
                    ),
                    SizedBox(height: 4.h),
                    CustomTextRegolar(text: 'enter_code_subtitle'.tr()),
                    SizedBox(height: 32.h),

                    // OTP Input
                    Center(
                      child: OTPPicker(
                        controller: cubit.otpController,
                        enabled: state is! AuthLoading,
                        hasError: hasError,
                        onCompleted: (value) {
                          cubit.checkOtp();
                        },
                      ),
                    ),

                    // عرض رسالة الخطأ
                    if (hasError)
                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Center(
                          child: Text(
                            'auth_invalid_otp'.tr(),
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),

                    const SizedBox(height: 16),

                    // Timer
                    const Center(child: OtpTimer()),

                    const SizedBox(height: 32),

                    // Resend Code
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'didnt_receive_code'.tr(),
                          style: TextStyle(
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 6),
                        CustomTextButton(
                          text: 'resend_code'.tr(),
                          onPressed:
                              state is AuthLoading
                                  ? null // ⭐ معطل أثناء Loading
                                  : () {
                                    if (cubit.resetEmail != null) {
                                      cubit.forgetPasswordEmailController.text =
                                          cubit.resetEmail!;
                                      cubit.forgetPassword();
                                    } else {
                                      showSnackBar(
                                        context,
                                        'auth_start_again'.tr(),
                                        isSuccess: false,
                                      );
                                    }
                                  },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
