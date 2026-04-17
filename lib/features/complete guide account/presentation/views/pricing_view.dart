import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/core/utils/widgets/snack_bar.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_semi_bold.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/manger/Pricing/pricing_cubit.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/custom_dropdown_field.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/guide_type_selector.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/step_progress_indicator.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PricingView extends StatefulWidget {
  const PricingView({super.key});

  @override
  State<PricingView> createState() => _PricingViewState();
}

class _PricingViewState extends State<PricingView> {
  String selectedGuideType = 'Group Tour';
  List<String> selectedAreas = [];
  String? tourduration;

  static const Map<String, String> _durationKeys = {
    '1 - 2 Hours': 'pricing_duration_1_2',
    '3 - 4 Hours': 'pricing_duration_3_4',
    '6 - 8 Hours': 'pricing_duration_6_8',
    '10 - 12 Hours': 'pricing_duration_10_12',
    'Flexible': 'pricing_duration_flexible',
  };

  static const Map<String, String> _cityKeys = {
    'Cairo': 'city_cairo',
    'Giza': 'city_giza',
    'Alexandria': 'city_alexandria',
    'Luxor': 'city_luxor',
    'Aswan': 'city_aswan',
    'Hurghada': 'city_hurghada',
    'Sharm El Sheikh': 'city_sharm',
    'Dahab': 'city_dahab',
    'Marsa Matrouh': 'city_marsa',
    'Siwa Oasis': 'city_siwa',
    'Fayoum': 'city_fayoum',
    'North Coast': 'city_north_coast',
  };

  final List<String> tourdurations = [
    '1 - 2 Hours',
    '3 - 4 Hours',
    '6 - 8 Hours',
    '10 - 12 Hours',
    'Flexible',
  ];

  final List<String> coveredAreas = [
    'Cairo',
    'Giza',
    'Alexandria',
    'Luxor',
    'Aswan',
    'Hurghada',
    'Sharm El Sheikh',
    'Dahab',
    'Marsa Matrouh',
    'Siwa Oasis',
    'Fayoum',
    'North Coast',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PricingCubit, PricingState>(
      listener: (context, state) {
        if (state is PricingLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is PricingSuccess) {
          Navigator.of(context).pop();
          Navigator.pushReplacementNamed(context, '/verificationView');
        } else if (state is PricingError) {
          if (Navigator.of(context).canPop()) Navigator.of(context).pop();
          showSnackBar(context, state.message, isSuccess: false);
        }
      },
      builder: (context, state) {
        final cubit = context.read<PricingCubit>();

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30.h),
                      const StepProgressIndicator(currentStep: 4),
                      SizedBox(height: 50.h),

                      CustomTextSemiBold(
                        fontSize: 16,
                        text: 'pricing_tour_type'.tr(),
                      ),
                      SizedBox(height: 16.h),
                      TwoTypeSelector(
                        title1: 'pricing_group_tour'.tr(),
                        title2: 'pricing_private_tour'.tr(),
                        selectedType: selectedGuideType,
                        onTypeSelected: (type) {
                          setState(() => selectedGuideType = type);
                          cubit.selectedTourType = cubit.mapTourType(type); // ✅
                        },
                      ),

                      SizedBox(height: 16.h),
                      CustomTextSemiBold(
                        fontSize: 16,
                        text: 'pricing_covered_areas'.tr(),
                      ),
                      SizedBox(height: 16.h),
                      CustomDropdownField(
                        hint: 'pricing_select_areas'.tr(),
                        value: null,
                        items: coveredAreas,
                        onChanged: (_) {},
                        multiSelect: true, // ✅
                        selectedItems: selectedAreas, // ✅
                        displayMapper: (item) => (_cityKeys[item] ?? item).tr(),
                        onMultiChanged: (areas) {
                          setState(() => selectedAreas = areas);
                          cubit.selectedAreas = areas; // ✅
                        },
                      ),

                      SizedBox(height: 16.h),
                      CustomTextSemiBold(
                        fontSize: 16,
                        text: 'pricing_tour_duration'.tr(),
                      ),
                      SizedBox(height: 16.h),
                      CustomDropdownField(
                        hint: 'pricing_select'.tr(),
                        items: tourdurations,
                        value: tourduration,
                        displayMapper:
                            (item) => (_durationKeys[item] ?? item).tr(),
                        onChanged: (value) {
                          setState(() => tourduration = value);
                          if (value != null) {
                            cubit.selectedDuration = cubit.mapDuration(
                              value,
                            ); // ✅
                          }
                        },
                      ),

                      SizedBox(height: 100.h),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: SizedBox(
              height: 150.h,
              child: Center(
                child: CustomButton(
                  text: 'next'.tr(),
                  width: 230,
                  onTap: () => cubit.submitPricing(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
