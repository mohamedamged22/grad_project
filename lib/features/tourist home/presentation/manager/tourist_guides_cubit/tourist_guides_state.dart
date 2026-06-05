part of 'tourist_guides_cubit.dart';

enum TouristGuidesStatus { initial, loading, success, failure }

class TouristGuidesState {
  final TouristGuidesStatus status;
  final List<TourGuideProfile> guides;
  final String? errorMessage;

  const TouristGuidesState({
    this.status = TouristGuidesStatus.initial,
    this.guides = const [],
    this.errorMessage,
  });

  TouristGuidesState copyWith({
    TouristGuidesStatus? status,
    List<TourGuideProfile>? guides,
    String? errorMessage,
  }) {
    return TouristGuidesState(
      status: status ?? this.status,
      guides: guides ?? this.guides,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
