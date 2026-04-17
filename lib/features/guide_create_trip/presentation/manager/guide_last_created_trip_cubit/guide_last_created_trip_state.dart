part of 'guide_last_created_trip_cubit.dart';

enum GuideLastCreatedTripStatus { initial, loading, success, failure }

class GuideLastCreatedTripState {
  final GuideLastCreatedTripStatus status;
  final GuideLastCreatedTripModel? trip;
  final String? message;

  const GuideLastCreatedTripState({
    required this.status,
    this.trip,
    this.message,
  });

  factory GuideLastCreatedTripState.initial() {
    return const GuideLastCreatedTripState(
      status: GuideLastCreatedTripStatus.initial,
      trip: null,
      message: null,
    );
  }

  GuideLastCreatedTripState copyWith({
    GuideLastCreatedTripStatus? status,
    GuideLastCreatedTripModel? trip,
    String? message,
  }) {
    return GuideLastCreatedTripState(
      status: status ?? this.status,
      trip: trip ?? this.trip,
      message: message,
    );
  }
}
