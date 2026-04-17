import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/language_aware_content.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageAwareButton extends StatelessWidget {
  const LanguageAwareButton({super.key});

  @override
  Widget build(BuildContext context) {
    final store = AccountTypeStore(); // 🔥 اقرأ الـ store

    return CustomButton(
      text: 'continue'.tr(),
      onTap: () {
        // 🎯 اطبع الاختيار للتأكد
        debugPrint('📌 Selected account type: ${store.selectedType}');

        // روح على صفحة الـ signup
        Navigator.pushReplacementNamed(context, '/signUpView');
      },
    );
  }
}
