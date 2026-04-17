import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_trip_preview_card.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/presentation/manager/guide_last_created_trip_cubit/guide_last_created_trip_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuideCreateTripSuccessView extends StatelessWidget {
  const GuideCreateTripSuccessView({super.key});

  static const String _uploadsBaseHost =
      'https://josphine-magnipotent-vectorially.ngrok-free.dev';

  String _formatDateRange(String? startDate, String? endDate) {
    String formatOne(String? value) {
      if (value == null || value.trim().isEmpty) return '';
      final parsed = DateTime.tryParse(value);
      if (parsed == null) return value;
      final month = <int, String>{
        1: 'Jan',
        2: 'Feb',
        3: 'Mar',
        4: 'Apr',
        5: 'May',
        6: 'Jun',
        7: 'Jul',
        8: 'Aug',
        9: 'Sep',
        10: 'Oct',
        11: 'Nov',
        12: 'Dec',
      }[parsed.month];
      return '${parsed.day} ${month ?? parsed.month}, ${parsed.year}';
    }

    final from = formatOne(startDate);
    final to = formatOne(endDate);

    if (from.isEmpty && to.isEmpty) return 'Not scheduled yet';
    if (to.isEmpty) return from;
    if (from.isEmpty) return to;
    return '$from - $to';
  }

  String _formatPrice(double? value) {
    if (value == null || value <= 0) return '\$0';
    final normalized =
        value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(2);
    return '\$$normalized';
  }

  String? _resolveImageUrl(String? rawImageUrl) {
    if (rawImageUrl == null || rawImageUrl.trim().isEmpty) return null;

    final normalizedPath = rawImageUrl.trim().replaceAll('\\', '/');

    String encodePathSegments(String path) {
      final segments = path
          .split('/')
          .where((segment) => segment.trim().isNotEmpty)
          .map((segment) => Uri.encodeComponent(Uri.decodeComponent(segment)))
          .toList();
      return '/${segments.join('/')}';
    }

    if (normalizedPath.startsWith('http://') ||
        normalizedPath.startsWith('https://')) {
      final uri = Uri.tryParse(normalizedPath);
      if (uri == null) return normalizedPath;
      final secureScheme = uri.scheme.toLowerCase() == 'http' ? 'https' : uri.scheme;
      return uri.replace(scheme: secureScheme).toString();
    }

    final cleanPath =
        normalizedPath.startsWith('/') ? normalizedPath : '/$normalizedPath';
    final encodedPath = encodePathSegments(cleanPath);
    return '$_uploadsBaseHost$encodedPath';
  }

  @override
  Widget build(BuildContext context) {
    final uploadedImagePathArg = ModalRoute.of(context)?.settings.arguments;
    final uploadedImagePath =
        uploadedImagePathArg is String && uploadedImagePathArg.trim().isNotEmpty
        ? uploadedImagePathArg
        : null;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pageBg = Theme.of(context).scaffoldBackgroundColor;
    final titleColor = isDark ? Colors.white : AppColor.primaryColor;
    final subtitleColor = AppColor.secondaryColor;

    return Scaffold(
      backgroundColor: pageBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(14.w, 6.h, 14.w, 20.h),
          child: Column(
            children: [
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: IconButton(
                  onPressed: () => Navigator.maybePop(context),
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 17.sp,
                    color: titleColor,
                  ),
                  splashRadius: 20,
                ),
              ),
              SizedBox(height: 2.h),
              Icon(
                Icons.verified_rounded,
                color: AppColor.secondaryColor,
                size: 40.sp,
              ),
              SizedBox(height: 14.h),
              Text(
                'guide_trip_created_successfully'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24.sp,
                  height: 1.0,
                  fontWeight: FontWeight.w600,
                  color: AppColor.primaryColor,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'guide_trip_live_open_booking'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.sp,
                  height: 1.0,
                  fontWeight: FontWeight.w400,
                  color: subtitleColor,
                ),
              ),
              SizedBox(height: 22.h),
              BlocBuilder<GuideLastCreatedTripCubit, GuideLastCreatedTripState>(
                builder: (context, state) {
                  if (state.status == GuideLastCreatedTripStatus.loading ||
                      state.status == GuideLastCreatedTripStatus.initial) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (state.status == GuideLastCreatedTripStatus.failure ||
                      state.trip == null) {
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(14.r),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColor.grey),
                      ),
                      child: Text(
                        state.message ?? 'Failed to load trip data',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: titleColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }

                  final trip = state.trip!;
                  final title =
                      (trip.title == null || trip.title!.trim().isEmpty)
                          ? 'Untitled trip'
                          : trip.title!;
                  final city =
                      (trip.city == null || trip.city!.trim().isEmpty)
                          ? 'Unknown city'
                          : trip.city!;
                  final firstCategory = trip.categories.isNotEmpty
                      ? trip.categories.first
                      : ((trip.status == null || trip.status!.trim().isEmpty)
                          ? 'NEW'
                          : trip.status!);
                  // Prefer last-created image because it reflects the final stored cover path.
                  final preferredImage = trip.imageUrl ?? uploadedImagePath;
                  final resolvedImageUrl = _resolveImageUrl(preferredImage);
                  debugPrint('🖼️ Success card image url: $resolvedImageUrl');

                  return GuideTripPreviewCard(
                    imagePath: 'assets/images/2th.jpg',
                    imageUrl: resolvedImageUrl,
                    title: title,
                    location: city,
                    spots: 'Status: ${trip.status ?? 'NEW'}',
                    dateRange: _formatDateRange(trip.startDate, trip.endDate),
                    price: _formatPrice(trip.price),
                    priceSuffix: 'guide_price_per_person_suffix'.tr(),
                    tag: firstCategory,
                  );
                },
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: 182.w,
                height: 40.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/guideHomeRootView',
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.secondaryColor,
                    foregroundColor: AppColor.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.r),
                    ),
                  ),
                  child: Text(
                    'guide_view_my_trips'.tr(),
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                width: 182.w,
                height: 36.h,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/guideCreateTripView',
                      (route) => false,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColor.secondaryColor,
                    side: BorderSide(color: AppColor.secondaryColor, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.r),
                    ),
                  ),
                  child: Text(
                    'guide_create_another_trip'.tr(),
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              SizedBox(
                width: 182.w,
                height: 36.h,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/guideHomeRootView',
                      (route) => false,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColor.secondaryColor,
                    side: BorderSide(color: AppColor.secondaryColor, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.r),
                    ),
                  ),
                  child: Text(
                    'guide_back_to_home'.tr(),
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
