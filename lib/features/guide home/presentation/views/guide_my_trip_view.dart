import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/services/service_locator.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/guide%20home/data/model/guide_trip_summary_model.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/manger/guide_my_trip_cubit/guide_my_trip_cubit.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_filter_chip.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_home_search_field.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_trip_preview_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyTripView extends StatelessWidget {
  const MyTripView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<GuideMyTripCubit>()..loadTrips(),
      child: const _MyTripViewBody(),
    );
  }
}

class _MyTripViewBody extends StatelessWidget {
  const _MyTripViewBody();

  @override
  Widget build(BuildContext context) {
    final pageBg = Theme.of(context).scaffoldBackgroundColor;
    final cardBg = Theme.of(context).cardColor;
    final primaryText =
        Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : AppColor.primaryColor;

    return BlocBuilder<GuideMyTripCubit, GuideMyTripState>(
      builder: (context, state) {
        final query = state.searchQuery.trim().toLowerCase();
        final baseTrips = List<GuideTripSummaryModel>.from(state.trips);
        if (state.filter == MyTripFilter.newTrips) {
          baseTrips.sort((a, b) => b.id.compareTo(a.id));
        }
        final filteredTrips =
            query.isEmpty
                ? baseTrips
                : baseTrips
                    .where(
                      (trip) =>
                          trip.title.toLowerCase().contains(query) ||
                          trip.city.toLowerCase().contains(query) ||
                          trip.category.toLowerCase().contains(query),
                    )
                    .toList();

        return SafeArea(
          child: ColoredBox(
            color: pageBg,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'guide_my_trip_title'.tr(),
                      style: TextStyle(
                        color: primaryText,
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  GuideHomeSearchField(
                    hintText: 'guide_search_trip'.tr(),
                    onChanged:
                        context.read<GuideMyTripCubit>().updateSearchQuery,
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Expanded(
                        child: GuideFilterChip(
                          label: 'guide_filter_new'.tr(),
                          isSelected: state.filter == MyTripFilter.newTrips,
                          backgroundColor: cardBg,
                          textColor: primaryText,
                          onTap:
                              () => context
                                  .read<GuideMyTripCubit>()
                                  .selectFilter(MyTripFilter.newTrips),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: GuideFilterChip(
                          label: 'guide_filter_all'.tr(),
                          isSelected: state.filter == MyTripFilter.all,
                          backgroundColor: cardBg,
                          textColor: primaryText,
                          onTap:
                              () => context
                                  .read<GuideMyTripCubit>()
                                  .selectFilter(MyTripFilter.all),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: GuideFilterChip(
                          label: 'guide_filter_upcoming'.tr(),
                          isSelected: state.filter == MyTripFilter.upcoming,
                          backgroundColor: cardBg,
                          textColor: primaryText,
                          onTap:
                              () => context
                                  .read<GuideMyTripCubit>()
                                  .selectFilter(MyTripFilter.upcoming),
                        ),
                      ),
                    ],
                  ),
                  if (state.filter != MyTripFilter.upcoming &&
                      state.showCreatedBanner) ...[
                    SizedBox(height: 10.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.secondaryColor.withValues(alpha: .07),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: AppColor.secondaryColor.withValues(alpha: .26),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            size: 16.sp,
                            color: AppColor.secondaryColor,
                          ),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: AppColor.secondaryColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'guide_trip_added_successfully'.tr(),
                                    style: TextStyle(
                                      fontSize: 10.5.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'guide_trip_live_open_booking'.tr(),
                                    style: TextStyle(
                                      fontSize: 9.2.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap:
                                context.read<GuideMyTripCubit>().dismissBanner,
                            borderRadius: BorderRadius.circular(20.r),
                            child: Padding(
                              padding: EdgeInsets.all(2.r),
                              child: Icon(
                                Icons.close,
                                size: 14.sp,
                                color: AppColor.secondaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  SizedBox(height: 12.h),
                  Text(
                    state.filter == MyTripFilter.upcoming
                        ? 'guide_upcoming_trips'.tr()
                        : 'guide_new_trips'.tr(),
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: primaryText,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  if (state.status == GuideMyTripStatus.loading)
                    Padding(
                      padding: EdgeInsets.only(top: 12.h),
                      child: const Center(child: CircularProgressIndicator()),
                    )
                  else if (state.status == GuideMyTripStatus.failure)
                    Padding(
                      padding: EdgeInsets.only(top: 12.h),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              state.errorMessage ?? 'Failed to load trips',
                              style: TextStyle(
                                color: primaryText,
                                fontSize: 12.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8.h),
                            TextButton(
                              onPressed:
                                  context.read<GuideMyTripCubit>().loadTrips,
                              child: Text(
                                'Retry',
                                style: TextStyle(color: AppColor.secondaryColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else if (filteredTrips.isEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: 12.h),
                      child: Center(
                        child: Text(
                          'No trips found',
                          style: TextStyle(color: primaryText),
                        ),
                      ),
                    )
                  else
                    ListView.separated(
                      itemCount: filteredTrips.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (_, __) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        final item = filteredTrips[index];
                        if (state.filter == MyTripFilter.upcoming) {
                          return _UpcomingTripCard(item: item);
                        }
                        return _NewTripCard(item: item);
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

class _NewTripCard extends StatelessWidget {
  final GuideTripSummaryModel item;

  const _NewTripCard({required this.item});

  @override
  Widget build(BuildContext context) {
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
      tag: item.category.isNotEmpty ? item.category : 'guide_trip_tag_history'.tr(),
    );
  }
}

class _UpcomingTripCard extends StatelessWidget {
  final GuideTripSummaryModel item;

  const _UpcomingTripCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final cardBg = Theme.of(context).cardColor;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText =
        Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : AppColor.primaryColor;
    final secondaryMetaText =
      isDark ? const Color(0xFF9FB0BD) : AppColor.primaryColor.withValues(alpha: .55);
    final priceValue = item.pricePerTourist;
    final priceText =
      priceValue != null ? '\$${priceValue.toStringAsFixed(2)}' : '--';

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColor.secondaryColor, width: .9),
      ),
      padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/trip.png',
                  height: 98.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: 8.w,
                  top: 8.h,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 3.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.secondaryColor.withValues(alpha: .35),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      'guide_adventure_trip'.tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 10.w,
                  right: 10.w,
                  bottom: 8.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        item.city,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            item.title,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: primaryText,
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Icon(
                Icons.calendar_month_rounded,
                size: 12.sp,
                color: AppColor.secondaryColor,
              ),
              SizedBox(width: 3.w),
              Text(
                item.duration ?? 'TBD',
                style: TextStyle(
                  fontSize: 9.sp,
                  color: secondaryMetaText,
                ),
              ),
              const Spacer(),
              Text(
                priceText,
                style: TextStyle(
                  fontSize: 9.sp,
                  color: secondaryMetaText,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              SizedBox(
                height: 24.h,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.secondaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    'guide_confirmed'.tr(),
                    style: TextStyle(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Text(
                'guide_view_details'.tr(),
                style: TextStyle(
                  fontSize: 9.sp,
                  color: AppColor.secondaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
