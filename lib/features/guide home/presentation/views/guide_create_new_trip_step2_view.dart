import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_semi_bold.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/views/widgets/date_picker_bottom_sheet.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/custom_dropdown_field.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/manger/guide_create_new_trip_step2_cubit/guide_create_new_trip_step2_cubit.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/step_progress_indicator.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class GuideCreateNewTripStep2View extends StatelessWidget {
  const GuideCreateNewTripStep2View({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GuideCreateNewTripStep2Cubit>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pageBg = Theme.of(context).scaffoldBackgroundColor;
    final primaryText = isDark ? Colors.white : AppColor.primaryColor;

    return BlocBuilder<
      GuideCreateNewTripStep2Cubit,
      GuideCreateNewTripStep2State
    >(
      builder: (context, state) {
        final rangeText =
            state.dateRange == null
                ? 'Select available date'
                : '${DateFormat('dd/MM/yyyy').format(state.dateRange!.start)} - ${DateFormat('dd/MM/yyyy').format(state.dateRange!.end)}';

        return Scaffold(
          backgroundColor: pageBg,
          appBar: AppBar(
            backgroundColor: pageBg,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColor.primaryColor,
                size: 18.sp,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Create New Trip',
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
                    const StepProgressIndicator(currentStep: 2, totalSteps: 4),
                    SizedBox(height: 16.h),

                    CustomTextSemiBold(text: 'Available Date', fontSize: 15.sp),
                    SizedBox(height: 6.h),
                    InkWell(
                      onTap: () async {
                        await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder:
                              (context) => DatePickerBottomSheet(
                                onDateRangeSelected: cubit.setDateRange,
                              ),
                        );
                      },
                      borderRadius: BorderRadius.circular(24.r),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.r),
                          border: Border.all(
                            color: AppColor.primaryColor,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                rangeText,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color:
                                      state.dateRange == null
                                          ? const Color(0xFF929292)
                                          : AppColor.primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(
                              Icons.calendar_today_outlined,
                              color: AppColor.secondaryColor,
                              size: 16.sp,
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 12.h),
                    CustomTextSemiBold(text: 'Tour Duration', fontSize: 15.sp),
                    SizedBox(height: 6.h),
                    CustomDropdownField(
                      hint: 'Select',
                      value: state.selectedDuration,
                      items: cubit.durations,
                      onChanged: cubit.selectDuration,
                    ),

                    SizedBox(height: 14.h),
                    CustomTextSemiBold(text: 'Group Size', fontSize: 15.sp),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Text(
                          'Max',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColor.secondaryColor,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        _CounterButton(
                          icon: Icons.remove,
                          onTap: cubit.decreaseMax,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '${state.maxGroupSize}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColor.primaryColor,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        _CounterButton(
                          icon: Icons.add,
                          onTap: cubit.increaseMax,
                        ),

                        const Spacer(),

                        Text(
                          'Min',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColor.secondaryColor,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        _CounterButton(
                          icon: Icons.remove,
                          onTap: cubit.decreaseMin,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '${state.minGroupSize}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColor.primaryColor,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        _CounterButton(
                          icon: Icons.add,
                          onTap: cubit.increaseMin,
                        ),
                      ],
                    ),

                    SizedBox(height: 14.h),
                    CustomTextSemiBold(text: 'Description', fontSize: 15.sp),
                    SizedBox(height: 6.h),
                    TextFormField(
                      controller: cubit.descriptionController,
                      minLines: 4,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText:
                            'Describe what tourists will experience during the trip ...',
                        hintStyle: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xFF929292),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 12.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.r),
                          borderSide: BorderSide(
                            color: AppColor.primaryColor,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.r),
                          borderSide: BorderSide(
                            color: AppColor.primaryColor,
                            width: 1.4,
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
                text: 'Next',
                onTap: () {
                  if (cubit.formKey.currentState!.validate()) {
                    FocusScope.of(context).unfocus();
                    Navigator.pushNamed(
                      context,
                      '/guideCreateNewTripStep3View',
                    );
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CounterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CounterButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        width: 20.w,
        height: 20.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFE7EEF3),
        ),
        child: Icon(icon, size: 13.sp, color: AppColor.secondaryColor),
      ),
    );
  }
}
