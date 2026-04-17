part of 'guide_my_trip_cubit.dart';

enum MyTripFilter { newTrips, all, upcoming }

class GuideMyTripState {
  final MyTripFilter filter;
  final bool showCreatedBanner;
  final String searchQuery;

  const GuideMyTripState({
    this.filter = MyTripFilter.newTrips,
    this.showCreatedBanner = true,
    this.searchQuery = '',
  });

  GuideMyTripState copyWith({
    MyTripFilter? filter,
    bool? showCreatedBanner,
    String? searchQuery,
  }) {
    return GuideMyTripState(
      filter: filter ?? this.filter,
      showCreatedBanner: showCreatedBanner ?? this.showCreatedBanner,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
