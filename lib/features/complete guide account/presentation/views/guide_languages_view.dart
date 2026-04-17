import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/core/utils/widgets/snack_bar.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/manger/Guide%20Languages/guide_languages_cubit.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/language_selector.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/step_progress_indicator.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuideLanguagesView extends StatefulWidget {
  const GuideLanguagesView({super.key});

  @override
  State<GuideLanguagesView> createState() => _GuideLanguagesViewState();
}

class _GuideLanguagesViewState extends State<GuideLanguagesView> {
  List<LanguageEntry> languages = [LanguageEntry()];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GuideLanguagesCubit, GuideLanguagesState>(
      listener: (context, state) {
        if (state is GuideLanguagesLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is GuideLanguagesSuccess) {
          Navigator.of(context).pop(); // close loading
          Navigator.pushReplacementNamed(context, '/pricingView'); // ✅
        } else if (state is GuideLanguagesError) {
          if (Navigator.of(context).canPop()) Navigator.of(context).pop();
          showSnackBar(context, state.message, isSuccess: false);
        }
      },
      builder: (context, state) {
        final cubit = context.read<GuideLanguagesCubit>();

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
                      const StepProgressIndicator(currentStep: 3),
                      SizedBox(height: 30.h),
                      LanguageSelector(
                        languages: languages,
                        onLanguagesChanged: (updatedLanguages) {
                          setState(() => languages = updatedLanguages);
                        },
                      ),
                      SizedBox(height: 140.h),
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
                  onTap: () => cubit.submitLanguages(languages),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
