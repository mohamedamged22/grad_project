import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/manger/guide_profile_cubit/guide_profile_cubit.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_home_search_field.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_home_top_bar.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_metric_card.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_new_request_card.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_promo_trip_card.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_section_title.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_upcoming_trip_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuideHomeView extends StatelessWidget {
  const GuideHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final pageBg = Theme.of(context).scaffoldBackgroundColor;
    final primaryText =
        Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : AppColor.primaryColor;
    final profileState = context.watch<GuideProfileCubit>().state;

    return SafeArea(
      child: ColoredBox(
        color: pageBg,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GuideHomeTopBar(
                location: profileState.guideLocation,
                profilePhotoUrl: profileState.profilePhotoUrl,
              ),
              SizedBox(height: 4.h),
              Text(
                'guide_home_welcome'.tr(),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.secondaryColor,
                ),
              ),
              SizedBox(height: 8.h),
              GuideHomeSearchField(hintText: 'guide_search_trip'.tr()),
              SizedBox(height: 16.h),
              GuidePromoTripCard(
                onCreateTripTap: () {
                  Navigator.pushNamed(context, '/guideCreateTripView');
                },
              ),
              SizedBox(height: 16.h),
              GuideSectionTitle(title: 'guide_upcoming_trips'.tr()),
              SizedBox(height: 8.h),
              SizedBox(
                height: 240.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _trips.length,
                  separatorBuilder: (_, __) => SizedBox(width: 12.w),
                  itemBuilder: (_, index) {
                    return GuideUpcomingTripCard(data: _trips[index]);
                  },
                ),
              ),
              SizedBox(height: 12.h),
              GuideSectionTitle(title: 'guide_new_requests'.tr()),
              SizedBox(height: 8.h),
              const GuideNewRequestCard(),
              SizedBox(height: 14.h),
              Text(
                'guide_this_month'.tr(),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: primaryText,
                ),
              ),
              SizedBox(height: 14.h),
              Row(
                children: [
                  Expanded(
                    child: GuideMetricCard(
                      title: 'guide_completed_trips'.tr(),
                      value: 'guide_12_trips'.tr(),
                      icon: Icons.trending_up_rounded,
                      valueColor: Color(0xFFF79A3B),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: GuideMetricCard(
                      title: 'guide_rating'.tr(),
                      value: '4.8/5',
                      icon: Icons.star_border_rounded,
                      valueColor: Color(0xFFF79A3B),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: GuideMetricCard(
                      title: 'guide_earnings'.tr(),
                      value: 'guide_earnings_value'.tr(),
                      icon: Icons.currency_exchange_rounded,
                      valueColor: Color(0xFFF79A3B),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }
}

final List<TripData> _trips = [
  const TripData(
    imagePath: 'assets/images/trip.png',
    title: 'Dahab Adventure',
    date: 'Mon 20 Feb 2026',
    tourists: '10 tourists',
  ),

  const TripData(
    imagePath: 'assets/images/trip.png',
    title: 'Giza Adventure',
    date: 'Mon 20 Feb 2026',
    tourists: '10 tourists',
  ),
];
