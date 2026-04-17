import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/core/utils/widgets/snack_bar.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_semi_bold.dart';
import 'package:beyond_the_pramids/features/auth/presentation/views/widgets/custom_text_field.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/manger/ProfessionalInfoCubit/professional_info_cubit.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/custom_dropdown_field.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/guide_type_selector.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/specialization_selector%20.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/step_progress_indicator.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfessionalInformationView extends StatefulWidget {
  const ProfessionalInformationView({super.key});

  @override
  State<ProfessionalInformationView> createState() =>
      _ProfessionalInformationViewState();
}

class _ProfessionalInformationViewState
    extends State<ProfessionalInformationView> {
  // ✅ UI values محلية للـ setState
  String selectedGuideType = 'Licensed Guide';
  String? selectedExperience;
  List<String> selectedSpecializations = [];

  static const Map<String, String> _expTranslationKeys = {
    '1 Year': 'guide_exp_1',
    '2 Years': 'guide_exp_2',
    '3 Years': 'guide_exp_3',
    '4 Years': 'guide_exp_4',
    '5 Years': 'guide_exp_5',
    '5+ Years': 'guide_exp_5plus',
    '10+ Years': 'guide_exp_10plus',
  };

  final List<String> experienceYears = [
    '1 Year',
    '2 Years',
    '3 Years',
    '4 Years',
    '5 Years',
    '5+ Years',
    '10+ Years',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfessionalInfoCubit, ProfessionalInfoState>(
      listener: (context, state) {
        if (state is ProfessionalInfoLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is ProfessionalInfoSuccess) {
          Navigator.of(context).pop();
          Navigator.pushReplacementNamed(context, '/guideLanguagesView');
        } else if (state is ProfessionalInfoError) {
          if (Navigator.of(context).canPop()) Navigator.of(context).pop();
          showSnackBar(context, state.message, isSuccess: false);
        }
      },
      builder: (context, state) {
        final cubit = context.read<ProfessionalInfoCubit>();

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SingleChildScrollView(
                  child: Form(
                    key: cubit.formKey, // ✅
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30.h),
                        const StepProgressIndicator(currentStep: 2),
                        SizedBox(height: 50.h),

                        CustomTextSemiBold(
                          fontSize: 16,
                          text: 'guide_type'.tr(),
                        ),
                        SizedBox(height: 16.h),
                        TwoTypeSelector(
                          title1: 'guide_licensed'.tr(),
                          title2: 'guide_local'.tr(),
                          selectedType: selectedGuideType,
                          onTypeSelected: (type) {
                            setState(() => selectedGuideType = type);
                            // ✅ حدّث الـ cubit
                            cubit.selectedGuideType = cubit.mapGuideType(type);
                          },
                        ),

                        SizedBox(height: 24.h),
                        CustomTextSemiBold(
                          fontSize: 16,
                          text: 'guide_license_number'.tr(),
                        ),
                        SizedBox(height: 16.h),
                        CustomTextField(
                          hintText: 'guide_enter_license'.tr(),
                          controller: cubit.licenseController, // ✅
                        ),

                        SizedBox(height: 24.h),
                        CustomTextSemiBold(
                          fontSize: 16,
                          text: 'guide_experience'.tr(),
                        ),
                        SizedBox(height: 16.h),
                        CustomDropdownField(
                          hint: 'guide_select_experience'.tr(),
                          value: selectedExperience,
                          items: experienceYears,
                          displayMapper:
                              (item) =>
                                  (_expTranslationKeys[item] ?? item).tr(),
                          onChanged: (value) {
                            setState(() => selectedExperience = value);
                            // ✅ حدّث الـ cubit
                            if (value != null) {
                              cubit.selectedExperience = cubit.mapExperience(
                                value,
                              );
                            }
                          },
                        ),

                        SizedBox(height: 16.h),
                        CustomTextSemiBold(
                          fontSize: 16,
                          text: 'guide_specialization'.tr(),
                        ),
                        SizedBox(height: 24.h),
                        SpecializationSelector(
                          selectedSpecializations: selectedSpecializations,
                          onSpecializationsChanged: (newSelection) {
                            setState(
                              () => selectedSpecializations = newSelection,
                            );
                            // ✅ حدّث الـ cubit
                            cubit.selectedSpecializations = newSelection;
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
                    if (cubit.formKey.currentState!.validate()) {
                      if (selectedExperience == null) {
                        showSnackBar(
                          context,
                          'guide_select_experience_years'.tr(),
                          isSuccess: false,
                        );
                        return;
                      }
                      if (cubit.selectedSpecializations.isEmpty) {
                        showSnackBar(
                          context,
                          'guide_select_specialization'.tr(),
                          isSuccess: false,
                        );
                        return;
                      }
                      cubit.submitProfessionalInfo();
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
