import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/manger/guide_profile_cubit/guide_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenBg = Theme.of(context).scaffoldBackgroundColor;
    final cardBg = Theme.of(context).cardColor;
    final borderColor =
        isDark ? const Color(0xFF2A3744) : const Color(0xFFE9EEF1);
    final primaryText = isDark ? Colors.white : AppColor.primaryColor;

    return BlocConsumer<GuideProfileCubit, GuideProfileState>(
      listener: (context, state) {
        if (state.status == GuideProfileStatus.failure &&
            (state.errorMessage?.isNotEmpty ?? false)) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      builder: (context, state) {
        final hasPhoto = state.profilePhotoUrl.trim().isNotEmpty;
        final guideName =
            state.guideName.trim().isEmpty ? 'Guide' : state.guideName.trim();
        final subtitle =
            state.guideLocation.trim().isEmpty
                ? 'Licensed Guide'
                : state.guideLocation.trim();

        return Scaffold(
          backgroundColor: screenBg,
          appBar: AppBar(
            backgroundColor: screenBg,
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text(
              'Profile',
              style: TextStyle(
                color: primaryText,
                fontWeight: FontWeight.w700,
                fontSize: 18.sp,
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 20.h),
              child: Column(
                children: [
                  SizedBox(height: 4.h),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        radius: 44.r,
                        backgroundImage:
                            hasPhoto
                                ? NetworkImage(state.profilePhotoUrl)
                                    as ImageProvider
                                : const AssetImage('assets/images/2th.jpg'),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    guideName,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: primaryText,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColor.secondaryColor,
                    ),
                  ),
                  if (state.status == GuideProfileStatus.loading)
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColor.secondaryColor,
                        ),
                      ),
                    ),
                  SizedBox(height: 14.h),

                  _SettingsItem(
                    icon: Icons.person_outline,
                    title: 'Personal information',
                    borderColor: borderColor,
                    backgroundColor: cardBg,
                    defaultTextColor: primaryText,
                    trailing: Icon(
                      Icons.chevron_right_rounded,
                      color: AppColor.secondaryColor,
                    ),
                    onTap: () async {
                      final updated = await Navigator.pushNamed(
                        context,
                        '/profilePersonalInformationView',
                        arguments: state.guideName,
                      );

                      if (updated == true && context.mounted) {
                        context
                            .read<GuideProfileCubit>()
                            .fetchProfileDashboard();
                      }
                    },
                  ),
                  SizedBox(height: 8.h),
                  _SettingsItem(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    borderColor: borderColor,
                    backgroundColor: cardBg,
                    defaultTextColor: primaryText,
                    onTap: () {},
                  ),
                  SizedBox(height: 8.h),
                  _SettingsItem(
                    icon: Icons.language,
                    title: 'Language',
                    borderColor: borderColor,
                    backgroundColor: cardBg,
                    defaultTextColor: primaryText,
                    onTap: () {},
                  ),
                  SizedBox(height: 8.h),

                  _SettingsItem(
                    icon: Icons.notifications_none_rounded,
                    title: 'Notification',
                    borderColor: borderColor,
                    backgroundColor: cardBg,
                    defaultTextColor: primaryText,
                    trailing: _TogglePill(
                      value: state.notificationEnabled,
                      onChanged:
                          (value) => context
                              .read<GuideProfileCubit>()
                              .setNotificationEnabled(value),
                    ),
                    onTap:
                        () =>
                            context
                                .read<GuideProfileCubit>()
                                .toggleNotification(),
                  ),
                  SizedBox(height: 8.h),
                  _SettingsItem(
                    icon: Icons.dark_mode_outlined,
                    title: 'Dark Mode',
                    borderColor: borderColor,
                    backgroundColor: cardBg,
                    defaultTextColor: primaryText,
                    trailing: _TogglePill(
                      value: state.darkModeEnabled,
                      onChanged:
                          (value) => context
                              .read<GuideProfileCubit>()
                              .setDarkModeEnabled(value),
                    ),
                    onTap:
                        () =>
                            context.read<GuideProfileCubit>().toggleDarkMode(),
                  ),
                  SizedBox(height: 8.h),
                  _SettingsItem(
                    icon: Icons.lock_outline_rounded,
                    title: 'Face ID & Finger print',
                    borderColor: borderColor,
                    backgroundColor: cardBg,
                    defaultTextColor: primaryText,
                    trailing: _TogglePill(
                      value: state.faceIdEnabled,
                      onChanged:
                          (value) => context
                              .read<GuideProfileCubit>()
                              .setFaceIdEnabled(value),
                    ),
                    onTap:
                        () => context.read<GuideProfileCubit>().toggleFaceId(),
                  ),
                  SizedBox(height: 8.h),

                  _SettingsItem(
                    icon: Icons.lock_open_rounded,
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
                    icon: Icons.delete_outline_rounded,
                    title: 'Delete account',
                    borderColor: borderColor,
                    backgroundColor: cardBg,
                    defaultTextColor: primaryText,
                    onTap: () async {
                      final shouldDelete = await _showDeleteAccountDialog(
                        context,
                      );
                      if (!shouldDelete || !context.mounted) {
                        return;
                      }

                      try {
                        final message =
                            await context
                                .read<GuideProfileCubit>()
                                .deleteAccount();
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(message)));
                      } catch (e) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              e.toString().replaceFirst('Exception: ', ''),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 8.h),
                  _SettingsItem(
                    icon: Icons.shield_outlined,
                    title: 'Privacy & Policy',
                    borderColor: borderColor,
                    backgroundColor: cardBg,
                    defaultTextColor: primaryText,
                    onTap: () {},
                  ),
                  SizedBox(height: 8.h),

                  _SettingsItem(
                    icon: Icons.logout,
                    title: 'Sign out',
                    borderColor: borderColor,
                    backgroundColor: cardBg,
                    defaultTextColor: primaryText,
                    iconColor: AppColor.secondaryColor,
                    textColor: const Color(0xFFE54343),
                    onTap: () async {
                      await context.read<GuideProfileCubit>().signOut();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> _showDeleteAccountDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 34.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 14.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 74.w,
                  height: 74.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF6F6F6),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x33FF4D4D),
                        blurRadius: 24,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    color: const Color(0xFFF23A3A),
                    size: 26.sp,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Are you sure ?',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColor.primaryColor,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  'You want to delete your account.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    color: const Color(0xFF6E7C89),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 14.h),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context, false),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color(0xFFB8C4CE),
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22.r),
                          ),
                        ),
                        child: Text(
                          'Keep it',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFF73808D),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context, true),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: const Color(0xFFF23A3A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22.r),
                          ),
                        ),
                        child: Text(
                          'Delete Account',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    return result ?? false;
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
    this.trailing,
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
              Icon(icon, color: iconColor ?? AppColor.secondaryColor, size: 18),
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
