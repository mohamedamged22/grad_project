import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/mock/tourist_home_mock_data.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/model/tourist_landmark_details.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/model/tourist_landmark_trip.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/repo/tourist_favorites_repo.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tourist_landmark_details_cubit/tourist_landmark_details_cubit.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tourist_landmark_details_cubit/tourist_landmark_details_state.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tourist_landmark_trips_cubit/tourist_landmark_trips_cubit.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tourist_landmark_trips_cubit/tourist_landmark_trips_state.dart';
import 'package:beyond_the_pramids/core/services/service_locator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TouristLandmarkDetailsArgs {
  final int? id;
  final String title;
  final String city;
  final String? imageUrl;
  final String? rating;

  const TouristLandmarkDetailsArgs({
    required this.id,
    required this.title,
    required this.city,
    required this.imageUrl,
    required this.rating,
  });

  factory TouristLandmarkDetailsArgs.fromMock(TouristLandmark landmark) {
    return TouristLandmarkDetailsArgs(
      id: null,
      title: landmark.title,
      city: landmark.city,
      imageUrl: landmark.imagePath,
      rating: landmark.rating,
    );
  }
}

class TouristLandmarkDetailsView extends StatefulWidget {
  final TouristLandmarkDetailsArgs args;

  const TouristLandmarkDetailsView({super.key, required this.args});

  @override
  State<TouristLandmarkDetailsView> createState() =>
      _TouristLandmarkDetailsViewState();
}

class _TouristLandmarkDetailsViewState extends State<TouristLandmarkDetailsView> {
  bool _isFavorite = false;
  bool _isSaving = false;
  late final TouristFavoritesRepo _favoritesRepo;

  @override
  void initState() {
    super.initState();
    _favoritesRepo = sl<TouristFavoritesRepo>();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    final landmarkId = widget.args.id;
    if (landmarkId == null) return;

    try {
      final favorites = await _favoritesRepo.getFavoriteLandmarks();
      if (!mounted) return;
      setState(() {
        _isFavorite = favorites.any((item) => item.id == landmarkId);
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final landmarkId = widget.args.id;

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TouristLandmarkDetailsCubit, TouristLandmarkDetailsState>(
          builder: (context, state) {
            final details = state.details;
            final title = details?.name ?? widget.args.title;
            final city = details?.city ?? widget.args.city;
            final type = details?.type ?? '';
            final description = details?.description ?? '';
            final address = details?.address ?? '';
            final imageUrl = _resolveImageUrl(details, widget.args);
            final isLoading = state.status == TouristLandmarkDetailsStatus.loading;

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18.sp,
                      color: isDark ? Colors.white : AppColor.primaryColor,
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed:
                          (landmarkId == null || _isSaving)
                              ? null
                              : () async {
                                final nextValue = !_isFavorite;
                                setState(() {
                                  _isFavorite = nextValue;
                                  _isSaving = true;
                                });

                                try {
                                  if (nextValue) {
                                    await _favoritesRepo.addLandmarkFavorite(
                                      landmarkId: landmarkId,
                                    );
                                  } else {
                                    await _favoritesRepo.removeLandmarkFavorite(
                                      landmarkId: landmarkId,
                                    );
                                  }
                                } catch (e) {
                                  if (mounted) {
                                    setState(
                                      () => _isFavorite = !nextValue,
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString())),
                                    );
                                  }
                                } finally {
                                  if (mounted) {
                                    setState(() => _isSaving = false);
                                  }
                                }
                              },
                      icon: Icon(
                        _isFavorite
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color:
                            _isFavorite
                                ? const Color(0xFFFF4D5B)
                                : (isDark
                                    ? Colors.white
                                    : AppColor.primaryColor),
                      ),
                    ),
                  ],
                  expandedHeight: 220.h,
                  flexibleSpace: FlexibleSpaceBar(
                    background: _LandmarkImage(
                      imageUrl: imageUrl,
                      fallbackAsset: widget.args.imageUrl,
                      isDark: isDark,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                            color: isDark ? Colors.white : AppColor.primaryColor,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 16.sp,
                              color: AppColor.secondaryColor,
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: Text(
                                city,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: isDark
                                      ? const Color(0xFFB2C0CC)
                                      : const Color(0xFF607281),
                                ),
                              ),
                            ),
                            if (widget.args.rating != null)
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_rounded,
                                    size: 16.sp,
                                    color: AppColor.secondaryColor,
                                  ),
                                  SizedBox(width: 2.w),
                                  Text(
                                    widget.args.rating!,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.secondaryColor,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        if (isLoading)
                          const Center(child: CircularProgressIndicator())
                        else ...[
                          if (type.trim().isNotEmpty)
                            _InfoRow(
                              label: 'tourist_landmark_type'.tr(),
                              value: type,
                            ),
                          if (address.trim().isNotEmpty)
                            _InfoRow(
                              label: 'tourist_landmark_address'.tr(),
                              value: address,
                            ),
                          if (description.trim().isNotEmpty) ...[
                            SizedBox(height: 10.h),
                            Text(
                              'tourist_landmark_about'.tr(),
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: isDark
                                    ? Colors.white
                                    : AppColor.primaryColor,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              description,
                              style: TextStyle(
                                fontSize: 12.sp,
                                height: 1.5,
                                color: isDark
                                    ? const Color(0xFFB2C0CC)
                                    : const Color(0xFF607281),
                              ),
                            ),
                          ],
                          SizedBox(height: 16.h),
                          Text(
                            'tourist_landmark_trips_visiting'.tr(),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: isDark
                                  ? Colors.white
                                  : AppColor.primaryColor,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          _LandmarkTripsSection(
                            landmarkId: widget.args.id,
                          ),
                          if (state.status == TouristLandmarkDetailsStatus.failure)
                            Padding(
                              padding: EdgeInsets.only(top: 10.h),
                              child: Text(
                                state.errorMessage ??
                                    'tourist_landmark_details_failed'.tr(),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String? _resolveImageUrl(
    TouristLandmarkDetails? details,
    TouristLandmarkDetailsArgs args,
  ) {
    final detailsUrl = details?.normalizedImageUrl;
    if (detailsUrl != null && detailsUrl.trim().isNotEmpty) {
      return detailsUrl;
    }
    final raw = args.imageUrl?.trim();
    if (raw == null || raw.isEmpty) return null;
    return raw;
  }
}

class _LandmarkImage extends StatelessWidget {
  final String? imageUrl;
  final String? fallbackAsset;
  final bool isDark;

  const _LandmarkImage({
    required this.imageUrl,
    required this.fallbackAsset,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final resolved = imageUrl;
    final fallback = fallbackAsset;

    if (resolved != null && resolved.startsWith('http')) {
      return Image.network(
        resolved,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }

    if (resolved != null && resolved.startsWith('assets/')) {
      return Image.asset(
        resolved,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }

    if (fallback != null && fallback.startsWith('assets/')) {
      return Image.asset(
        fallback,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }

    return Container(
      color: isDark ? const Color(0xFF1C2732) : const Color(0xFFE6EEF2),
      alignment: Alignment.center,
      child: Icon(
        Icons.image_outlined,
        size: 56.sp,
        color: AppColor.secondaryColor,
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : AppColor.primaryColor,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12.sp,
                color: isDark ? const Color(0xFFB2C0CC) : const Color(0xFF607281),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LandmarkTripsSection extends StatelessWidget {
  final int? landmarkId;

  const _LandmarkTripsSection({required this.landmarkId});

  @override
  Widget build(BuildContext context) {
    if (landmarkId == null) {
      return Text(
        'Trips will appear here once available.',
        style: TextStyle(
          fontSize: 12.sp,
          color: const Color(0xFF607281),
        ),
      );
    }

    return BlocBuilder<TouristLandmarkTripsCubit, TouristLandmarkTripsState>(
      builder: (context, state) {
        if (state.status == TouristLandmarkTripsStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == TouristLandmarkTripsStatus.failure) {
          return Text(
            state.errorMessage ?? 'Failed to load trips',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.redAccent,
            ),
          );
        }

        if (state.trips.isEmpty) {
          return Text(
            'No trips available for this landmark yet.',
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xFF607281),
            ),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.trips.length,
          separatorBuilder: (_, __) => SizedBox(height: 8.h),
          itemBuilder: (context, index) {
            final trip = state.trips[index];
            return _LandmarkTripCard(trip: trip);
          },
        );
      },
    );
  }
}

class _LandmarkTripCard extends StatelessWidget {
  final TouristLandmarkTrip trip;

  const _LandmarkTripCard({required this.trip});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final coverUrl = trip.normalizedImageUrl;

    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark ? const Color(0xFF2F3D49) : const Color(0xFFE4EBF0),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: coverUrl != null
                ? Image.network(
                    coverUrl,
                    width: 72.w,
                    height: 72.w,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 72.w,
                    height: 72.w,
                    color: isDark
                        ? const Color(0xFF1C2732)
                        : const Color(0xFFE6EEF2),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.image_outlined,
                      size: 24.sp,
                      color: AppColor.secondaryColor,
                    ),
                  ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trip.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : AppColor.primaryColor,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  trip.city,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color:
                        isDark
                            ? const Color(0xFFB2C0CC)
                            : const Color(0xFF607281),
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Text(
                      trip.duration,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: AppColor.secondaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '\$ ${trip.pricePerTourist}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColor.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
