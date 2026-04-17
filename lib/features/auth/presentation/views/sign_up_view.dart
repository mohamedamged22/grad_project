import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/core/utils/widgets/loading_overlay.dart';
import 'package:beyond_the_pramids/core/utils/widgets/snack_bar.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_regolar.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_semi_bold.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/language_aware_content.dart'; // ⭐ أضف هذا
import 'package:beyond_the_pramids/features/auth/presentation/manger/auth_cubit/auth_cubit.dart';
import 'package:beyond_the_pramids/features/auth/presentation/manger/auth_cubit/auth_state.dart';
import 'package:beyond_the_pramids/features/auth/presentation/views/widgets/custom_text_button.dart';
import 'package:beyond_the_pramids/features/auth/presentation/views/widgets/custom_text_field.dart';
import 'package:beyond_the_pramids/features/auth/presentation/views/widgets/circle_check_button.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final store = AccountTypeStore(); // 🔥 اقرأ الـ store

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showLoadingOverlay(context);
        } else if (state is AuthSuccess) {
          hideLoadingOverlay(context);
          showSnackBar(context, 'signup_success'.tr(), isSuccess: true);

          if (store.selectedType == 'guide') {
            Navigator.pushReplacementNamed(context, '/basicInformationView');
          } else {
            Navigator.pushReplacementNamed(
              context,
              '/basicInformationTouristView',
            );
          }
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
                onPressed:
                    () => Navigator.pushReplacementNamed(
                      context,
                      '/accountTypeView',
                    ), // ⭐ غيّر للـ account type
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
                child: Form(
                  key: cubit.signUpFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CustomTextSemiBold(
                          text: 'sign_up'.tr(),
                          fontSize: 32,
                        ),
                      ),
                      Center(
                        child: CustomTextRegolar(text: 'signup_subtitle'.tr()),
                      ),

                      const SizedBox(height: 24),

                      CustomTextSemiBold(fontSize: 16, text: 'name'.tr()),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        hintText: 'enter_name'.tr(),
                        controller: cubit.signUpNameController,
                      ),

                      SizedBox(height: 8.h),
                      CustomTextSemiBold(fontSize: 16, text: 'email'.tr()),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        hintText: 'enter_email'.tr(),
                        controller: cubit.signUpEmailController,
                      ),

                      SizedBox(height: 8.h),
                      CustomTextSemiBold(fontSize: 16, text: 'password'.tr()),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        hintText: 'enter_password'.tr(),
                        isPassword: true,
                        controller: cubit.signUpPasswordController,
                      ),

                      SizedBox(height: 8.h),
                      CustomTextSemiBold(
                        fontSize: 16,
                        text: 'confirm_password'.tr(),
                      ),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        hintText: 'confirm_password'.tr(),
                        isPassword: true,
                        controller: cubit.signUpConfirmPasswordController,
                      ),

                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          const CircleCheckButton(),
                          SizedBox(width: 4.w),
                          CustomTextSemiBold(
                            text: 'agree_with'.tr(),
                            fontSize: 14,
                          ),
                          SizedBox(width: 5.w),
                          CustomTextButton(text: 'terms_conditions'.tr()),
                        ],
                      ),

                      const SizedBox(height: 64),
                      CustomButton(
                        text: 'sign_up'.tr(),
                        onTap: () {
                          if (cubit.signUpFormKey.currentState!.validate() &&
                              cubit.signUpConfirmPasswordController.text ==
                                  cubit.signUpPasswordController.text) {
                            cubit
                                .signup(); // 🔥 هيقرأ الـ role من الـ store تلقائياً
                          }
                        },
                      ),

                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 90.w, child: Divider()),
                          SizedBox(width: 5.w),
                          Text(
                            'or_sign_up_with'.tr(),
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(width: 5.w),
                          SizedBox(width: 90.w, child: Divider()),
                        ],
                      ),

                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/logos_facebook.png'),
                          SizedBox(width: 56.w),
                          Image.asset('assets/icons/icons_google.png'),
                        ],
                      ),

                      SizedBox(height: 11.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'already_have_account'.tr(),
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(width: 5.w),
                          CustomTextButton(
                            text: 'sign_in'.tr(),
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                '/signInView',
                              );
                            },
                          ),
                        ],
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
