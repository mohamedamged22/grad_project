part of 'guide_create_new_trip_cubit.dart';

class GuideCreateNewTripState {
  final Set<String> selectedCategories;
  final String? selectedCity;

  const GuideCreateNewTripState({
    required this.selectedCategories,
    required this.selectedCity,
  });

  factory GuideCreateNewTripState.initial() {
    return const GuideCreateNewTripState(
      selectedCategories: {'Adventure', 'Cultural', 'Food Tour'},
      selectedCity: null,
    );
  }

  GuideCreateNewTripState copyWith({
    Set<String>? selectedCategories,
    String? selectedCity,
  }) {
    return GuideCreateNewTripState(
      selectedCategories: selectedCategories ?? this.selectedCategories,
      selectedCity: selectedCity ?? this.selectedCity,
    );
  }
}
