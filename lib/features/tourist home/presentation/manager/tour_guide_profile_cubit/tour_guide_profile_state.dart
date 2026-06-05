part of 'tour_guide_profile_cubit.dart';

enum TourGuideProfileStatus { initial, loading, success, failure }
enum TourGuideTripsStatus { initial, loading, success, failure }

class TourGuideProfileState {
  final TourGuideProfileStatus status;
  final TourGuideProfile? guide;
  final TourGuideTripsStatus tripsStatus;
  final List<GuideTripSummaryModel> trips;
  final String? errorMessage;

  const TourGuideProfileState({
    this.status = TourGuideProfileStatus.initial,
    this.guide,
    this.tripsStatus = TourGuideTripsStatus.initial,
    this.trips = const [],
    this.errorMessage,
  });

  TourGuideProfileState copyWith({
    TourGuideProfileStatus? status,
    TourGuideProfile? guide,
    TourGuideTripsStatus? tripsStatus,
    List<GuideTripSummaryModel>? trips,
    String? errorMessage,
  }) {
    return TourGuideProfileState(
      status: status ?? this.status,
      guide: guide ?? this.guide,
      tripsStatus: tripsStatus ?? this.tripsStatus,
      trips: trips ?? this.trips,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
