part of 'guide_create_trip_basic_cubit.dart';

enum GuideCreateTripBasicStatus { initial, loading, success, failure }

class GuideCreateTripBasicState {
  final Set<String> selectedCategories;
  final String? selectedCity;
  final Set<int> selectedLandmarkIds;
  final GuideCreateTripBasicStatus status;
  final String? message;

  const GuideCreateTripBasicState({
    required this.selectedCategories,
    required this.selectedCity,
    required this.selectedLandmarkIds,
    required this.status,
    this.message,
  });

  factory GuideCreateTripBasicState.initial() {
    return const GuideCreateTripBasicState(
      selectedCategories: {'Historical', 'Cultural'},
      selectedCity: null,
      selectedLandmarkIds: {},
      status: GuideCreateTripBasicStatus.initial,
      message: null,
    );
  }

  GuideCreateTripBasicState copyWith({
    Set<String>? selectedCategories,
    String? selectedCity,
    Set<int>? selectedLandmarkIds,
    GuideCreateTripBasicStatus? status,
    String? message,
  }) {
    return GuideCreateTripBasicState(
      selectedCategories: selectedCategories ?? this.selectedCategories,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedLandmarkIds: selectedLandmarkIds ?? this.selectedLandmarkIds,
      status: status ?? this.status,
      message: message,
    );
  }
}
