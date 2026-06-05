import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/services/theme_service.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TouristSettingsView extends StatefulWidget {
  const TouristSettingsView({super.key});

  @override
  State<TouristSettingsView> createState() => _TouristSettingsViewState();
}

class _TouristSettingsViewState extends State<TouristSettingsView> {
  bool _notificationsEnabled = true;

  Future<void> _showLanguageSheet() async {
    if (!mounted) return;
    final currentCode = context.locale.languageCode;

    await showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 18.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCFD8DE),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                SizedBox(height: 12.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'language'.tr(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('lang_english'.tr()),
                  trailing:
                      currentCode == 'en'
                          ? const Icon(Icons.check_rounded)
                          : null,
                  onTap: () async {
                    Navigator.pop(context);
                    await context.setLocale(const Locale('en'));
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('lang_arabic'.tr()),
                  trailing:
                      currentCode == 'ar'
                          ? const Icon(Icons.check_rounded)
                          : null,
                  onTap: () async {
                    Navigator.pop(context);
                    await context.setLocale(const Locale('ar'));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenBg = Theme.of(context).scaffoldBackgroundColor;
    final cardBg = Theme.of(context).cardColor;
    final primaryText = isDark ? Colors.white : AppColor.primaryColor;
    final borderColor =
        isDark ? const Color(0xFF2A3744) : const Color(0xFFE9EEF1);

    return Scaffold(
      backgroundColor: screenBg,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: screenBg,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18.sp,
            color: AppColor.secondaryColor,
          ),
        ),
        title: Text(
          'settings'.tr(),
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: primaryText,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(12.w, 6.h, 12.w, 20.h),
          child: Column(
            children: [
              _SettingsItem(
                icon: Icons.notifications_none_rounded,
                title: 'notification'.tr(),
                borderColor: borderColor,
                backgroundColor: cardBg,
                defaultTextColor: primaryText,
                trailing: _TogglePill(
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() => _notificationsEnabled = value);
                  },
                ),
                onTap: () {
                  setState(() => _notificationsEnabled = !_notificationsEnabled);
                },
              ),
              SizedBox(height: 8.h),
              _SettingsItem(
                icon: Icons.lock_outline_rounded,
                title: 'change_password'.tr(),
                borderColor: borderColor,
                backgroundColor: cardBg,
                defaultTextColor: primaryText,
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: AppColor.secondaryColor,
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/forgetPasswordView',
                    arguments: {'fromProfileFlow': true},
                  );
                },
              ),
              SizedBox(height: 8.h),
              _SettingsItem(
                icon: Icons.language_rounded,
                title: 'language'.tr(),
                borderColor: borderColor,
                backgroundColor: cardBg,
                defaultTextColor: primaryText,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.locale.languageCode == 'ar'
                          ? 'lang_arabic'.tr()
                          : 'lang_english'.tr(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.secondaryColor,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: AppColor.secondaryColor,
                    ),
                  ],
                ),
                onTap: _showLanguageSheet,
              ),
              SizedBox(height: 8.h),
              _SettingsItem(
                icon: Icons.dark_mode_outlined,
                title: 'dark_mode'.tr(),
                borderColor: borderColor,
                backgroundColor: cardBg,
                defaultTextColor: primaryText,
                trailing: _TogglePill(
                  value: ThemeService.isDark,
                  onChanged: (value) {
                    ThemeService.setDarkMode(value);
                    setState(() {});
                  },
                ),
                onTap: () {
                  ThemeService.setDarkMode(!ThemeService.isDark);
                  setState(() {});
                },
              ),
              SizedBox(height: 8.h),
              _SettingsItem(
                icon: Icons.delete_outline_rounded,
                title: 'delete_account'.tr(),
                borderColor: borderColor,
                backgroundColor: cardBg,
                defaultTextColor: primaryText,
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: AppColor.secondaryColor,
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final Color? iconColor;
  final Color? textColor;
  final Color defaultTextColor;
  final Color borderColor;
  final Color backgroundColor;
  final VoidCallback onTap;

  const _SettingsItem({
    required this.icon,
    required this.title,
    required this.onTap,
    required this.trailing,
    this.iconColor,
    this.textColor,
    required this.defaultTextColor,
    required this.borderColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(10.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          height: 44.h,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: borderColor, width: 1),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: iconColor ?? AppColor.secondaryColor,
                size: 18,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.5.sp,
                    color: textColor ?? defaultTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}

class _TogglePill extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _TogglePill({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 46.w,
        height: 24.h,
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: value ? AppColor.secondaryColor : const Color(0xFFD0D7DC),
        ),
        child: Align(
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 18.w,
            height: 18.w,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
