import 'package:beyond_the_pramids/features/tourist%20home/data/model/tourist_landmark_details.dart';

enum TouristLandmarkDetailsStatus { initial, loading, success, failure }

class TouristLandmarkDetailsState {
  final TouristLandmarkDetailsStatus status;
  final TouristLandmarkDetails? details;
  final String? errorMessage;

  const TouristLandmarkDetailsState({
    this.status = TouristLandmarkDetailsStatus.initial,
    this.details,
    this.errorMessage,
  });

  TouristLandmarkDetailsState copyWith({
    TouristLandmarkDetailsStatus? status,
    TouristLandmarkDetails? details,
    String? errorMessage,
  }) {
    return TouristLandmarkDetailsState(
      status: status ?? this.status,
      details: details ?? this.details,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
