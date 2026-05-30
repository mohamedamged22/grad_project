import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class GuideHomeTopBar extends StatelessWidget {
  final String location;
  final String profilePhotoUrl;

  const GuideHomeTopBar({
    super.key,
    required this.location,
    required this.profilePhotoUrl,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasPhoto = profilePhotoUrl.trim().isNotEmpty;
    final locationLabel = location.trim().isEmpty ? 'Egypt' : location.trim();

    return Row(
      children: [
        Icon(
          Icons.location_on_rounded,
          size: 20.sp,
          color: AppColor.secondaryColor,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
          decoration: BoxDecoration(
            color: const Color(0xFFF89422),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            locationLabel,
            style: TextStyle(
              color: isDark ? const Color(0xFFF2F7FA) : Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 10.sp,
            ),
          ),
        ),
        const Spacer(),
        IconButton(
          visualDensity: VisualDensity.compact,
          onPressed: () {},
          icon: Icon(
            Icons.notifications_none_rounded,
            size: 24.sp,
            color: AppColor.secondaryColor,
          ),
        ),
        InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            '/profilePersonalInformationView',
          ),
          borderRadius: BorderRadius.circular(24.r),
          child: CircleAvatar(
            backgroundColor: AppColor.secondaryColor,
            radius: 22.r,
            backgroundImage:
                hasPhoto
                    ? NetworkImage(profilePhotoUrl) as ImageProvider
                    : const AssetImage('assets/images/2th.jpg'),
          ),
        ),
      ],
    );
  }
}
