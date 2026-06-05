import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class TouristDiscoverView extends StatefulWidget {
  const TouristDiscoverView({super.key});

  @override
  State<TouristDiscoverView> createState() => _TouristDiscoverViewState();
}

class _TouristDiscoverViewState extends State<TouristDiscoverView> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picked = await _picker.pickImage(source: source, imageQuality: 90);
      if (!mounted) {
        return;
      }

      if (picked == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('tourist_discover_no_image_selected'.tr())),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'tourist_discover_selected'.tr(namedArgs: {
              'name': picked.name,
            }),
          ),
        ),
      );
    } on PlatformException catch (e) {
      if (!mounted) {
        return;
      }
      final channelError = (e.code == 'channel-error');
      final message =
          channelError
              ? 'tourist_discover_picker_not_initialized'.tr()
              : 'tourist_discover_open_failed'.tr(namedArgs: {
                'source':
                    source == ImageSource.camera
                        ? 'tourist_discover_source_camera'.tr()
                        : 'tourist_discover_source_gallery'.tr(),
              });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'tourist_discover_title'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : AppColor.primaryColor,
              ),
            ),
            SizedBox(height: 22.h),
            _DiscoverActionCard(
              icon: Icons.camera_alt_outlined,
              text: 'tourist_discover_action_camera'.tr(),
              onTap: () => _pickImage(ImageSource.camera),
            ),
            SizedBox(height: 14.h),
            _DiscoverActionCard(
              icon: Icons.photo_library_outlined,
              text: 'tourist_discover_action_gallery'.tr(),
              onTap: () => _pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }
}

class _DiscoverActionCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _DiscoverActionCard({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColor.secondaryColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white.withValues(alpha: .95), size: 19.sp),
            SizedBox(height: 7.h),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 9.sp,
                fontWeight: FontWeight.w500,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
