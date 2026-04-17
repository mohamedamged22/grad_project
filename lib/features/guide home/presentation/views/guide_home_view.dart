import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_home_search_field.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_home_top_bar.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_metric_card.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_new_request_card.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_promo_trip_card.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_section_title.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_upcoming_trip_card.dart';
import 'package:flutter/material.dart';

class GuideHomeView extends StatelessWidget {
  const GuideHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final pageBg = Theme.of(context).scaffoldBackgroundColor;
    final primaryText =
        Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : AppColor.primaryColor;

    return SafeArea(
      child: ColoredBox(
        color: pageBg,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GuideHomeTopBar(),
              SizedBox(height: 4.h),
              Text(
                'Welcome to our Team',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.secondaryColor,
                ),
              ),
              SizedBox(height: 8.h),
              const GuideHomeSearchField(),
              SizedBox(height: 16.h),
              GuidePromoTripCard(
                onCreateTripTap: () {
                  Navigator.pushNamed(context, '/guideCreateNewTripView');
                },
              ),
              SizedBox(height: 16.h),
              const GuideSectionTitle(title: 'Upcoming Trips'),
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
              const GuideSectionTitle(title: 'New requests'),
              SizedBox(height: 8.h),
              const GuideNewRequestCard(),
              SizedBox(height: 14.h),
              Text(
                'This Month',
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
                      title: 'Completed Trips',
                      value: '12 Trips',
                      icon: Icons.trending_up_rounded,
                      valueColor: Color(0xFFF79A3B),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: GuideMetricCard(
                      title: 'Rating',
                      value: '4.8/5',
                      icon: Icons.star_border_rounded,
                      valueColor: Color(0xFFF79A3B),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: GuideMetricCard(
                      title: 'Earnings',
                      value: '1500\$',
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
