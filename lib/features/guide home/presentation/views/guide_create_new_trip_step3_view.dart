import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_semi_bold.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/custom_dropdown_field.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/manger/guide_create_new_trip_step3_cubit/guide_create_new_trip_step3_cubit.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/step_progress_indicator.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuideCreateNewTripStep3View extends StatelessWidget {
  const GuideCreateNewTripStep3View({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GuideCreateNewTripStep3Cubit>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pageBg = Theme.of(context).scaffoldBackgroundColor;
    final primaryText = isDark ? Colors.white : AppColor.primaryColor;

    return BlocBuilder<
      GuideCreateNewTripStep3Cubit,
      GuideCreateNewTripStep3State
    >(
      builder: (context, state) {
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
                    const StepProgressIndicator(currentStep: 3, totalSteps: 4),
                    SizedBox(height: 16.h),

                    CustomTextSemiBold(
                      text: 'Price per Tourist',
                      fontSize: 15.sp,
                    ),
                    SizedBox(height: 6.h),
                    CustomDropdownField(
                      hint: 'Select price',
                      value: state.selectedPrice,
                      items: cubit.priceOptions,
                      onChanged: cubit.selectPrice,
                    ),

                    SizedBox(height: 14.h),
                    CustomTextSemiBold(
                      text: "What's Included ?",
                      fontSize: 15.sp,
                    ),
                    SizedBox(height: 10.h),
                    ...state.includedItems.keys.map((item) {
                      return _IncludedOptionRow(
                        title: item,
                        value: state.includedItems[item] ?? false,
                        onChanged:
                            (value) =>
                                cubit.setIncludedItem(item, value ?? false),
                      );
                    }),

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
                      '/guideCreateNewTripStep4View',
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

class _IncludedOptionRow extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const _IncludedOptionRow({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        children: [
          SizedBox(
            width: 20.w,
            height: 20.w,
            child: Checkbox(
              value: value,
              activeColor: AppColor.secondaryColor,
              side: BorderSide(color: AppColor.secondaryColor, width: 1.2),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              onChanged: onChanged,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                color: isDark ? Colors.white : AppColor.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
