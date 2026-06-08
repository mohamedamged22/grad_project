import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/core/utils/pref_helper.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/language_aware_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AccountRoleSlider extends StatefulWidget {
  const AccountRoleSlider({super.key});

  @override
  State<AccountRoleSlider> createState() => _AccountRoleSliderState();
}

class _AccountRoleSliderState extends State<AccountRoleSlider> {
  final AccountTypeStore _store = AccountTypeStore();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? const Color(0xFF19232D) : Colors.white;
    final unselectedColor =
        isDark ? const Color(0xFFCDD6DC) : AppColor.primaryColor;
    final isTourist = _store.selectedType != 'guide';

    return LayoutBuilder(
      builder: (context, constraints) {
        final sliderWidth = constraints.maxWidth * 0.72;
        final innerWidth = sliderWidth - 8.w;
        final thumbWidth = innerWidth / 2;

        return Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: sliderWidth,
            child: Container(
              height: 38.h,
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: AppColor.primaryColor.withOpacity(0.16),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOut,
                    alignment:
                        isTourist
                            ? AlignmentDirectional.centerStart
                            : AlignmentDirectional.centerEnd,
                    child: Container(
                      width: thumbWidth,
                      decoration: BoxDecoration(
                        color: AppColor.secondaryColor,
                        borderRadius: BorderRadius.circular(18.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.secondaryColor.withOpacity(0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            setState(() => _store.selectedType = 'tourist');
                            await PrefHelper.saveUserRole('tourist');
                            debugPrint(
                              'Selected role: ${await PrefHelper.getUserRole()}',
                            );
                          },
                          borderRadius: BorderRadius.circular(20.r),
                          child: Center(
                            child: Text(
                              'tourist_title'.tr(),
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700,
                                color:
                                    isTourist ? Colors.white : unselectedColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            setState(() => _store.selectedType = 'guide');
                            await PrefHelper.saveUserRole('guide');
                            debugPrint(
                              'Selected role: ${await PrefHelper.getUserRole()}',
                            );
                          },
                          borderRadius: BorderRadius.circular(20.r),
                          child: Center(
                            child: Text(
                              'tour_guide_title'.tr(),
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700,
                                color:
                                    !isTourist ? Colors.white : unselectedColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
