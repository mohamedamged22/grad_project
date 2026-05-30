import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/services/service_locator.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/model/tourist_public_trip.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/repo/tourist_favorites_repo.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tourist_public_trips_cubit/tourist_public_trips_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TouristGroupTripsView extends StatefulWidget {
  const TouristGroupTripsView({super.key});

  @override
  State<TouristGroupTripsView> createState() => _TouristGroupTripsViewState();
}

class _TouristGroupTripsViewState extends State<TouristGroupTripsView> {
  String _searchQuery = '';
  final Set<int> _favoriteTrips = <int>{};
  final Set<int> _savingTrips = <int>{};
  late final TouristPublicTripsCubit _tripsCubit;
  late final TouristFavoritesRepo _favoritesRepo;

  @override
  void initState() {
    super.initState();
    _tripsCubit = sl<TouristPublicTripsCubit>()..fetchTrips(size: 12);
    _favoritesRepo = sl<TouristFavoritesRepo>();
    _loadFavoriteTrips();
  }

  @override
  void dispose() {
    _tripsCubit.close();
    super.dispose();
  }

  Future<void> _loadFavoriteTrips() async {
    try {
      final favorites = await _favoritesRepo.getFavoriteTrips();
      if (!mounted) return;
      setState(() {
        _favoriteTrips
          ..clear()
          ..addAll(favorites.map((trip) => trip.id));
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  List<TouristPublicTrip> _filteredTrips(List<TouristPublicTrip> trips) {
    final query = _searchQuery.trim().toLowerCase();

    return trips.where((trip) {
      if (query.isEmpty) {
        return true;
      }

      return trip.title.toLowerCase().contains(query) ||
          trip.city.toLowerCase().contains(query) ||
          trip.category.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final pageBg = Colors.white;
    return BlocProvider.value(
      value: _tripsCubit,
      child: Scaffold(
        backgroundColor: pageBg,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(12.w, 6.h, 12.w, 14.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18.sp,
                        color: AppColor.primaryColor,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Group Trips',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 42.w),
                  ],
                ),
                SizedBox(height: 8.h),
                _SearchBar(
                  onChanged: (value) {
                    setState(() => _searchQuery = value);
                  },
                ),
                SizedBox(height: 10.h),
                BlocBuilder<TouristPublicTripsCubit, TouristPublicTripsState>(
                  builder: (context, state) {
                    if (state.status == TouristPublicTripsStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.status == TouristPublicTripsStatus.failure) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 18.h),
                        child: Center(
                          child: Text(
                            state.errorMessage ?? 'Failed to load trips',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color:
                                  AppColor.primaryColor.withValues(alpha: .55),
                            ),
                          ),
                        ),
                      );
                    }

                    final shownTrips = _filteredTrips(state.trips);
                    if (shownTrips.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 18.h),
                        child: Center(
                          child: Text(
                            'No trips found',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color:
                                  AppColor.primaryColor.withValues(alpha: .55),
                            ),
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: shownTrips.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (_, __) => SizedBox(height: 10.h),
                      itemBuilder: (_, index) {
                        final trip = shownTrips[index];
                        return _TripListCard(
                          item: trip,
                          isFavorite: _favoriteTrips.contains(trip.id),
                          isSaving: _savingTrips.contains(trip.id),
                          onFavoriteTap: () {
                            if (_savingTrips.contains(trip.id)) {
                              return;
                            }

                            final nextValue = !_favoriteTrips.contains(trip.id);
                            setState(() {
                              if (nextValue) {
                                _favoriteTrips.add(trip.id);
                              } else {
                                _favoriteTrips.remove(trip.id);
                              }
                              _savingTrips.add(trip.id);
                            });

                            () async {
                              try {
                                if (nextValue) {
                                  await _favoritesRepo.addTripFavorite(
                                    tripId: trip.id,
                                  );
                                } else {
                                  await _favoritesRepo.removeTripFavorite(
                                    tripId: trip.id,
                                  );
                                }
                              } catch (e) {
                                if (!mounted) return;
                                setState(() {
                                  if (nextValue) {
                                    _favoriteTrips.remove(trip.id);
                                  } else {
                                    _favoriteTrips.add(trip.id);
                                  }
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())),
                                );
                              } finally {
                                if (!mounted) return;
                                setState(() => _savingTrips.remove(trip.id));
                              }
                            }();
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const _SearchBar({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      style: TextStyle(color: AppColor.primaryColor),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF6F8F9),
        hintText: 'Discover Egypt',
        hintStyle: TextStyle(
          fontSize: 12.sp,
          color: const Color(0xFF8DA0AD),
        ),
        prefixIcon: Icon(
          Icons.search_rounded,
          color: AppColor.secondaryColor,
          size: 20.sp,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(26.r),
          borderSide: BorderSide(color: AppColor.secondaryColor, width: 1.45),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(26.r),
          borderSide: BorderSide(color: AppColor.secondaryColor, width: 1.7),
        ),
      ),
    );
  }
}

class _TripListCard extends StatelessWidget {
  final TouristPublicTrip item;
  final bool isFavorite;
  final bool isSaving;
  final VoidCallback onFavoriteTap;

  const _TripListCard({
    required this.item,
    required this.isFavorite,
    required this.isSaving,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = Theme.of(context).cardColor;
    final titleText = item.title.trim().replaceAll(RegExp(r'\s+'), ' ');
    final coverUrl = item.normalizedImageUrl;

    return Container(
      padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 10.h),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark ? const Color(0xFF2F4150) : const Color(0xFFDBE5EB),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: SizedBox(
              height: 124.h,
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
                        size: 30.sp,
                        color: AppColor.secondaryColor,
                      ),
                    ),
                  Positioned(
                    left: 8.w,
                    top: 8.h,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 9.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6D99A8).withValues(alpha: .82),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        item.category.isEmpty ? 'Trip' : item.category,
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: GestureDetector(
                      onTap: isSaving ? null : onFavoriteTap,
                      child: Container(
                        height: 22.w,
                        width: 22.w,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: .30),
                          borderRadius: BorderRadius.circular(7.r),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: .6),
                          ),
                        ),
                        child:
                            isSaving
                                ? Padding(
                                  padding: EdgeInsets.all(5.w),
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 1.6,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                                : Icon(
                                  isFavorite
                                      ? Icons.bookmark_rounded
                                      : Icons.bookmark_border_rounded,
                                  size: 14.sp,
                                  color: isFavorite
                                      ? const Color(0xFFF8B64C)
                                      : Colors.white,
                                ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            titleText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : AppColor.primaryColor,
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 12.sp,
                color:
                    isDark ? const Color(0xFF9FB0BD) : const Color(0xFF8A9BA7),
              ),
              SizedBox(width: 2.w),
              Text(
                item.city,
                style: TextStyle(
                  fontSize: 9.sp,
                  color:
                      isDark
                          ? const Color(0xFF9FB0BD)
                          : const Color(0xFF8A9BA7),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.schedule_rounded,
                size: 10.sp,
                color:
                    isDark ? const Color(0xFF9FB0BD) : const Color(0xFF8A9BA7),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: Text(
                  item.duration.isEmpty ? 'Flexible' : item.duration,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 8.sp,
                    color:
                        isDark
                            ? const Color(0xFF9FB0BD)
                            : const Color(0xFF8A9BA7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (item.status.trim().isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF1D2A33)
                        : const Color(0xFFE9F1F5),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    item.status,
                    style: TextStyle(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? const Color(0xFFB2C0CC)
                          : AppColor.primaryColor,
                    ),
                  ),
                ),
              const Spacer(),
              RichText(
                text: TextSpan(
                  text: '\$ ${item.formattedPrice} ',
                  style: TextStyle(
                    color: AppColor.secondaryColor,
                    fontSize: 33.sp,
                    fontWeight: FontWeight.w800,
                    height: .9,
                  ),
                  children: [
                    TextSpan(
                      text: '/person',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color:
                            isDark
                                ? const Color(0xFF9FB0BD)
                                : const Color(0xFF7D8F9C),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
