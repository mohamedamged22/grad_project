import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/services/service_locator.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/model/tourist_landmark_list_item.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/model/tourist_public_trip.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/repo/tourist_favorites_repo.dart';
import 'package:flutter/material.dart';

class TouristSavedTripsView extends StatefulWidget {
  const TouristSavedTripsView({super.key});

  @override
  State<TouristSavedTripsView> createState() => _TouristSavedTripsViewState();
}

class _TouristSavedTripsViewState extends State<TouristSavedTripsView> {
  int _selectedTab = 0;
  bool _isLoadingTrips = true;
  bool _isLoadingLandmarks = true;
  String? _tripError;
  String? _landmarkError;
  final Set<int> _removingTrips = {};
  final Set<int> _removingLandmarks = {};
  List<TouristPublicTrip> _trips = [];
  List<TouristLandmarkListItem> _landmarks = [];
  late final TouristFavoritesRepo _favoritesRepo;

  static const _tabs = ['Trips', 'Landmarks'];

  @override
  void initState() {
    super.initState();
    _favoritesRepo = sl<TouristFavoritesRepo>();
    _loadTrips();
    _loadLandmarks();
  }

  Future<void> _loadTrips() async {
    setState(() {
      _isLoadingTrips = true;
      _tripError = null;
    });

    try {
      final trips = await _favoritesRepo.getFavoriteTrips();
      if (!mounted) return;
      setState(() => _trips = trips);
    } catch (e) {
      if (!mounted) return;
      setState(() => _tripError = e.toString());
    } finally {
      if (!mounted) return;
      setState(() => _isLoadingTrips = false);
    }
  }

  Future<void> _loadLandmarks() async {
    setState(() {
      _isLoadingLandmarks = true;
      _landmarkError = null;
    });

    try {
      final landmarks = await _favoritesRepo.getFavoriteLandmarks();
      if (!mounted) return;
      setState(() => _landmarks = landmarks);
    } catch (e) {
      if (!mounted) return;
      setState(() => _landmarkError = e.toString());
    } finally {
      if (!mounted) return;
      setState(() => _isLoadingLandmarks = false);
    }
  }

  Future<void> _removeTripFavorite(int tripId) async {
    setState(() => _removingTrips.add(tripId));
    try {
      await _favoritesRepo.removeTripFavorite(tripId: tripId);
      if (!mounted) return;
      setState(() => _trips.removeWhere((trip) => trip.id == tripId));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (!mounted) return;
      setState(() => _removingTrips.remove(tripId));
    }
  }

  Future<void> _removeLandmarkFavorite(int landmarkId) async {
    setState(() => _removingLandmarks.add(landmarkId));
    try {
      await _favoritesRepo.removeLandmarkFavorite(landmarkId: landmarkId);
      if (!mounted) return;
      setState(
        () => _landmarks.removeWhere((landmark) => landmark.id == landmarkId),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (!mounted) return;
      setState(() => _removingLandmarks.remove(landmarkId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? Colors.white : AppColor.primaryColor;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18.sp,
            color: AppColor.secondaryColor,
          ),
        ),
        title: Text(
          'Saved Trips',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: primaryText,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.w, 2.h, 10.w, 12.h),
          child: Column(
            children: [
              Row(
                children: List.generate(_tabs.length, (index) {
                  final selected = _selectedTab == index;
                  return Expanded(
                    child: InkWell(
                      onTap: () => setState(() => _selectedTab = index),
                      child: Container(
                        padding: EdgeInsets.only(bottom: 8.h, top: 4.h),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: selected
                                  ? AppColor.secondaryColor
                                  : const Color(0xFFD9E4EA),
                              width: selected ? 2 : 1,
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              index == 0
                                  ? Icons.bookmark_border_rounded
                                  : Icons.landscape_outlined,
                              size: 15.sp,
                              color: AppColor.secondaryColor,
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              _tabs[index],
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight:
                                    selected ? FontWeight.w700 : FontWeight.w500,
                                color: primaryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 10.h),
              Expanded(
                child:
                    _selectedTab == 0
                        ? _TripsTab(
                          isLoading: _isLoadingTrips,
                          errorMessage: _tripError,
                          trips: _trips,
                          removingIds: _removingTrips,
                          onRemove: _removeTripFavorite,
                          onRefresh: _loadTrips,
                        )
                        : _LandmarksTab(
                          isLoading: _isLoadingLandmarks,
                          errorMessage: _landmarkError,
                          landmarks: _landmarks,
                          removingIds: _removingLandmarks,
                          onRemove: _removeLandmarkFavorite,
                          onRefresh: _loadLandmarks,
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SavedTripCard extends StatelessWidget {
  final TouristPublicTrip item;
  final VoidCallback onRemove;
  final bool isRemoving;

  const _SavedTripCard({
    required this.item,
    required this.onRemove,
    required this.isRemoving,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark ? const Color(0xFF2D4350) : const Color(0xFFD9E4EA),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: SizedBox(
              height: 95.h,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (item.normalizedImageUrl != null)
                    Image.network(item.normalizedImageUrl!, fit: BoxFit.cover)
                  else
                    Container(
                      color: isDark
                          ? const Color(0xFF1C2732)
                          : const Color(0xFFE6EEF2),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.image_outlined,
                        size: 26.sp,
                        color: AppColor.secondaryColor,
                      ),
                    ),
                  Positioned(
                    left: 6.w,
                    top: 6.h,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: const Color(0xB0478D9D),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        item.category.isEmpty ? 'Trip' : item.category,
                        style: TextStyle(
                          fontSize: 8.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 7.h),
          Text(
            item.title,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : AppColor.primaryColor,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            item.city,
            style: TextStyle(
              fontSize: 8.sp,
              color: isDark ? const Color(0xFF9FB0BD) : const Color(0xFF78909E),
            ),
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              CircleAvatar(
                radius: 10.r,
                backgroundImage: const AssetImage('assets/images/2th.jpg'),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.status.isEmpty ? 'Available' : item.status,
                      style: TextStyle(
                        fontSize: 8.sp,
                        color: AppColor.secondaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule_rounded,
                          size: 10.sp,
                          color: const Color(0xFFF8B64C),
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          item.duration.isEmpty ? '-' : item.duration,
                          style: TextStyle(
                            fontSize: 8.sp,
                            color: const Color(0xFFF8B64C),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                '\$ ${item.formattedPrice}',
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.secondaryColor,
                ),
              ),
              SizedBox(width: 2.w),
              Text(
                '/person',
                style: TextStyle(
                  fontSize: 8.sp,
                  color: isDark ? const Color(0xFF9FB0BD) : const Color(0xFF78909E),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Align(
            alignment: Alignment.center,
            child: _RemoveFavoriteButton(
              label: 'Remove from favorites',
              isLoading: isRemoving,
              onTap: onRemove,
            ),
          ),
        ],
      ),
    );
  }
}

class _SavedLandmarkCard extends StatelessWidget {
  final TouristLandmarkListItem item;
  final VoidCallback onRemove;
  final bool isRemoving;

  const _SavedLandmarkCard({
    required this.item,
    required this.onRemove,
    required this.isRemoving,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (item.normalizedImageUrl != null)
            Image.network(item.normalizedImageUrl!, fit: BoxFit.cover)
          else
            Container(
              color: const Color(0xFFE6EEF2),
              alignment: Alignment.center,
              child: Icon(
                Icons.image_outlined,
                size: 26.sp,
                color: AppColor.secondaryColor,
              ),
            ),
          Positioned(
            right: 6.w,
            top: 6.h,
            child: Icon(
              Icons.favorite_rounded,
              color: const Color(0xFFFF4D5B),
              size: 16.sp,
            ),
          ),
          Positioned(
            left: 6.w,
            right: 6.w,
            bottom: 6.h,
            child: Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: .45),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: AppColor.secondaryColor,
                        size: 10.sp,
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: Text(
                          item.city,
                          style: TextStyle(color: Colors.white, fontSize: 8.sp),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Align(
                    alignment: Alignment.center,
                    child: _RemoveFavoriteButton(
                      label: 'Remove',
                      isLoading: isRemoving,
                      onTap: onRemove,
                      compact: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TripsTab extends StatelessWidget {
  final bool isLoading;
  final String? errorMessage;
  final List<TouristPublicTrip> trips;
  final Set<int> removingIds;
  final ValueChanged<int> onRemove;
  final VoidCallback onRefresh;

  const _TripsTab({
    required this.isLoading,
    required this.errorMessage,
    required this.trips,
    required this.removingIds,
    required this.onRemove,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null && errorMessage!.trim().isNotEmpty) {
      return _EmptyState(
        message: errorMessage!,
        actionLabel: 'Retry',
        onTap: onRefresh,
      );
    }

    if (trips.isEmpty) {
      return _EmptyState(
        message: 'No saved trips yet.',
        actionLabel: 'Refresh',
        onTap: onRefresh,
      );
    }

    return ListView.separated(
      itemCount: trips.length,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (_, index) => _SavedTripCard(
        item: trips[index],
        isRemoving: removingIds.contains(trips[index].id),
        onRemove: () => onRemove(trips[index].id),
      ),
    );
  }
}

class _LandmarksTab extends StatelessWidget {
  final bool isLoading;
  final String? errorMessage;
  final List<TouristLandmarkListItem> landmarks;
  final Set<int> removingIds;
  final ValueChanged<int> onRemove;
  final VoidCallback onRefresh;

  const _LandmarksTab({
    required this.isLoading,
    required this.errorMessage,
    required this.landmarks,
    required this.removingIds,
    required this.onRemove,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null && errorMessage!.trim().isNotEmpty) {
      return _EmptyState(
        message: errorMessage!,
        actionLabel: 'Retry',
        onTap: onRefresh,
      );
    }

    if (landmarks.isEmpty) {
      return _EmptyState(
        message: 'No saved landmarks yet.',
        actionLabel: 'Refresh',
        onTap: onRefresh,
      );
    }

    return GridView.builder(
      itemCount: landmarks.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8.h,
        crossAxisSpacing: 8.w,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (_, index) => _SavedLandmarkCard(
        item: landmarks[index],
        isRemoving: removingIds.contains(landmarks[index].id),
        onRemove: () => onRemove(landmarks[index].id),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String message;
  final String actionLabel;
  final VoidCallback onTap;

  const _EmptyState({
    required this.message,
    required this.actionLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColor.secondaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          FilledButton(
            onPressed: onTap,
            style: FilledButton.styleFrom(
              backgroundColor: AppColor.secondaryColor,
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 6.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.r),
              ),
            ),
            child: Text(actionLabel, style: TextStyle(fontSize: 10.sp)),
          ),
        ],
      ),
    );
  }
}

class _RemoveFavoriteButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback onTap;
  final bool compact;

  const _RemoveFavoriteButton({
    required this.label,
    required this.isLoading,
    required this.onTap,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: compact ? 24.h : 28.h,
      child: FilledButton(
        onPressed: isLoading ? null : onTap,
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFFFFF1F3),
          foregroundColor: const Color(0xFFFF4D5B),
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 10.w : 14.w,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.r),
          ),
        ),
        child: Text(
          isLoading ? 'Removing...' : label,
          style: TextStyle(
            fontSize: compact ? 8.sp : 10.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.1,
          ),
        ),
      ),
    );
  }
}
