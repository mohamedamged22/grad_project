import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/guide%20home/data/model/guide_trip_summary_model.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/manger/guide_my_trip_cubit/guide_my_trip_cubit.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/manger/guide_profile_cubit/guide_profile_cubit.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/manger/guide_requests_cubit/guide_requests_cubit.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/manger/guide_root_cubit/guide_root_cubit.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_home_search_field.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_home_top_bar.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_metric_card.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_new_request_card.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_promo_trip_card.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_section_title.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_trip_preview_card.dart';
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

              // ── Trips Section (above requests) – show only last trip ──
              BlocBuilder<GuideMyTripCubit, GuideMyTripState>(
                builder: (context, tripState) {
                  if (tripState.status == GuideMyTripStatus.loading) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: CircularProgressIndicator(
                          color: AppColor.secondaryColor,
                        ),
                      ),
                    );
                  }

                  if (tripState.status == GuideMyTripStatus.failure) {
                    return const SizedBox.shrink();
                  }

                  final trips = tripState.trips;
                  if (trips.isEmpty) return const SizedBox.shrink();

                  // Show only the last (latest) trip
                  final lastTrip = trips.last;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GuideSectionTitle(
                        title: 'guide_trips'.tr(),
                        onTap: () {
                          context.read<GuideRootCubit>().changeTab(2);
                        },
                      ),
                      SizedBox(height: 8.h),
                      _buildTripCard(lastTrip),
                      SizedBox(height: 12.h),
                    ],
                  );
                },
              ),

              // ── Latest Booking Request ──
              BlocBuilder<GuideRequestsCubit, GuideRequestsState>(
                builder: (context, reqState) {
                  if (reqState.status != GuideRequestsStatus.success ||
                      reqState.bookings.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  final latestBooking = reqState.bookings.first;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GuideSectionTitle(
                        title: 'guide_new_requests'.tr(),
                        onTap: () {
                          context.read<GuideRootCubit>().changeTab(1);
                        },
                      ),
                      SizedBox(height: 8.h),
                      GuideNewRequestCard(
                        booking: latestBooking,
                        onAccept: () {
                          context
                              .read<GuideRequestsCubit>()
                              .acceptBooking(latestBooking.id);
                        },
                        onDecline: () {
                          context
                              .read<GuideRequestsCubit>()
                              .rejectBooking(latestBooking.id);
                        },
                      ),
                      SizedBox(height: 16.h),
                    ],
                  );
                },
              ),

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

  Widget _buildTripCard(GuideTripSummaryModel item) {
    final priceValue = item.pricePerTourist;
    final priceText =
        priceValue != null ? '\$${priceValue.toStringAsFixed(2)}' : '--';

    return GuideTripPreviewCard(
      imagePath: 'assets/images/trip.png',
      imageUrl: item.normalizedCoverImageUrl,
      title: item.title,
      location: item.city,
      spots: item.status.isNotEmpty ? item.status : '--',
      dateRange: item.duration ?? 'TBD',
      price: priceText,
      priceSuffix: 'guide_price_per_person_suffix'.tr(),
      tag:
          item.category.isNotEmpty
              ? item.category
              : 'guide_trip_tag_history'.tr(),
    );
  }
}