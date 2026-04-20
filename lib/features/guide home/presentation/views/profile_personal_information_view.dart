import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/auth/presentation/views/widgets/custom_text_field.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/manger/profile_personal_information_cubit/profile_personal_information_cubit.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePersonalInformationView extends StatelessWidget {
  const ProfilePersonalInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfilePersonalInformationCubit>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pageBg = Theme.of(context).scaffoldBackgroundColor;
    final cardBg = Theme.of(context).cardColor;
    final primaryText = isDark ? Colors.white : AppColor.primaryColor;
    final hintColor =
        isDark ? const Color(0xFF8FA0AE) : const Color(0xFF929292);
    final sectionBorderColor =
        isDark ? const Color(0xFF304252) : const Color(0xFFDDE6ED);

    return BlocConsumer<
      ProfilePersonalInformationCubit,
      ProfilePersonalInformationState
    >(
      listener: (context, state) {
        if (state.status == ProfilePersonalInformationStatus.success &&
            (state.successMessage?.isNotEmpty ?? false)) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.successMessage!)));
          Navigator.pop(context, true);
        }

        if (state.status == ProfilePersonalInformationStatus.failure &&
            (state.errorMessage?.isNotEmpty ?? false)) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      builder: (context, state) {
        final isSaving =
            state.status == ProfilePersonalInformationStatus.submitting;
        final hasProfilePhoto = state.profilePhotoUrl.trim().isNotEmpty;

        return Scaffold(
          backgroundColor: pageBg,
          appBar: AppBar(
            backgroundColor: pageBg,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColor.secondaryColor,
                size: 18.sp,
              ),
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: primaryText,
              ),
            ),
          ),
          body: SafeArea(
            child: Form(
              key: cubit.formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 14.h),
                child: Container(
                  padding: EdgeInsets.fromLTRB(8.w, 6.h, 8.w, 12.h),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(18.r),
                    border: Border.all(color: sectionBorderColor, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2.h),
                      Center(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              radius: 34.r,
                              backgroundImage:
                                  hasProfilePhoto
                                      ? NetworkImage(state.profilePhotoUrl)
                                          as ImageProvider
                                      : const AssetImage(
                                        'assets/images/2th.jpg',
                                      ),
                            ),
                            Positioned(
                              right: -2.w,
                              bottom: -1.h,
                              child: Container(
                                width: 20.w,
                                height: 20.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColor.secondaryColor,
                                    width: 1,
                                  ),
                                ),
                                child: Icon(
                                  Icons.edit_outlined,
                                  size: 12.sp,
                                  color: AppColor.secondaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Center(
                        child: Text(
                          state.title,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFF4A12E),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),

                      _FieldLabel(text: 'First name', textColor: primaryText),
                      SizedBox(height: 6.h),
                      CustomTextField(
                        controller: cubit.firstNameController,
                        hintText: 'Enter your first name',
                      ),

                      SizedBox(height: 8.h),
                      _FieldLabel(text: 'Last name', textColor: primaryText),
                      SizedBox(height: 6.h),
                      CustomTextField(
                        controller: cubit.lastNameController,
                        hintText: 'Enter your last name',
                      ),

                      SizedBox(height: 8.h),
                      _FieldLabel(text: 'Email', textColor: primaryText),
                      SizedBox(height: 6.h),
                      TextFormField(
                        controller: cubit.emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          final text = value?.trim() ?? '';
                          if (text.isEmpty) {
                            return 'Email is required';
                          }
                          final emailRegExp = RegExp(
                            r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                          );
                          if (!emailRegExp.hasMatch(text)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: cardBg,
                          hintText: 'example@gmail.com',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.r),
                            borderSide: BorderSide(
                              color: AppColor.primaryColor,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.r),
                            borderSide: BorderSide(
                              color: AppColor.primaryColor,
                              width: 1.5,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 38.w,
                            vertical: 9.h,
                          ),
                        ),
                      ),

                      SizedBox(height: 8.h),
                      _FieldLabel(text: 'Phone', textColor: primaryText),
                      SizedBox(height: 6.h),
                      Container(
                        height: 46.h,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        decoration: BoxDecoration(
                          color: cardBg,
                          borderRadius: BorderRadius.circular(24.r),
                          border: Border.all(
                            color: AppColor.primaryColor,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.phone_in_talk_outlined,
                              size: 16.sp,
                              color: AppColor.secondaryColor,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              '+20',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: hintColor,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Container(
                              width: 1,
                              height: 18.h,
                              color:
                                  isDark
                                      ? const Color(0xFF415363)
                                      : const Color(0xFFD6DEE4),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: TextFormField(
                                controller: cubit.phoneController,
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  final text = value?.trim() ?? '';
                                  if (text.isEmpty) {
                                    return 'Phone is required';
                                  }
                                  final digits = text.replaceAll(
                                    RegExp(r'\D'),
                                    '',
                                  );
                                  if (digits.length < 10 ||
                                      digits.length > 11) {
                                    return 'Enter a valid Egyptian phone number';
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color:
                                      isDark
                                          ? Colors.white
                                          : AppColor.primaryColor,
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 42.h),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 46.h,
                              child: OutlinedButton(
                                onPressed:
                                    isSaving
                                        ? null
                                        : () => Navigator.pop(context),
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: AppColor.secondaryColor,
                                    width: 1.2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.r),
                                  ),
                                ),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: AppColor.secondaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: AbsorbPointer(
                              absorbing: isSaving,
                              child: CustomButton(
                                text: isSaving ? 'Saving...' : 'Save',
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  context
                                      .read<ProfilePersonalInformationCubit>()
                                      .submitProfileUpdate();
                                },
                              ),
                            ),
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

class _FieldLabel extends StatelessWidget {
  final String text;
  final Color textColor;

  const _FieldLabel({required this.text, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
    );
  }
}
