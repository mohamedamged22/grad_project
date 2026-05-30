import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/core/utils/widgets/snack_bar.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_semi_bold.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/step_progress_indicator.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/manager/Tourist%20Preferences/tourist_preferences_cubit.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/views/widgets/food_preference_section.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/views/widgets/special_needs_section.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/views/widgets/travel_preference_section.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TouristPreferencesView extends StatelessWidget {
  const TouristPreferencesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TouristPreferencesCubit, TouristPreferencesState>(
      listener: (context, state) {
        if (state is TouristPreferencesLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is TouristPreferencesSuccess) {
          Navigator.of(context).pop();
          Navigator.pushReplacementNamed(context, '/successCompleteDataView');
        } else if (state is TouristPreferencesError) {
          if (Navigator.of(context).canPop()) Navigator.of(context).pop();
          showSnackBar(context, state.message, isSuccess: false);
        }
      },
      builder: (context, state) {
        final cubit = context.read<TouristPreferencesCubit>();

        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30.h),
                      const StepProgressIndicator(currentStep: 5),
                      SizedBox(height: 30.h),
                      CustomTextSemiBold(
                        fontSize: 18.sp,
                        text: 'pref_special_needs'.tr(),
                      ),
                      SizedBox(height: 16.h),
                      SpecialNeedsSection(
                        onChanged: (String value) {
                          cubit.specialNeeds = value;
                        },
                      ),
                      SizedBox(height: 16.h),
                      CustomTextSemiBold(
                        fontSize: 18.sp,
                        text: 'pref_travel_preference'.tr(),
                      ),
                      SizedBox(height: 16.h),
                      TravelPreferenceSection(
                        onChanged: (List<String> prefs) {
                          cubit.travelPreferences = prefs;
                        },
                      ),
                      SizedBox(height: 16.h),
                      CustomTextSemiBold(
                        fontSize: 18.sp,
                        text: 'pref_food_preference'.tr(),
                      ),
                      SizedBox(height: 16.h),
                      FoodPreferenceSection(
                        onChanged: (String value) {
                          cubit.foodPreference = value;
                        },
                      ),
                      Text(
                        'pref_please_specify'.tr(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Color(0xffF89422),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      TextField(
                        controller: cubit.foodAllergiesController,
                        decoration: InputDecoration(
                          hintText: 'pref_write_here'.tr(),
                          hintStyle: TextStyle(
                            fontSize: 14.sp,
                            color: Color(0xff797979),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                            borderSide: BorderSide(
                              color: AppColor.secondaryColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                            borderSide: BorderSide(
                              color: AppColor.secondaryColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                            borderSide: BorderSide(
                              color: AppColor.secondaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      CustomTextSemiBold(
                        fontSize: 18.sp,
                        text: 'pref_notes'.tr(),
                      ),
                      SizedBox(height: 16.h),
                      TextField(
                        controller: cubit.notesController,
                        maxLines: 4,
                        maxLength: 200,
                        decoration: InputDecoration(
                          hintText: 'pref_notes_hint'.tr(),
                          hintStyle: TextStyle(
                            fontSize: 14.sp,
                            color: Color(0xff797979),
                          ),
                          contentPadding: EdgeInsets.all(16.w),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r),
                            borderSide: BorderSide(
                              color: AppColor.secondaryColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r),
                            borderSide: BorderSide(
                              color: AppColor.secondaryColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r),
                            borderSide: BorderSide(
                              color: AppColor.secondaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: SizedBox(
            height: 100.h,
            child: Center(
              child: CustomButton(
                text: 'next'.tr(),
                width: 230.w,
                onTap: () {
                  cubit.submitPreferences();
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
