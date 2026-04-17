import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_semi_bold.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/custom_dropdown_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageEntry {
  String? language;
  String? level;

  LanguageEntry({this.language, this.level});
}

class LanguageSelector extends StatefulWidget {
  final List<LanguageEntry> languages;
  final ValueChanged<List<LanguageEntry>> onLanguagesChanged;

  const LanguageSelector({
    super.key,
    required this.languages,
    required this.onLanguagesChanged,
  });

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  final List<String> availableLanguages = [
    'English',
    'Arabic',
    'French',
    'German',
    'Spanish',
    'Italian',
    'Chinese',
    'Japanese',
  ];

  final List<String> languageLevels = [
    'Beginner',
    'Intermediate',
    'Advanced',
    'Native',
  ];

  static const Map<String, String> _langTranslationKeys = {
    'English': 'guide_lang_english',
    'Arabic': 'guide_lang_arabic',
    'French': 'guide_lang_french',
    'German': 'guide_lang_german',
    'Spanish': 'guide_lang_spanish',
    'Italian': 'guide_lang_italian',
    'Chinese': 'guide_lang_chinese',
    'Japanese': 'guide_lang_japanese',
  };

  static const Map<String, String> _levelTranslationKeys = {
    'Beginner': 'guide_level_beginner',
    'Intermediate': 'guide_level_intermediate',
    'Advanced': 'guide_level_advanced',
    'Native': 'guide_level_native',
  };

  // ✅ أضف الـ method دي
  List<String> _getAvailableLanguages(int currentIndex) {
    final selectedLanguages =
        widget.languages
            .asMap()
            .entries
            .where((e) => e.key != currentIndex && e.value.language != null)
            .map((e) => e.value.language!)
            .toSet();

    return availableLanguages
        .where((lang) => !selectedLanguages.contains(lang))
        .toList();
  }

  void _addLanguage() {
    List<LanguageEntry> updated = List.from(widget.languages);
    updated.add(LanguageEntry());
    widget.onLanguagesChanged(updated);
  }

  void _removeLanguage(int index) {
    List<LanguageEntry> updated = List.from(widget.languages);
    updated.removeAt(index);
    widget.onLanguagesChanged(updated);
  }

  void _updateLanguage(int index, String? language, String? level) {
    List<LanguageEntry> updated = List.from(widget.languages);
    updated[index] = LanguageEntry(
      language: language ?? updated[index].language,
      level: level ?? updated[index].level,
    );
    widget.onLanguagesChanged(updated);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 46.w),
          child: Row(
            children: [
              Expanded(
                child: CustomTextSemiBold(
                  fontSize: 14.sp,
                  text: 'guide_lang_language'.tr(),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CustomTextSemiBold(
                  fontSize: 14.sp,
                  text: 'guide_lang_level'.tr(),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),

        ...List.generate(widget.languages.length, (index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CustomDropdownField(
                    hint: 'guide_lang_select_language'.tr(),
                    value: widget.languages[index].language,
                    items: _getAvailableLanguages(index), // ✅ التغيير هنا
                    displayMapper:
                        (item) => (_langTranslationKeys[item] ?? item).tr(),
                    onChanged: (value) => _updateLanguage(index, value, null),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  flex: 1,
                  child: CustomDropdownField(
                    hint: 'guide_lang_select_level'.tr(),
                    value: widget.languages[index].level,
                    items: languageLevels,
                    displayMapper:
                        (item) => (_levelTranslationKeys[item] ?? item).tr(),
                    onChanged: (value) => _updateLanguage(index, null, value),
                  ),
                ),
                SizedBox(
                  width: 46.w,
                  child:
                      index > 0
                          ? IconButton(
                            icon: Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                              size: 28.w,
                            ),
                            onPressed: () => _removeLanguage(index),
                            padding: EdgeInsets.zero,
                          )
                          : const SizedBox(),
                ),
              ],
            ),
          );
        }),

        SizedBox(height: 4.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextSemiBold(
              fontSize: 16.sp,
              text: 'guide_lang_add_another'.tr(),
            ),
            GestureDetector(
              onTap: _addLanguage,
              child: Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.secondaryColor, width: 2),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Icon(
                  Icons.add,
                  size: 18.w,
                  color: AppColor.secondaryColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
