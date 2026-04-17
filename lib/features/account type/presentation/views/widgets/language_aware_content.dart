import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_list_tile.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_regolar.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_semi_bold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AccountTypeStore {
  static final AccountTypeStore _instance = AccountTypeStore._internal();
  String selectedType = 'tourist';

  factory AccountTypeStore() => _instance;
  AccountTypeStore._internal();
}

class LanguageAwareContent extends StatefulWidget {
  const LanguageAwareContent({super.key});

  @override
  State<LanguageAwareContent> createState() => _LanguageAwareContentState();
}

class _LanguageAwareContentState extends State<LanguageAwareContent> {
  final store = AccountTypeStore();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CustomTextSemiBold(text: 'welcome_title'.tr(), fontSize: 32),
          ),
          SizedBox(height: 8.h),
          Center(
            child: CustomTextRegolar(
              text: 'welcome_subtitle'.tr(),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 56.h),
          CustomListTile(
            text: 'tourist_title'.tr(),
            des: 'tourist_description'.tr(),
            value: 'tourist',
            groupValue: store.selectedType,
            onChanged: (val) {
              setState(() {
                store.selectedType = val!;
              });
            },
          ),
          SizedBox(height: 16.h),
          CustomListTile(
            text: 'tour_guide_title'.tr(),
            des: 'tour_guide_description'.tr(),
            value: 'guide',
            groupValue: store.selectedType,
            onChanged: (val) {
              setState(() {
                store.selectedType = val!;
              });
            },
          ),
        ],
      ),
    );
  }
}
