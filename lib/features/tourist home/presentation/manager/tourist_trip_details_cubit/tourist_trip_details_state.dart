part of 'tourist_trip_details_cubit.dart';

enum TouristTripDetailsStatus { initial, loading, success, failure }

class TouristTripDetailsState {
  final TouristTripDetailsStatus status;
  final TouristTripDetails? details;
  final String? errorMessage;

  const TouristTripDetailsState({
    this.status = TouristTripDetailsStatus.initial,
    this.details,
    this.errorMessage,
  });

  TouristTripDetailsState copyWith({
    TouristTripDetailsStatus? status,
    TouristTripDetails? details,
    String? errorMessage,
  }) {
    return TouristTripDetailsState(
      status: status ?? this.status,
      details: details ?? this.details,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
