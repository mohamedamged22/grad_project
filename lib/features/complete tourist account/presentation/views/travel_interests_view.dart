import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/core/utils/widgets/snack_bar.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_semi_bold.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/step_progress_indicator.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/manager/Travel%20Interests/travel_interests_cubit.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/views/widgets/category_card.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TravelInterestsView extends StatefulWidget {
  const TravelInterestsView({super.key});

  @override
  State<TravelInterestsView> createState() => _TravelInterestsViewState();
}

class _TravelInterestsViewState extends State<TravelInterestsView> {
  final List<String> images = [
    'assets/images/hhhaa.jpg',
    'assets/images/2th.jpg',
    'assets/images/3th.jpg',
    'assets/images/4th.jpg',
    'assets/images/5th.jpg',
    'assets/images/6th.jpg',
    'assets/images/7th.jpg',
    'assets/images/8th.jpg',
    'assets/images/Religious.jpg',
    'assets/images/Medical.jpg',
    'assets/images/Educational.jpg',
    'assets/images/Business.jpg',
  ];
  final List<String> names = [
    'History',
    'Archaeology',
    'Culture',
    'Local life',
    'Desert',
    'Religious',
    'Beaches',
    'Food',
    'Religious',
    'Medical',
    'Educational',
    'Business',
  ];

  static const Map<String, String> _translationKeys = {
    'History': 'interest_history',
    'Archaeology': 'interest_archaeology',
    'Culture': 'interest_culture',
    'Local life': 'interest_local_life',
    'Desert': 'interest_desert',
    'Religious': 'interest_religious',
    'Beaches': 'interest_beaches',
    'Food': 'interest_food',
    'Medical': 'interest_medical',
    'Educational': 'interest_educational',
    'Business': 'interest_business',
  };
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TravelInterestsCubit, TravelInterestsState>(
      listener: (context, state) {
        if (state is TravelInterestsLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is TravelInterestsSuccess) {
          Navigator.of(context).pop();
          Navigator.pushReplacementNamed(context, '/touristPreferencesView');
        } else if (state is TravelInterestsError) {
          if (Navigator.of(context).canPop()) Navigator.of(context).pop();
          showSnackBar(context, state.message, isSuccess: false);
        }
      },
      builder: (context, state) {
        final cubit = context.read<TravelInterestsCubit>();

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
                      const StepProgressIndicator(currentStep: 4),
                      SizedBox(height: 30.h),
                      CustomTextSemiBold(
                        fontSize: 16.sp,
                        text: 'travel_interests_title'.tr(),
                      ),
                      SizedBox(height: 16.h),
                      GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 163 / 117,
                          mainAxisSpacing: 8.h,
                          crossAxisSpacing: 16.w,
                        ),
                        itemCount: names.length,
                        itemBuilder: (context, index) {
                          return CategoryCard(
                            categoryName:
                                (_translationKeys[names[index]] ?? names[index])
                                    .tr(),
                            imageUrl: images[index],
                            isSelected: cubit.selectedInterests.contains(
                              names[index],
                            ),
                            onTap: () {
                              setState(() {
                                cubit.toggleInterest(names[index]);
                              });
                            },
                          );
                        },
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
                  cubit.submitTravelInterests();
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
