import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/services/service_locator.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/model/tour_guide_profile.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tourist_guides_cubit/tourist_guides_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TouristGuidesView extends StatelessWidget {
  const TouristGuidesView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pageBg = isDark ? const Color(0xFF0F1A24) : Colors.white;
    final titleColor = isDark ? Colors.white : AppColor.primaryColor;
    final subtitleColor =
        isDark ? const Color(0xFF9FB0BD) : const Color(0xFF6B7B88);

    return BlocProvider(
      create: (context) => sl<TouristGuidesCubit>()..fetchGuides(),
      child: Scaffold(
        backgroundColor: pageBg,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text(
                  'tourist_guides_title'.tr(),
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: titleColor,
                  ),
                ),
                SizedBox(height: 6.h),
                // Text(
                //   'Expert curators for your Egyptian journey',
                //   style: TextStyle(
                //     fontSize: 16.sp,
                //     color: subtitleColor,
                //   ),
                // ),
                SizedBox(height: 16.h),
                Expanded(
                  child: BlocBuilder<TouristGuidesCubit, TouristGuidesState>(
                    builder: (context, state) {
                      if (state.status == TouristGuidesStatus.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state.status == TouristGuidesStatus.failure) {
                        return Center(
                          child: Text(
                            state.errorMessage ?? 'tourist_guides_failed'.tr(),
                            style: TextStyle(
                              color:
                                  isDark ? Colors.white : AppColor.primaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }

                      final guides = state.guides;
                      if (guides.isEmpty) {
                        return Center(
                          child: Text(
                            'tourist_guides_empty'.tr(),
                            style: TextStyle(
                              color:
                                  isDark ? Colors.white : AppColor.primaryColor,
                            ),
                          ),
                        );
                      }

                      return ListView.separated(
                        padding: EdgeInsets.only(bottom: 12.h),
                        itemCount: guides.length,
                        separatorBuilder: (_, __) => SizedBox(height: 14.h),
                        itemBuilder: (context, index) {
                          return _GuideCard(guide: guides[index]);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GuideCard extends StatelessWidget {
  final TourGuideProfile guide;

  const _GuideCard({required this.guide});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF17232C) : Colors.white;
    final textColor = isDark ? Colors.white : AppColor.primaryColor;
    final mutedColor =
        isDark ? const Color(0xFF9FB0BD) : const Color(0xFF6B7B88);
    final location = _resolveLocation();
    final languages = _resolveLanguages();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: const Color(0x14000000),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _GuideAvatar(photoUrl: guide.profilePhoto),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      guide.name.isNotEmpty
                          ? guide.name
                          : 'tourist_guides_unknown'.tr(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      guide.guideType.isNotEmpty
                          ? guide.guideType
                          : 'tourist_guides_role'.tr(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.secondaryColor,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    if (location.isNotEmpty)
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 14.sp,
                            color: const Color(0xFFF39A2C),
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              location,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: mutedColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          _GuideInfoRow(
            label: 'tourist_guides_experience'.tr(),
            value: '${guide.yearsOfExperience} ${"tourist_guides_years".tr()}',
          ),
          // if (guide.coveredArea.trim().isNotEmpty)
          //   _GuideInfoRow(
          //     label: 'tourist_guides_covers'.tr(),
          //     value: guide.coveredArea,
          //   ),
          if (languages.isNotEmpty)
            _GuideInfoRow(
              label: 'tourist_guides_languages'.tr(),
              value: languages,
            ),
          if (guide.specialization.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 6.h),
              child: Wrap(
                spacing: 6.w,
                runSpacing: 6.h,
                children:
                    guide.specialization
                        .map(
                          (item) => Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isDark
                                      ? const Color(0xFF1F2D38)
                                      : const Color(0xFFF2F4F6),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              item,
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: mutedColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
          SizedBox(height: 14.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).pushNamed('/tourGuideProfileView', arguments: guide);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.secondaryColor,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'tourist_guides_view_profile'.tr(),
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _resolveLocation() {
    return guide.city.trim();
  }

  String _resolveLanguages() {
    if (guide.languages.isEmpty) return '';
    return guide.languages.join(' • '); // languages دلوقتي List<String>
  }
}

class _GuideInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _GuideInfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mutedColor =
        isDark ? const Color(0xFF9FB0BD) : const Color(0xFF6B7B88);
    final textColor = isDark ? Colors.white : AppColor.primaryColor;

    return Padding(
      padding: EdgeInsets.only(top: 6.h),
      child: Row(
        children: [
          SizedBox(
            width: 88.w,
            child: Text(
              label,
              style: TextStyle(fontSize: 12.sp, color: mutedColor),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GuideAvatar extends StatelessWidget {
  final String photoUrl;

  const _GuideAvatar({required this.photoUrl});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fallbackColor =
        isDark ? const Color(0xFF1F2D38) : const Color(0xFFF2F4F6);
    final hasPhoto = photoUrl.trim().isNotEmpty;

    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: fallbackColor,
        borderRadius: BorderRadius.circular(28.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child:
            hasPhoto
                ? Image.network(
                  photoUrl,
                  width: 68.w,
                  height: 68.w,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return _fallbackAvatar();
                  },
                )
                : _fallbackAvatar(),
      ),
    );
  }

  Widget _fallbackAvatar() {
    return Image.asset(
      'assets/images/2th.jpg',
      width: 68.w,
      height: 68.w,
      fit: BoxFit.cover,
    );
  }
}
