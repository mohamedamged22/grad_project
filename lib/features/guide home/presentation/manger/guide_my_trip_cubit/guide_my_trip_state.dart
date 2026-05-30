part of 'guide_my_trip_cubit.dart';

enum GuideMyTripStatus { initial, loading, success, failure }

enum MyTripFilter { newTrips, all, upcoming }

class GuideMyTripState {
  final GuideMyTripStatus status;
  final List<GuideTripSummaryModel> trips;
  final MyTripFilter filter;
  final bool showCreatedBanner;
  final String searchQuery;
  final String? errorMessage;

  const GuideMyTripState({
    this.status = GuideMyTripStatus.initial,
    this.trips = const [],
    this.filter = MyTripFilter.newTrips,
    this.showCreatedBanner = true,
    this.searchQuery = '',
    this.errorMessage,
  });

  GuideMyTripState copyWith({
    GuideMyTripStatus? status,
    List<GuideTripSummaryModel>? trips,
    MyTripFilter? filter,
    bool? showCreatedBanner,
    String? searchQuery,
    String? errorMessage,
  }) {
    return GuideMyTripState(
      status: status ?? this.status,
      trips: trips ?? this.trips,
      filter: filter ?? this.filter,
      showCreatedBanner: showCreatedBanner ?? this.showCreatedBanner,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
