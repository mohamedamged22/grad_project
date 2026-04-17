import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/core/utils/widgets/snack_bar.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_semi_bold.dart';
import 'package:beyond_the_pramids/features/auth/presentation/views/widgets/custom_text_field.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/custom_dropdown_field.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/guide_type_selector.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/step_progress_indicator.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/manager/Tourist%20Basic%20Info/tourist_basic_info_cubit.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasicInformationTouristView extends StatefulWidget {
  const BasicInformationTouristView({super.key});

  @override
  State<BasicInformationTouristView> createState() =>
      _BasicInformationTouristViewState();
}

class _BasicInformationTouristViewState
    extends State<BasicInformationTouristView> {
  String selectedType = 'Male';
  String? nationality;
  String? motherLanguage;
  List<String> knownLanguages = [];

  final List<String> languages = [
    'Arabic',
    'English',
    'French',
    'German',
    'Spanish',
    'Italian',
    'Chinese',
    'Japanese',
    'Russian',
  ];

  static const Map<String, String> _langKeys = {
    'Arabic': 'lang_arabic',
    'English': 'lang_english',
    'French': 'lang_french',
    'German': 'lang_german',
    'Spanish': 'lang_spanish',
    'Italian': 'lang_italian',
    'Chinese': 'lang_chinese',
    'Japanese': 'lang_japanese',
    'Russian': 'lang_russian',
  };

  final List<String> nationalities = [
    "American",
    "Chinese",
    "Indian",
    "Brazilian",
    "German",
    "British",
    "French",
    "Italian",
    "Japanese",
    "Russian",
    "Canadian",
    "Australian",
    "Spanish",
    "Turkish",
    "Egyptian",
  ];

  static const Map<String, String> _natKeys = {
    'American': 'nat_american',
    'Chinese': 'nat_chinese',
    'Indian': 'nat_indian',
    'Brazilian': 'nat_brazilian',
    'German': 'nat_german',
    'British': 'nat_british',
    'French': 'nat_french',
    'Italian': 'nat_italian',
    'Japanese': 'nat_japanese',
    'Russian': 'nat_russian',
    'Canadian': 'nat_canadian',
    'Australian': 'nat_australian',
    'Spanish': 'nat_spanish',
    'Turkish': 'nat_turkish',
    'Egyptian': 'nat_egyptian',
  };
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TouristBasicInfoCubit, TouristBasicInfoState>(
      listener: (context, state) {
        if (state is TouristBasicInfoLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is TouristBasicInfoSuccess) {
          Navigator.of(context).pop();

          Navigator.pushReplacementNamed(context, '/tripDetailsView');
        } else if (state is TouristBasicInfoError) {
          if (Navigator.of(context).canPop()) Navigator.of(context).pop();
          showSnackBar(context, state.message, isSuccess: false);
        } else if (state is TouristBasicInfoLoaded) {
          setState(() {});
        }
      },
      builder: (context, state) {
        final cubit = context.read<TouristBasicInfoCubit>();

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SingleChildScrollView(
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30.h),
                        const StepProgressIndicator(currentStep: 1),
                        SizedBox(height: 36.h),

                        CustomTextSemiBold(
                          fontSize: 16.sp,
                          text: 'tourist_basic_name'.tr(),
                        ),
                        SizedBox(height: 8.h),
                        CustomTextField(
                          hintText: 'tourist_basic_enter_name'.tr(),
                          controller: cubit.nameController,
                        ),

                        SizedBox(height: 16.h),
                        CustomTextSemiBold(
                          fontSize: 16.sp,
                          text: 'tourist_basic_email'.tr(),
                        ),
                        SizedBox(height: 8.h),
                        CustomTextField(
                          hintText: 'tourist_basic_enter_email'.tr(),
                          controller: cubit.emailController,
                        ),

                        SizedBox(height: 16.h),
                        CustomTextSemiBold(
                          fontSize: 16.sp,
                          text: 'tourist_basic_gender'.tr(),
                        ),
                        SizedBox(height: 8.h),
                        TwoTypeSelector(
                          selectedType: selectedType,
                          onTypeSelected: (value) {
                            setState(() => selectedType = value);
                            cubit.selectedGender = cubit.mapGender(value);
                          },
                          title1: 'tourist_basic_male'.tr(),
                          title2: 'tourist_basic_female'.tr(),
                        ),

                        SizedBox(height: 16.h),
                        CustomTextSemiBold(
                          fontSize: 16.sp,
                          text: 'tourist_basic_nationality'.tr(),
                        ),
                        SizedBox(height: 8.h),
                        CustomDropdownField(
                          hint: 'tourist_basic_select_nationality'.tr(),
                          items: nationalities,
                          value: cubit.nationality,
                          displayMapper:
                              (item) => (_natKeys[item] ?? item).tr(),
                          onChanged: (value) {
                            setState(() => cubit.nationality = value);
                          },
                        ),

                        SizedBox(height: 16.h),
                        CustomTextSemiBold(
                          fontSize: 16.sp,
                          text: 'tourist_basic_mother_language'.tr(),
                        ),
                        SizedBox(height: 8.h),
                        CustomDropdownField(
                          hint: 'tourist_basic_select_language'.tr(),
                          items: languages,
                          value: cubit.motherLanguage,
                          displayMapper:
                              (item) => (_langKeys[item] ?? item).tr(),
                          onChanged: (value) {
                            setState(() => cubit.motherLanguage = value);
                          },
                        ),

                        SizedBox(height: 16.h),
                        CustomTextSemiBold(
                          fontSize: 16.sp,
                          text: 'tourist_basic_languages_you_know'.tr(),
                        ),
                        SizedBox(height: 8.h),
                        CustomDropdownField(
                          hint: 'tourist_basic_select_language'.tr(),
                          items: languages,
                          value: null,
                          onChanged: (_) {},
                          multiSelect: true,
                          selectedItems: cubit.knownLanguages,
                          displayMapper:
                              (item) => (_langKeys[item] ?? item).tr(),
                          onMultiChanged: (selected) {
                            setState(() => cubit.knownLanguages = selected);
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
              height: 100.h,
              child: Center(
                child: CustomButton(
                  text: 'next'.tr(),
                  width: 230.w,
                  onTap: () {
                    if (cubit.formKey.currentState!.validate()) {
                      cubit.submitBasicInfo();
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
