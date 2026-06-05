import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageDropdown extends StatelessWidget {
  final void Function(Locale)? onChanged;
  const LanguageDropdown({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.secondaryColor, width: 1.w),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Locale>(
          value: context.locale,
          icon:  Icon(Icons.language ,color: AppColor.secondaryColor,),
          items: [
            DropdownMenuItem(
              value: const Locale('en'),
              child: Text(
                'lang_english'.tr(),
                style: TextStyle(color: AppColor.secondaryColor),
              ),
            ),
            DropdownMenuItem(
              value: const Locale('ar'),
              child: Text(
                'lang_arabic'.tr(),
                style: TextStyle(color: AppColor.secondaryColor),
              ),
            ),
          ],
          onChanged: (locale) {
            if (locale != null) {
              context.setLocale(locale);
              if (onChanged != null) onChanged!(locale);
            }
          },
        ),
      ),
    );
  }
}
