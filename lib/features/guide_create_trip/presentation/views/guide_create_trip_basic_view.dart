import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/core/utils/widgets/loading_overlay.dart';
import 'package:beyond_the_pramids/core/utils/widgets/snack_bar.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_semi_bold.dart';
import 'package:beyond_the_pramids/features/auth/presentation/views/widgets/custom_text_field.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/custom_dropdown_field.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/step_progress_indicator.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/presentation/manager/guide_create_trip_basic_cubit/guide_create_trip_basic_cubit.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/presentation/views/guide_select_landmarks_view.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuideCreateTripBasicView extends StatelessWidget {
  const GuideCreateTripBasicView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GuideCreateTripBasicCubit>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pageBg = Theme.of(context).scaffoldBackgroundColor;
    final primaryText = isDark ? Colors.white : AppColor.primaryColor;

    return BlocConsumer<GuideCreateTripBasicCubit, GuideCreateTripBasicState>(
      listener: (context, state) {
        if (state.status == GuideCreateTripBasicStatus.loading) {
          showLoadingOverlay(context);
          return;
        }

        if (state.status == GuideCreateTripBasicStatus.success) {
          hideLoadingOverlay(context);
          showSnackBar(
            context,
            state.message ?? 'guide_trip_created'.tr(),
            isSuccess: true,
          );
          Navigator.pushNamed(context, '/guideCreateTripStep2View');
          return;
        }

        if (state.status == GuideCreateTripBasicStatus.failure) {
          hideLoadingOverlay(context);
          showSnackBar(
            context,
            state.message ?? 'guide_trip_create_failed'.tr(),
            isSuccess: false,
          );
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            if (state.status == GuideCreateTripBasicStatus.failure) {
              showSnackBar(
                context,
                'guide_trip_fix_error'.tr(),
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
                color: AppColor.secondaryColor,
                size: 18.sp,
              ),
              onPressed: () {
                if (state.status == GuideCreateTripBasicStatus.failure) {
                  showSnackBar(
                    context,
                    'guide_trip_fix_error'.tr(),
                    isSuccess: false,
                  );
                  return;
                }
                Navigator.pop(context);
              },
            ),
            title: Text(
              'guide_trip_create_title'.tr(),
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: primaryText,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.bookmark_border_rounded,
                  color: AppColor.secondaryColor,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 4.w),
            ],
          ),
            body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 6.h),
                    const StepProgressIndicator(currentStep: 1, totalSteps: 4),
                    SizedBox(height: 16.h),
                    CustomTextSemiBold(
                      text: 'guide_trip_title_label'.tr(),
                      fontSize: 15.sp,
                    ),
                    SizedBox(height: 6.h),
                    CustomTextField(
                      controller: cubit.tripTitleController,
                      hintText: 'guide_trip_title_hint'.tr(),
                    ),
                    SizedBox(height: 12.h),
                    CustomTextSemiBold(
                      text: 'guide_trip_category_label'.tr(),
                      fontSize: 15.sp,
                    ),
                    SizedBox(height: 16.h),
                    Wrap(
                      spacing: 10.w,
                      runSpacing: 10.h,
                      children:
                          cubit.categories.map((category) {
                            final isSelected = state.selectedCategories
                                .contains(category);
                            return _CategoryChip(
                              title: category,
                              isSelected: isSelected,
                              onTap: () => cubit.toggleCategory(category),
                            );
                          }).toList(),
                    ),
                    SizedBox(height: 14.h),
                    CustomTextSemiBold(
                      text: 'guide_trip_city_label'.tr(),
                      fontSize: 15.sp,
                    ),
                    SizedBox(height: 6.h),
                    CustomDropdownField(
                      hint: 'guide_trip_city_hint'.tr(),
                      value: state.selectedCity,
                      items: cubit.cities,
                      onChanged: cubit.selectCity,
                    ),
                    SizedBox(height: 12.h),
                    CustomTextSemiBold(
                      text: 'guide_trip_meeting_point_label'.tr(),
                      fontSize: 15.sp,
                    ),
                    SizedBox(height: 6.h),
                    CustomTextField(
                      controller: cubit.meetingPointController,
                      hintText: 'guide_trip_meeting_point_hint'.tr(),
                      suffixIcon: Icon(
                        Icons.location_on_outlined,
                        color: AppColor.secondaryColor,
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: TextButton.icon(
                        onPressed: () async {
                          final result = await Navigator.pushNamed(
                            context,
                            '/guideTripMapView',
                          );
                          if (result is String && result.trim().isNotEmpty) {
                            cubit.setMeetingPoint(result);
                          }
                        },
                        icon: Icon(
                          Icons.map_outlined,
                          size: 18.sp,
                          color: AppColor.secondaryColor,
                        ),
                        label: Text(
                          'guide_trip_choose_from_map'.tr(),
                          style: TextStyle(
                            color: AppColor.secondaryColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    // بعد الـ meeting point TextButton.icon بتاع الـ map
                      SizedBox(height: 12.h),
                      CustomTextSemiBold(
                        text: 'guide_trip_landmarks_label'.tr(),
                        fontSize: 15.sp,
                      ),
                      SizedBox(height: 6.h),

                      // عرض الـ chips المختارة
                      if (state.selectedLandmarkIds.isNotEmpty)
                        Wrap(
                          spacing: 8.w,
                          runSpacing: 6.h,
                          children:
                              state.selectedLandmarkIds.map((id) {
                                return Chip(
                                  label: Text(
                                    '#$id',
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                  backgroundColor: AppColor.secondaryColor,
                                  deleteIconColor: Colors.white,
                                  onDeleted: () {
                                    final updated = Set<int>.from(
                                      state.selectedLandmarkIds,
                                    )..remove(id);
                                    cubit.setSelectedLandmarks(
                                      updated.toList(),
                                    );
                                  },
                                );
                              }).toList(),
                        ),

                      SizedBox(height: 6.h),

                      // زرار اختيار اللاند ماركس
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: TextButton.icon(
                          onPressed: () async {
                            final result = await Navigator.push<List<int>>(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => GuideSelectLandmarksView(
                                      initialSelectedIds:
                                          state.selectedLandmarkIds.toList(),
                                    ),
                              ),
                            );
                            if (result != null) {
                              cubit.setSelectedLandmarks(result);
                            }
                          },
                          icon: Icon(
                            Icons.place_outlined,
                            size: 18.sp,
                            color: AppColor.secondaryColor,
                          ),
                          label: Text(
                            'guide_trip_choose_landmarks'.tr(),
                            style: TextStyle(
                              color: AppColor.secondaryColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    SizedBox(height: 70.h),
                  ],
                ),
              ),
            ),
          ),
            bottomNavigationBar: SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 14.h),
              child: CustomButton(
                text: 'next'.tr(),
                onTap: () {
                  if (cubit.formKey.currentState!.validate()) {
                    FocusScope.of(context).unfocus();
                    cubit.submitBasicTrip();
                  }
                },
              ),
            ),
            ),
          ),
        );
      },
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 14.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.secondaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? AppColor.secondaryColor : AppColor.primaryColor,
            width: 1,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color:
                isSelected
                    ? Colors.white
                    : Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : AppColor.primaryColor,
          ),
        ),
      ),
    );
  }
}
