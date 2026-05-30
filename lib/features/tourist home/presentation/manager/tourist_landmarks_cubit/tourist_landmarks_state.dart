part of 'tourist_landmarks_cubit.dart';

enum TouristLandmarksStatus { initial, loading, success, failure }

class TouristLandmarksState {
  final TouristLandmarksStatus status;
  final List<TouristLandmarkListItem> landmarks;
  final String? errorMessage;

  const TouristLandmarksState({
    this.status = TouristLandmarksStatus.initial,
    this.landmarks = const [],
    this.errorMessage,
  });

  TouristLandmarksState copyWith({
    TouristLandmarksStatus? status,
    List<TouristLandmarkListItem>? landmarks,
    String? errorMessage,
  }) {
    return TouristLandmarksState(
      status: status ?? this.status,
      landmarks: landmarks ?? this.landmarks,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
