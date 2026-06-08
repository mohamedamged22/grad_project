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

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final fromProfileFlow =
        args is Map<String, dynamic> && args['fromProfileFlow'] == true;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showLoadingOverlay(context);
        } else if (state is ForgetPasswordSuccess) {
          hideLoadingOverlay(context);
          showSnackBar(context, state.message, isSuccess: true);
          Navigator.pushReplacementNamed(
            context,
            '/otpView',
            arguments: {'fromProfileFlow': fromProfileFlow},
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
                onPressed:
                    () {
                      if (fromProfileFlow) {
                        Navigator.pop(context);
                        return;
                      }

                      Navigator.pushReplacementNamed(context, '/signInView');
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
                  key: cubit.forgetPasswordFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      CustomTextSemiBold(
                        text: 'forgot_password_title'.tr(),
                        fontSize: 24,
                      ),
                      SizedBox(height: 4.h),
                      CustomTextRegolar(text: 'forgot_password_subtitle'.tr()),
                      SizedBox(height: 24.h),

                      CustomTextSemiBold(fontSize: 16, text: 'email'.tr()),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        hintText: 'email'.tr(),
                        controller: cubit.forgetPasswordEmailController,
                      ),

                      const SizedBox(height: 80),
                      Center(
                        child: CustomButton(
                          text: 'send_code'.tr(),
                          width: 260,
                          onTap: () {
                            if (cubit.forgetPasswordFormKey.currentState!
                                .validate()) {
                              cubit.forgetPassword();
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
