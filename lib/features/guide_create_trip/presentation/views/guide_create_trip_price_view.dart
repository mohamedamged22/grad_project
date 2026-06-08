import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/core/utils/widgets/loading_overlay.dart';
import 'package:beyond_the_pramids/core/utils/widgets/snack_bar.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_semi_bold.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/custom_dropdown_field.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/step_progress_indicator.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/presentation/manager/guide_create_trip_price_cubit/guide_create_trip_price_cubit.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuideCreateTripPriceView extends StatelessWidget {
  const GuideCreateTripPriceView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GuideCreateTripPriceCubit>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pageBg = Theme.of(context).scaffoldBackgroundColor;
    final primaryText = isDark ? Colors.white : AppColor.primaryColor;

    return BlocConsumer<GuideCreateTripPriceCubit, GuideCreateTripPriceState>(
      listener: (context, state) {
        if (state.status == GuideCreateTripPriceStatus.loading) {
          showLoadingOverlay(context);
          return;
        }

        if (state.status == GuideCreateTripPriceStatus.success) {
          hideLoadingOverlay(context);
          showSnackBar(context, state.message ?? 'Added', isSuccess: true);
          Navigator.pushNamed(context, '/guideCreateTripStep4View');
          return;
        }

        if (state.status == GuideCreateTripPriceStatus.failure) {
          hideLoadingOverlay(context);
          showSnackBar(
            context,
            state.message ?? 'Failed to save trip price',
            isSuccess: false,
          );
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: pageBg,
            appBar: AppBar(
            backgroundColor: pageBg,
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text(
              'Create New Trip',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: primaryText,
              ),
            ),
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
                    FormField<String>(
                      initialValue: state.selectedPrice,
                      validator: (value) {
                        final price = value ?? state.selectedPrice;
                        if (price == null || price.trim().isEmpty) {
                          return 'Please select price per tourist';
                        }
                        final parsed = double.tryParse(price.trim());
                        if (parsed == null || parsed <= 0) {
                          return 'Price per tourist must be a valid number greater than 0';
                        }
                        return null;
                      },
                      builder: (field) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomDropdownField(
                              hint: 'Select price',
                              value: state.selectedPrice,
                              items: cubit.priceOptions,
                              onChanged: (value) {
                                field.didChange(value);
                                cubit.selectPrice(value);
                              },
                            ),
                            if (field.hasError) ...[
                              SizedBox(height: 6.h),
                              Text(
                                field.errorText ?? '',
                                style: TextStyle(
                                  color: Colors.red.shade600,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ],
                        );
                      },
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
                    cubit.submitTripPrice();
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
