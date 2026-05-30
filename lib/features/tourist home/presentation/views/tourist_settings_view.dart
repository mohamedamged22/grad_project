import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/services/theme_service.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class TouristSettingsView extends StatefulWidget {
  const TouristSettingsView({super.key});

  @override
  State<TouristSettingsView> createState() => _TouristSettingsViewState();
}

class _TouristSettingsViewState extends State<TouristSettingsView> {
  bool _notificationsEnabled = true;

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
          'Settings',
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
                title: 'Notification',
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
                title: 'Change password',
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
                title: 'Language',
                borderColor: borderColor,
                backgroundColor: cardBg,
                defaultTextColor: primaryText,
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: AppColor.secondaryColor,
                ),
                onTap: () {},
              ),
              SizedBox(height: 8.h),
              _SettingsItem(
                icon: Icons.dark_mode_outlined,
                title: 'Dark Mode',
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
                title: 'Delete account',
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
