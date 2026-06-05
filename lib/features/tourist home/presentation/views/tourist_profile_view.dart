import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tourist_profile_cubit/tourist_profile_cubit.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tourist_profile_cubit/tourist_profile_state.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/views/tourist_personal_information_view.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/views/tourist_saved_trips_view.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/views/tourist_settings_view.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/views/tourist_trip_history_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TouristProfileView extends StatelessWidget {
  const TouristProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenBg = Theme.of(context).scaffoldBackgroundColor;
    final cardBg = Theme.of(context).cardColor;
    final borderColor =
        isDark ? const Color(0xFF2A3744) : const Color(0xFFE9EEF1);
    final primaryText = isDark ? Colors.white : AppColor.primaryColor;

    return BlocConsumer<TouristProfileCubit, TouristProfileState>(
      listener: (context, state) {
        if (state is TouristProfileError && state.message.trim().isNotEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        String name = 'tourist_title'.tr();
        String subtitle = 'traveler'.tr();
        String? profilePhoto;

        if (state is TouristProfileLoaded) {
          name = state.profileData['name'] ?? 'tourist_title'.tr();
          if (name.isEmpty) {
            final firstName = state.profileData['firstName'] ?? '';
            final lastName = state.profileData['lastName'] ?? '';
            name = '$firstName $lastName'.trim();
            if (name.isEmpty) name = 'tourist_title'.tr();
          }
          subtitle = state.profileData['email'] ?? 'traveler'.tr();
          profilePhoto = state.profileData['profilePhoto'];
        } else if (state is TouristProfileLoading) {
          name = 'loading'.tr();
          subtitle = '';
        } else if (context.read<TouristProfileCubit>().currentProfile != null) {
          final profile = context.read<TouristProfileCubit>().currentProfile!;
          name = profile['name'] ?? 'tourist_title'.tr();
          subtitle = profile['email'] ?? 'traveler'.tr();
          profilePhoto = profile['profilePhoto'];
        }

        final hasPhoto = profilePhoto != null && profilePhoto.trim().isNotEmpty;

        return Scaffold(
          backgroundColor: screenBg,
          appBar: AppBar(
            backgroundColor: screenBg,
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text(
              'profile_title'.tr(),
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
                  CircleAvatar(
                    radius: 44.r,
                    backgroundImage: hasPhoto
                        ? NetworkImage(profilePhoto) as ImageProvider
                        : const AssetImage('assets/images/2th.jpg'),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    name,
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
                  if (state is TouristProfileLoading)
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
                    title: 'personal_information'.tr(),
                    borderColor: borderColor,
                    backgroundColor: cardBg,
                    defaultTextColor: primaryText,
                    trailing: Icon(
                      Icons.chevron_right_rounded,
                      color: AppColor.secondaryColor,
                    ),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<TouristProfileCubit>(),
                            child: const TouristPersonalInformationView(),
                          ),
                        ),
                      );
                      if (context.mounted) {
                        context.read<TouristProfileCubit>().fetchProfile();
                      }
                    },
                  ),
                  SizedBox(height: 8.h),
                  _SettingsItem(
                    icon: Icons.bookmark_border_rounded,
                    title: 'saved_trips'.tr(),
                    borderColor: borderColor,
                    backgroundColor: cardBg,
                    defaultTextColor: primaryText,
                    trailing: Icon(
                      Icons.chevron_right_rounded,
                      color: AppColor.secondaryColor,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TouristSavedTripsView(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 8.h),
                  _SettingsItem(
                    icon: Icons.receipt_long_outlined,
                    title: 'trip_history'.tr(),
                    borderColor: borderColor,
                    backgroundColor: cardBg,
                    defaultTextColor: primaryText,
                    trailing: Icon(
                      Icons.chevron_right_rounded,
                      color: AppColor.secondaryColor,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TouristTripHistoryView(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 8.h),
                  _SettingsItem(
                    icon: Icons.settings_outlined,
                    title: 'settings'.tr(),
                    borderColor: borderColor,
                    backgroundColor: cardBg,
                    defaultTextColor: primaryText,
                    trailing: Icon(
                      Icons.chevron_right_rounded,
                      color: AppColor.secondaryColor,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TouristSettingsView(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 8.h),
                  _SettingsItem(
                    icon: Icons.shield_outlined,
                    title: 'privacy_policy'.tr(),
                    borderColor: borderColor,
                    backgroundColor: cardBg,
                    defaultTextColor: primaryText,
                    onTap: () {},
                  ),
                  SizedBox(height: 8.h),
                  _SettingsItem(
                    icon: Icons.logout,
                    title: 'sign_out'.tr(),
                    borderColor: borderColor,
                    backgroundColor: cardBg,
                    defaultTextColor: primaryText,
                    iconColor: AppColor.secondaryColor,
                    textColor: const Color(0xFFE54343),
                    onTap: () async {
                      await context.read<TouristProfileCubit>().signOut();
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
