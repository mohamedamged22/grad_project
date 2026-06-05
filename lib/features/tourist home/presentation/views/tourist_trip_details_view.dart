import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/services/service_locator.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/model/tourist_public_trip.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/repo/tourist_favorites_repo.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tourist_trip_details_cubit/tourist_trip_details_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TouristTripDetailsView extends StatefulWidget {
  final TouristPublicTrip trip;

  const TouristTripDetailsView({super.key, required this.trip});

  @override
  State<TouristTripDetailsView> createState() => _TouristTripDetailsViewState();
}

class _TouristTripDetailsViewState extends State<TouristTripDetailsView> {
  bool _isSaved = false;
  bool _isSaving = false;
  late final TouristTripDetailsCubit _detailsCubit;
  late final TouristFavoritesRepo _favoritesRepo;

  @override
  void initState() {
    super.initState();
    _detailsCubit = sl<TouristTripDetailsCubit>()
      ..fetchTripDetails(tripId: widget.trip.id);
    _favoritesRepo = sl<TouristFavoritesRepo>();
  }

  @override
  void dispose() {
    _detailsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BlocProvider.value(
      value: _detailsCubit,
      child: BlocBuilder<TouristTripDetailsCubit, TouristTripDetailsState>(
        builder: (context, state) {
          final details = state.details;
          final title = details?.title ?? widget.trip.title;
          final city = details?.city ?? widget.trip.city;
          final coverUrl = details?.normalizedCoverImageUrl ?? widget.trip.normalizedImageUrl;
          final dateRange = details?.dateRange ?? '';
          final duration = (details?.tourDuration ?? widget.trip.duration).toString().trim();
          final groupSize = details?.groupSizeLabel ?? '';
          final description = details?.description ?? '';
          final inclusions = details?.inclusions ?? const [];
          final categories = details?.categories ?? const [];
          final guide = details?.guide;
          final status = details?.status ?? widget.trip.status;
          final meetingPoint = details?.meetingPoint ?? '';
          final priceText = details?.formattedPrice ?? widget.trip.formattedPrice;

          return Scaffold(
            body: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 92.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(22.r),
                bottomRight: Radius.circular(22.r),
              ),
              child: SizedBox(
                height: 250.h,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (coverUrl != null)
                      Image.network(coverUrl, fit: BoxFit.cover)
                    else
                      Container(
                        color:
                            isDark
                                ? const Color(0xFF1C2732)
                                : const Color(0xFFE6EEF2),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.image_outlined,
                          size: 56.sp,
                          color: AppColor.secondaryColor,
                        ),
                      ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColor.primaryColor.withOpacity(0.05),
                            AppColor.primaryColor.withOpacity(0.25),
                            AppColor.primaryColor.withOpacity(0.88),
                          ],
                          stops: const [0.2, 0.52, 1],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10.w,
                      right: 10.w,
                      top: MediaQuery.of(context).padding.top + 4.h,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            constraints: const BoxConstraints(),
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 24.sp,
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed:
                                _isSaving
                                    ? null
                                    : () async {
                                      final nextValue = !_isSaved;
                                      setState(() {
                                        _isSaved = nextValue;
                                        _isSaving = true;
                                      });

                                      try {
                                        if (nextValue) {
                                          await _favoritesRepo.addTripFavorite(
                                            tripId: widget.trip.id,
                                          );
                                        } else {
                                          await _favoritesRepo
                                              .removeTripFavorite(
                                                tripId: widget.trip.id,
                                              );
                                        }
                                      } catch (e) {
                                        if (mounted) {
                                          setState(() => _isSaved = !nextValue);
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(content: Text(e.toString())),
                                          );
                                        }
                                      } finally {
                                        if (mounted) {
                                          setState(() => _isSaving = false);
                                        }
                                      }
                                    },
                            constraints: const BoxConstraints(),
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              _isSaved
                                  ? Icons.bookmark_rounded
                                  : Icons.bookmark_border_rounded,
                              size: 24.sp,
                              color:
                                  _isSaved
                                      ? const Color(0xFFF8B64C)
                                      : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 12.w,
                      right: 12.w,
                      bottom: 12.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                              height: 1,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 18.sp,
                                color: const Color(0xFFF8B64C),
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                city,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.95),
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _TripStat(
                    icon: Icons.calendar_month_rounded,
                    label: 'trip_details_date'.tr(),
                    value:
                        dateRange.isEmpty
                            ? 'pricing_duration_flexible'.tr()
                            : dateRange,
                  ),
                  _TripStat(
                    icon: Icons.access_time_rounded,
                    label: 'trip_details_duration'.tr(),
                    value:
                        duration.isEmpty
                            ? 'pricing_duration_flexible'.tr()
                            : duration,
                  ),
                  _TripStat(
                    icon: Icons.people_outline_rounded,
                    label: 'trip_details_group'.tr(),
                    value: groupSize.isEmpty ? '-' : groupSize,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            if (meetingPoint.trim().isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  children: [
                    Icon(
                      Icons.place_outlined,
                      size: 16.sp,
                      color: AppColor.secondaryColor,
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        meetingPoint,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color:
                              isDark
                                  ? const Color(0xFFB2C0CC)
                                  : const Color(0xFF607281),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (categories.isNotEmpty) ...[
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Wrap(
                  spacing: 6.w,
                  runSpacing: 6.h,
                  children:
                      categories
                          .map(
                            (item) => Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    isDark
                                        ? const Color(0xFF1D2A33)
                                        : const Color(0xFFE9F1F5),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      isDark
                                          ? const Color(0xFFB2C0CC)
                                          : AppColor.primaryColor,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
            ],
            SizedBox(height: 14.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Text(
                'trip_details_about'.tr(),
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.secondaryColor,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(11.w),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1A2833) : AppColor.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color:
                        isDark
                            ? const Color(0xFF2F4A5A)
                            : const Color(0xFF9EC5D7),
                  ),
                ),
                child: Text(
                  description.isEmpty
                      ? 'trip_details_no_description'.tr()
                      : description,
                  style: TextStyle(
                    fontSize: 10.sp,
                    height: 1.42,
                    color:
                        isDark
                            ? const Color(0xFFB2C0CC)
                            : const Color(0xFF5B6D7B),
                  ),
                ),
              ),
            ),
            SizedBox(height: 14.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Text(
                'trip_details_included'.tr(),
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.secondaryColor,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    inclusions.isEmpty
                        ? [
                          _IncludedItem(
                            text: 'trip_details_no_inclusions'.tr(),
                          ),
                        ]
                        : inclusions
                            .map((item) => _IncludedItem(text: item))
                            .toList(),
              ),
            ),
            SizedBox(height: 14.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Text(
                'trip_details_tour_guide'.tr(),
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.secondaryColor,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: const Color(0xffF89422)),
                ),
                child: guide == null
                    ? Text(
                  'trip_details_guide_unavailable'.tr(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color:
                              isDark
                                  ? const Color(0xFFB2C0CC)
                                  : AppColor.secondaryColor,
                        ),
                      )
                    : Row(
                        children: [
                          CircleAvatar(
                            radius: 20.r,
                            backgroundImage:
                                guide.normalizedProfilePhoto != null
                                    ? NetworkImage(
                                      guide.normalizedProfilePhoto!,
                                    )
                                    : null,
                            backgroundColor:
                                guide.normalizedProfilePhoto == null
                                    ? (isDark
                                        ? const Color(0xFF1C2732)
                                        : const Color(0xFFE6EEF2))
                                    : null,
                            child:
                                guide.normalizedProfilePhoto == null
                                    ? Icon(
                                      Icons.person,
                                      size: 20.sp,
                                      color: AppColor.secondaryColor,
                                    )
                                    : null,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  guide.name,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.secondaryColor,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                
                                  '⭐ ${guide.rating} • ${guide.yearsOfExperience} ${"years_short".tr()}',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color:
                                        isDark
                                            ? const Color(0xFFB2C0CC)
                                            : AppColor.secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/tourGuideProfileView',
                              );
                            },
                            borderRadius: BorderRadius.circular(12.r),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 4.h,
                              ),
                              child: Text(
                                'trip_details_view_profile'.tr(),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColor.secondaryColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            if (state.status == TouristTripDetailsStatus.failure)
              Padding(
                padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 0),
                child: Text(
                  state.errorMessage ?? 'trip_details_load_failed'.tr(),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.redAccent,
                  ),
                ),
              ),
            if (status.trim().isNotEmpty) ...[
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Text(
                  'trip_details_status'.tr(namedArgs: {'status': status}),
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color:
                        isDark
                            ? const Color(0xFFB2C0CC)
                            : const Color(0xFF607281),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 10.h),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color:
                    isDark ? const Color(0x22000000) : const Color(0x12000000),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: isDark ? Colors.white : AppColor.primaryColor,
                  ),
                  children: [
                    TextSpan(
                      text: '\$ $priceText',
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColor.secondaryColor,
                        height: 0.95,
                      ),
                    ),
                    TextSpan(
                      text: 'price_per_person_suffix'.tr(),
                      style: TextStyle(
                        fontSize: 11.sp,
                        color:
                            isDark
                                ? const Color(0xFFB2C0CC)
                                : const Color(0xFF6C7F8E),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 38.h,
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColor.secondaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.r),
                    ),
                  ),
                  child: Text(
                    'trip_details_book_now'.tr(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
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
) );}
}
class _TripStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _TripStat({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 20.sp, color: const Color(0xFFF89422)),
        SizedBox(height: 2.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColor.black.withOpacity(0.6),
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: AppColor.black,
          ),
        ),
      ],
    );
  }
}

class _IncludedItem extends StatelessWidget {
  final String text;

  const _IncludedItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_rounded,
            size: 16.sp,
            color: AppColor.secondaryColor,
          ),
          SizedBox(width: 6.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColor.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
