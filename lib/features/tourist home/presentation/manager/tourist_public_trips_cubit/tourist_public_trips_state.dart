part of 'tourist_public_trips_cubit.dart';

enum TouristPublicTripsStatus { initial, loading, success, failure }

class TouristPublicTripsState {
  final TouristPublicTripsStatus status;
  final List<TouristPublicTrip> trips;
  final String? errorMessage;

  const TouristPublicTripsState({
    this.status = TouristPublicTripsStatus.initial,
    this.trips = const [],
    this.errorMessage,
  });

  TouristPublicTripsState copyWith({
    TouristPublicTripsStatus? status,
    List<TouristPublicTrip>? trips,
    String? errorMessage,
  }) {
    return TouristPublicTripsState(
      status: status ?? this.status,
      trips: trips ?? this.trips,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
