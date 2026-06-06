import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/guide%20home/data/model/guide_trip_summary_model.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/model/tour_guide_profile.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tour_guide_profile_cubit/tour_guide_profile_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TourGuideProfileView extends StatelessWidget {
  final int? guideId;
  final TourGuideProfile? initialGuide;

  const TourGuideProfileView({super.key, this.guideId, this.initialGuide});

  static const _fallbackSpecialtyKeys = <String>[
    'tour_guide_specialty_history',
    'tour_guide_specialty_culture',
    'tour_guide_specialty_photography',
    'tour_guide_specialty_food',
  ];

  static const _fallbackLanguageKeys = <String>['lang_english', 'lang_spanish'];

  String _resolveLocation(TourGuideProfile? guide) {
    if (guide == null) return 'Cairo, Giza';
    if (guide.city.trim().isNotEmpty) return guide.city;
    return 'Cairo, Giza';
  }

  List<String> _resolveSpecialties(
    BuildContext context,
    TourGuideProfile? guide,
  ) {
    if (guide == null) {
      return _fallbackSpecialtyKeys.map((key) => key.tr()).toList();
    }
    final items =
        guide.specialization
            .map((item) => item.trim())
            .where((item) => item.isNotEmpty)
            .toList();
    return items.isNotEmpty
        ? items
        : _fallbackSpecialtyKeys.map((key) => key.tr()).toList();
  }

  List<String> _resolveLanguages(
    BuildContext context,
    TourGuideProfile? guide,
  ) {
    if (guide == null)
      return _fallbackLanguageKeys.map((key) => key.tr()).toList();
    final items =
        guide.languages
            .map((item) => item.trim()) // languages دلوقتي String مباشرة
            .where((item) => item.isNotEmpty)
            .toList();
    return items.isNotEmpty
        ? items
        : _fallbackLanguageKeys.map((key) => key.tr()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TourGuideProfileCubit, TourGuideProfileState>(
      builder: (context, state) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final pageBg = Colors.white;
        final guide = state.guide ?? initialGuide;

        if (state.status == TourGuideProfileStatus.loading && guide == null) {
          return Scaffold(
            backgroundColor: pageBg,
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state.status == TourGuideProfileStatus.failure && guide == null) {
          return Scaffold(
            backgroundColor: pageBg,
            body: Center(
              child: Text(
                state.errorMessage ?? 'tour_guide_profile_load_failed'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isDark ? Colors.white : AppColor.primaryColor,
                ),
              ),
            ),
          );
        }

        final profileName =
            guide?.name.trim().isNotEmpty == true ? guide!.name : 'Ahmed Sameh';
        final profileLocation = _resolveLocation(guide);
        final profilePhoto =
            guide?.profilePhoto.trim().isNotEmpty == true
                ? guide!.profilePhoto
                : 'assets/images/2th.jpg';
        final specialties = _resolveSpecialties(context, guide);
        final languages = _resolveLanguages(context, guide);
        final memberSinceDate =
            context.locale.languageCode == 'ar' ? 'يناير 2026' : 'Jan 2026';
        final memberSinceLabel = 'tour_guide_profile_member_since'.tr(
          namedArgs: {'date': memberSinceDate},
        );
        final trips = state.trips;

        return Scaffold(
          backgroundColor: pageBg,
          body: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 14.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 205.h,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(24.r),
                          bottomRight: Radius.circular(24.r),
                        ),
                        child: SizedBox(
                          height: 160.h,
                          width: double.infinity,
                          child: Image.asset(
                            'assets/images/sky.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Positioned(
                      //   top: 18.h,
                      //   left: 8.w,
                      //   child: Material(
                      //     color: Colors.transparent,
                      //     child: InkWell(
                      //       onTap: () => Navigator.pop(context),
                      //       borderRadius: BorderRadius.circular(20.r),
                      //       child: Padding(
                      //         padding: EdgeInsets.all(6.w),
                      //         child: Icon(
                      //           Icons.arrow_back_ios_new_rounded,
                      //           size: 24.sp,
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.all(3.w),
                            decoration: BoxDecoration(
                              color:
                                  isDark
                                      ? const Color(0xFF10222E)
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(26.r),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24.r),
                              child: _ProfileAvatar(photoUrl: profilePhoto),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                Center(
                  child: Text(
                    profileName,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : AppColor.secondaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 15.sp,
                        color: const Color(0xFFF39A2C),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        profileLocation,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color:
                              isDark
                                  ? const Color(0xFFA8B7C4)
                                  : const Color(0xFF556C7B),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 3.h),
                Center(
                  child: Text(
                    memberSinceLabel,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color:
                          isDark
                              ? const Color(0xFFA8B7C4)
                              : const Color(0xFF1B7E96),
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          child: _TopStat(
                            value: '120',
                            label: 'tour_guide_profile_trips_led'.tr(),
                          ),
                        ),
                        const _StatsDivider(),
                        Expanded(
                          child: _TopStat(
                            value: '3.6',
                            label: 'tour_guide_profile_rating'.tr(),
                          ),
                        ),
                        const _StatsDivider(),
                        Expanded(
                          child: _TopStat(
                            value:
                                'tour_guide_profile_response_time_short'.tr(),
                            label: 'tour_guide_profile_response'.tr(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Center(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.chat_bubble_outline_rounded,
                      size: 14.sp,
                      color: AppColor.secondaryColor,
                    ),
                    label: Text(
                      'tour_guide_profile_message'.tr(),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColor.secondaryColor,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(180.w, 40.h),
                      side: BorderSide(
                        color: AppColor.secondaryColor.withValues(alpha: .6),
                      ),
                      backgroundColor:
                          isDark
                              ? const Color(0xFF173041)
                              : const Color(0xFFF8FCFE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                _SectionTitle(title: 'tour_guide_profile_about_title'.tr()),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: _RoundedCard(
                    isDark: isDark,
                    child: Text(
                      'tour_guide_profile_about_fallback'.tr(),
                      style: TextStyle(
                        fontSize: 10.sp,
                        height: 1.5,
                        color:
                            isDark
                                ? const Color(0xFFB2C0CC)
                                : const Color(0xFF607382),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                _SectionTitle(title: 'tour_guide_profile_specialties'.tr()),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: [
                      for (final item in specialties) _ProfileChip(label: item),
                    ],
                  ),
                ),
                SizedBox(height: 14.h),
                _SectionTitle(title: 'tour_guide_profile_languages'.tr()),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: [
                      for (final item in languages) _ProfileChip(label: item),
                    ],
                  ),
                ),
                SizedBox(height: 14.h),
                _SectionTitle(
                  title: 'tour_guide_profile_trips_by'.tr(
                    namedArgs: {'name': profileName},
                  ),
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: Column(
                    children: [
                      if (state.tripsStatus == TourGuideTripsStatus.loading &&
                          trips.isEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: 12.h),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      else if (state.tripsStatus ==
                              TourGuideTripsStatus.failure &&
                          trips.isEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Text(
                            state.errorMessage ??
                                'tour_guide_profile_trips_load_failed'.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color:
                                  isDark ? Colors.white : AppColor.primaryColor,
                            ),
                          ),
                        )
                      else if (trips.isEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Text(
                            'tour_guide_profile_no_trips'.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color:
                                  isDark ? Colors.white : AppColor.primaryColor,
                            ),
                          ),
                        )
                      else
                        for (final item in trips)
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: _GuideTripMiniCard(item: item),
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  final String photoUrl;

  const _ProfileAvatar({required this.photoUrl});

  @override
  Widget build(BuildContext context) {
    final hasNetworkImage = photoUrl.startsWith('http');
    if (hasNetworkImage) {
      return Image.network(
        photoUrl,
        width: 92.w,
        height: 92.w,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return _fallbackAvatar();
        },
      );
    }

    return Image.asset(photoUrl, width: 92.w, height: 92.w, fit: BoxFit.cover);
  }

  Widget _fallbackAvatar() {
    return Image.asset(
      'assets/images/2th.jpg',
      width: 92.w,
      height: 92.w,
      fit: BoxFit.cover,
    );
  }
}

class _StatsDivider extends StatelessWidget {
  const _StatsDivider();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 1,
      margin: EdgeInsets.symmetric(vertical: 4.h),
      color: isDark ? const Color(0xFF375061) : const Color(0xFFBFD3DE),
    );
  }
}

class _TopStat extends StatelessWidget {
  final String value;
  final String label;

  const _TopStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w300,
            color: isDark ? Colors.white : const Color(0xFF121A22),
            height: .95,
          ),
        ),
        SizedBox(height: 3.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFE88412),
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w700,
          color: AppColor.secondaryColor,
          height: 0.95,
        ),
      ),
    );
  }
}

class _RoundedCard extends StatelessWidget {
  final Widget child;
  final bool isDark;

  const _RoundedCard({required this.child, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A2833) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark ? const Color(0xFF2F4A5A) : const Color(0xFF7DB3C6),
        ),
      ),
      child: child,
    );
  }
}

class _ProfileChip extends StatelessWidget {
  final String label;

  const _ProfileChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 82.w,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 7.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1B313E) : const Color(0xFFDBE7EC),
        borderRadius: BorderRadius.circular(9.r),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
          color: isDark ? const Color(0xFFB2C0CC) : AppColor.secondaryColor,
        ),
      ),
    );
  }
}

class _GuideTripMiniCard extends StatelessWidget {
  final GuideTripSummaryModel item;

  const _GuideTripMiniCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final coverUrl = item.normalizedCoverImageUrl;
    final priceText = _resolvePrice();
    final dateText = _resolveDateRange();

    return Container(
      padding: EdgeInsets.all(1.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(
          color: isDark ? const Color(0xFF2D4350) : const Color(0xFF79AFC2),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(20.r)),
            child:
                coverUrl != null && coverUrl.isNotEmpty
                    ? Image.network(
                      coverUrl,
                      width: 130.w,
                      height: 108.h,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _fallbackImage(),
                    )
                    : _fallbackImage(),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 8.h, 8.w, 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : AppColor.primaryColor,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        size: 13.sp,
                        color: AppColor.secondaryColor,
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Text(
                          dateText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color:
                                isDark
                                    ? const Color(0xFF9FB0BD)
                                    : const Color(0xFF556C7B),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 7.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '$priceText / person',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColor.secondaryColor,
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      SizedBox(
                        height: 30.h,
                        width: 88.w,
                        child: FilledButton(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColor.secondaryColor,
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                          ),
                          child: Text(
                            'Book Now',
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _resolvePrice() {
    final price = item.pricePerTourist;
    if (price == null) return r'$ 0';
    final value = price % 1 == 0 ? price.toInt().toString() : price.toString();
    return '\$ $value';
  }

  String _resolveDateRange() {
    final start = item.startDate?.trim() ?? '';
    final end = item.endDate?.trim() ?? '';
    if (start.isEmpty && end.isEmpty) return 'Date not set';
    if (start.isNotEmpty && end.isNotEmpty) return '$start - $end';
    return start.isNotEmpty ? start : end;
  }

  Widget _fallbackImage() {
    return Image.asset(
      'assets/images/2th.jpg',
      width: 130.w,
      height: 108.h,
      fit: BoxFit.cover,
    );
  }
}
