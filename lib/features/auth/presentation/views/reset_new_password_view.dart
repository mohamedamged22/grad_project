import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/core/utils/widgets/loading_overlay.dart';
import 'package:beyond_the_pramids/core/utils/widgets/snack_bar.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_regolar.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_semi_bold.dart';
import 'package:beyond_the_pramids/features/auth/presentation/manger/auth_cubit/auth_cubit.dart';
import 'package:beyond_the_pramids/features/auth/presentation/manger/auth_cubit/auth_state.dart';
import 'package:beyond_the_pramids/features/auth/presentation/views/widgets/custom_text_field.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetNewPasswordView extends StatelessWidget {
  const ResetNewPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final fromProfileFlow =
        args is Map<String, dynamic> && args['fromProfileFlow'] == true;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showLoadingOverlay(context);
        } else if (state is ResetPasswordSuccess) {
          hideLoadingOverlay(context);
          showSnackBar(context, state.message, isSuccess: true);

          // ⭐ امسح البيانات قبل الانتقال
          context.read<AuthCubit>().clearForgetPasswordData();

          if (fromProfileFlow) {
            Navigator.pushReplacementNamed(
              context,
              '/successConfirmView',
              arguments: {'fromProfileFlow': true},
            );
            return;
          }

          Navigator.pushNamedAndRemoveUntil(
            context,
            '/successConfirmView',
            (route) => false, // ⭐ امسح كل الـ stack
          );
        } else if (state is AuthError) {
          hideLoadingOverlay(context);
          showSnackBar(context, state.message, isSuccess: false);
        }
      },
      builder: (context, state) {
        final cubit = context.read<AuthCubit>();

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.adaptive.arrow_back,
                  size: 32.w,
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SingleChildScrollView(
                child: Form(
                  key: cubit.resetPasswordFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      CustomTextSemiBold(
                        text: 'reset_password_title'.tr(),
                        fontSize: 24,
                      ),
                      SizedBox(height: 4.h),
                      CustomTextRegolar(text: 'reset_password_subtitle'.tr()),
                      SizedBox(height: 24.h),

                      CustomTextSemiBold(fontSize: 16, text: 'password'.tr()),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        hintText: 'password'.tr(),
                        isPassword: true,
                        controller: cubit.resetPasswordController,
                      ),

                      SizedBox(height: 16.h),
                      CustomTextSemiBold(
                        fontSize: 16,
                        text: 'confirm_password'.tr(),
                      ),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        hintText: 'confirm_password'.tr(),
                        isPassword: true,
                        controller: cubit.resetConfirmPasswordController,
                      ),

                      const SizedBox(height: 80),
                      Center(
                        child: CustomButton(
                          text: 'confirm'.tr(),
                          width: 260,
                          onTap: () {
                            if (cubit.resetPasswordFormKey.currentState!
                                .validate()) {
                              if (cubit.resetPasswordController.text !=
                                  cubit.resetConfirmPasswordController.text) {
                                showSnackBar(
                                  context,
                                  'password_not_match'.tr(),
                                  isSuccess: false,
                                );
                                return;
                              }

                              cubit.resetPassword();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
