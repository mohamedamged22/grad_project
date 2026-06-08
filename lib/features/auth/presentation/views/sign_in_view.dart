import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/core/utils/pref_helper.dart';
import 'package:beyond_the_pramids/core/utils/widgets/loading_overlay.dart';
import 'package:beyond_the_pramids/core/utils/widgets/snack_bar.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_regolar.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_semi_bold.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/language_aware_content.dart';
import 'package:beyond_the_pramids/features/auth/presentation/manger/auth_cubit/auth_cubit.dart';
import 'package:beyond_the_pramids/features/auth/presentation/manger/auth_cubit/auth_state.dart';
import 'package:beyond_the_pramids/features/auth/presentation/views/widgets/custom_text_button.dart';
import 'package:beyond_the_pramids/features/auth/presentation/views/widgets/custom_text_field.dart';
import 'package:beyond_the_pramids/features/auth/presentation/views/widgets/account_role_slider.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});
  @override
  Widget build(BuildContext context) {
    final store = AccountTypeStore();
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state is AuthLoading) {
          showLoadingOverlay(context);
        } else if (state is AuthSuccess) {
          hideLoadingOverlay(context);
          showSnackBar(context, 'login_success'.tr(), isSuccess: true);

          final selectedRole = store.selectedType;
          await PrefHelper.saveUserRole(
            selectedRole,
          ); 

          debugPrint('resolved role = $selectedRole');

          if (selectedRole == 'guide') {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/guideHomeRootView',
              (route) => false,
            );
          } else {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/touristHomeRootView',
              (route) => false,
            );
          }
        } else if (state is AuthError) {
          hideLoadingOverlay(context);
          showSnackBar(context, state.message, isSuccess: false);
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/onboarding');
                },
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
                  key: context.read<AuthCubit>().signInFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CustomTextSemiBold(
                          text: 'sign_in'.tr(),
                          fontSize: 32,
                        ),
                      ),
                      Center(
                        child: CustomTextRegolar(text: 'signin_subtitle'.tr()),
                      ),
                      const SizedBox(height: 16),
                      const AccountRoleSlider(),
                      const SizedBox(height: 24),

                      CustomTextSemiBold(fontSize: 16, text: 'email'.tr()),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        hintText: 'email'.tr(),
                        controller:
                            context.read<AuthCubit>().signInEmailController,
                      ),

                      SizedBox(height: 8.h),
                      CustomTextSemiBold(fontSize: 16, text: 'password'.tr()),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        hintText: 'password'.tr(),
                        isPassword: true,
                        controller:
                            context.read<AuthCubit>().signInPasswordController,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomTextButton(
                            text: 'forgot_password'.tr(),
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                '/forgetPasswordView',
                              );
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 64),
                      CustomButton(
                        text: 'login'.tr(),
                        onTap: () {
                          if (context
                              .read<AuthCubit>()
                              .signInFormKey
                              .currentState!
                              .validate()) {
                            context.read<AuthCubit>().login();
                          }
                        },
                      ),

                      SizedBox(height: 8.h),
                      Builder(builder: (context) {
                        final isDark = Theme.of(context).brightness == Brightness.dark;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 90.w, child: Divider(color: isDark ? const Color(0xFF304250) : null)),
                            SizedBox(width: 5.w),
                            Text(
                              'or_continue_with'.tr(),
                              style: TextStyle(
                                color: isDark ? const Color(0xFF8FA0AE) : AppColor.primaryColor,
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            SizedBox(width: 90.w, child: Divider(color: isDark ? const Color(0xFF304250) : null)),
                          ],
                        );
                      }),

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
                      Builder(builder: (context) {
                        final isDark = Theme.of(context).brightness == Brightness.dark;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'dont_have_account'.tr(),
                              style: TextStyle(
                                color: isDark ? const Color(0xFF8FA0AE) : AppColor.primaryColor,
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            CustomTextButton(
                              text: 'signup'.tr(),
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/signUpView',
                                );
                              },
                            ),
                          ],
                        );
                      }),
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
