import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/auth/presentation/views/widgets/custom_text_field.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/widgets/custom_button.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tourist_profile_cubit/tourist_profile_cubit.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tourist_profile_cubit/tourist_profile_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TouristPersonalInformationView extends StatelessWidget {
  const TouristPersonalInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TouristProfileCubit>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pageBg = Theme.of(context).scaffoldBackgroundColor;
    final cardBg = Theme.of(context).cardColor;
    final primaryText = isDark ? Colors.white : AppColor.primaryColor;
    final hintColor =
        isDark ? const Color(0xFF8FA0AE) : const Color(0xFF929292);
    final sectionBorderColor =
        isDark ? const Color(0xFF304252) : const Color(0xFFDDE6ED);

    return BlocConsumer<TouristProfileCubit, TouristProfileState>(
      listener: (context, state) {
        if (state is TouristProfileUpdateSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          Navigator.pop(context, true);
        }

        if (state is TouristProfileError && state.message.trim().isNotEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isSaving = state is TouristProfileLoading;
        final profile = cubit.currentProfile;
        final profilePhoto = profile?['profilePhoto']?.toString() ?? '';
        final hasProfilePhoto = profilePhoto.trim().isNotEmpty;

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
              'profile_title'.tr(),
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
                        child: CircleAvatar(
                          radius: 44.r,
                          backgroundImage: hasProfilePhoto
                              ? NetworkImage(profilePhoto) as ImageProvider
                              : const AssetImage('assets/images/2th.jpg'),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      _FieldLabel(
                        text: 'profile_first_name'.tr(),
                        textColor: primaryText,
                      ),
                      SizedBox(height: 6.h),
                      CustomTextField(
                        controller: cubit.firstNameController,
                        hintText: 'profile_first_name_hint'.tr(),
                      ),
                      SizedBox(height: 8.h),
                      _FieldLabel(
                        text: 'profile_last_name'.tr(),
                        textColor: primaryText,
                      ),
                      SizedBox(height: 6.h),
                      CustomTextField(
                        controller: cubit.lastNameController,
                        hintText: 'profile_last_name_hint'.tr(),
                      ),
                      SizedBox(height: 8.h),
                      _FieldLabel(
                        text: 'profile_email'.tr(),
                        textColor: primaryText,
                      ),
                      SizedBox(height: 6.h),
                      TextFormField(
                        controller: cubit.emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          final text = value?.trim() ?? '';
                          if (text.isEmpty) {
                            return 'profile_email_required'.tr();
                          }
                          final emailRegExp = RegExp(
                            r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                          );
                          if (!emailRegExp.hasMatch(text)) {
                            return 'profile_email_invalid'.tr();
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: cardBg,
                          hintText: 'profile_email_hint'.tr(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.r),
                            borderSide: BorderSide(
                              color: isDark ? const Color(0xFF415363) : AppColor.primaryColor,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.r),
                            borderSide: BorderSide(
                              color: isDark ? const Color(0xFF5A6A78) : AppColor.primaryColor,
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
                      _FieldLabel(
                        text: 'profile_phone'.tr(),
                        textColor: primaryText,
                      ),
                      SizedBox(height: 6.h),
                      Container(
                        height: 46.h,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        decoration: BoxDecoration(
                          color: cardBg,
                          borderRadius: BorderRadius.circular(24.r),
                          border: Border.all(
                            color: isDark ? const Color(0xFF415363) : AppColor.primaryColor,
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
                              color: isDark
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
                                    return 'profile_phone_required'.tr();
                                  }
                                  final digits = text.replaceAll(
                                    RegExp(r'\D'),
                                    '',
                                  );
                                  if (digits.length < 10 ||
                                      digits.length > 11) {
                                    return 'profile_phone_invalid_eg'.tr();
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: isDark
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
                                onPressed: isSaving
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
                                  'action_cancel'.tr(),
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
                                text:
                                  isSaving
                                    ? 'action_saving'.tr()
                                    : 'action_save'.tr(),
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  cubit.updateProfile();
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
