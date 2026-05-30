import 'package:beyond_the_pramids/features/tourist%20home/data/model/tourist_landmark_trip.dart';

enum TouristLandmarkTripsStatus { initial, loading, success, failure }

class TouristLandmarkTripsState {
  final TouristLandmarkTripsStatus status;
  final List<TouristLandmarkTrip> trips;
  final String? errorMessage;

  const TouristLandmarkTripsState({
    this.status = TouristLandmarkTripsStatus.initial,
    this.trips = const [],
    this.errorMessage,
  });

  TouristLandmarkTripsState copyWith({
    TouristLandmarkTripsStatus? status,
    List<TouristLandmarkTrip>? trips,
    String? errorMessage,
  }) {
    return TouristLandmarkTripsState(
      status: status ?? this.status,
      trips: trips ?? this.trips,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
