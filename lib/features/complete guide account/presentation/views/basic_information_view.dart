import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/core/utils/widgets/snack_bar.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_semi_bold.dart';
import 'package:beyond_the_pramids/features/auth/presentation/views/widgets/custom_text_field.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/manger/basic%20info_cubit/basic_info_cubit.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/custom_dropdown_field.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/step_progress_indicator.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasicInformationView extends StatefulWidget {
  const BasicInformationView({super.key});

  @override
  State<BasicInformationView> createState() => _BasicInformationViewState();
}

class _BasicInformationViewState extends State<BasicInformationView> {
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

  final List<String> cities = [
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
  void initState() {
    super.initState();

    final cubit = context.read<BasicInfoCubit>();

    cubit.phoneController.text = '+20';

    cubit.phoneController.addListener(() {
      final text = cubit.phoneController.text;
      final selection = cubit.phoneController.selection;

      if (!text.startsWith('+20')) {
        cubit.phoneController.value = TextEditingValue(
          text: '+20',
          selection: TextSelection.fromPosition(TextPosition(offset: 3)),
        );
      }

      if (selection.baseOffset < 3) {
        cubit.phoneController.selection = TextSelection.fromPosition(
          TextPosition(offset: 3),
        );
      }
    });

    _checkForExistingData();
  }

  Future<void> _checkForExistingData() async {
    try {
      await context.read<BasicInfoCubit>().loadBasicInfo();
    } catch (e) {
      debugPrint('ℹ️ No existing data (first time user)');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BasicInfoCubit, BasicInfoState>(
      listener: (context, state) {
        if (state is BasicInfoLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is BasicInfoSuccess) {
          Navigator.of(context).pop();

          showSnackBar(context, state.message, isSuccess: true);
          Navigator.pushReplacementNamed(
            context,
            '/professionalInformationView',
          );
        } else if (state is BasicInfoError) {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }

          showSnackBar(context, state.message, isSuccess: false);
        } else if (state is BasicInfoLoaded) {}
      },
      builder: (context, state) {
        final cubit = context.read<BasicInfoCubit>();

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SingleChildScrollView(
                  child: Form(
                    key: cubit.basicInfoFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(height: 30.h),

                        const StepProgressIndicator(currentStep: 1),

                        SizedBox(height: 50.h),

                        CustomTextSemiBold(
                          fontSize: 16,
                          text: 'guide_basic_name'.tr(),
                        ),
                        SizedBox(height: 8.h),
                        CustomTextField(
                          hintText: 'guide_basic_enter_name'.tr(),
                          controller: cubit.nameController,
                        ),

                        SizedBox(height: 16.h),

                        // Email Field
                        CustomTextSemiBold(
                          fontSize: 16,
                          text: 'guide_basic_email'.tr(),
                        ),
                        SizedBox(height: 8.h),
                        CustomTextField(
                          hintText: 'guide_basic_enter_email'.tr(),
                          controller: cubit.emailController,
                        ),

                        SizedBox(height: 16.h),

                        // Phone Field
                        CustomTextSemiBold(
                          fontSize: 16,
                          text: 'guide_basic_phone'.tr(),
                        ),
                        SizedBox(height: 8.h),
                        CustomTextField(
                          hintText: '1XXXXXXXXX',
                          controller: cubit.phoneController,
                          isPhone: true, // ✅
                          prefixIcon: Icon(
                            Icons.phone,
                            color: AppColor.primaryColor,
                          ),
                        ),

                        SizedBox(height: 16.h),

                        // City Field
                        CustomTextSemiBold(
                          fontSize: 16,
                          text: 'guide_basic_city'.tr(),
                        ),
                        SizedBox(height: 8.h),
                        CustomDropdownField(
                          hint: 'guide_basic_enter_city'.tr(),
                          items: cities,
                          value: cubit.selectedCity,
                          displayMapper:
                              (item) => (_cityKeys[item] ?? item).tr(),
                          onChanged: (value) {
                            setState(() => cubit.selectedCity = value);
                          },
                        ),

                        SizedBox(height: 140.h),
                      ],
                    ),
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
                  onTap: () {
                    if (cubit.basicInfoFormKey.currentState!.validate()) {
                      debugPrint('📝 Form validated - submitting...');
                      cubit.submitBasicInfo();
                    } else {
                      debugPrint('❌ Form validation failed');
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
