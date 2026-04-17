import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/language_aware_button.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/language_aware_content.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/language_dropdown.dart';

class AccountTypeView extends StatelessWidget {
  const AccountTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 50.h),

            Align(
              alignment: Alignment.topRight,
              child: LanguageDropdown(
                onChanged: (Locale locale) {
                  context.setLocale(locale);
                },
              ),
            ),

            SizedBox(height: 50.h),

            Expanded(child: LanguageAwareContent()),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SizedBox(
          height: 120.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [LanguageAwareButton(), SizedBox(height: 48.h)],
          ),
        ),
      ),
    );
  }
}
