part of 'guide_create_new_trip_step2_cubit.dart';

class GuideCreateNewTripStep2State {
  final DateTimeRange? dateRange;
  final String? selectedDuration;
  final int maxGroupSize;
  final int minGroupSize;

  const GuideCreateNewTripStep2State({
    required this.dateRange,
    required this.selectedDuration,
    required this.maxGroupSize,
    required this.minGroupSize,
  });

  factory GuideCreateNewTripStep2State.initial() {
    return const GuideCreateNewTripStep2State(
      dateRange: null,
      selectedDuration: null,
      maxGroupSize: 20,
      minGroupSize: 5,
    );
  }

  GuideCreateNewTripStep2State copyWith({
    DateTimeRange? dateRange,
    String? selectedDuration,
    int? maxGroupSize,
    int? minGroupSize,
  }) {
    return GuideCreateNewTripStep2State(
      dateRange: dateRange ?? this.dateRange,
      selectedDuration: selectedDuration ?? this.selectedDuration,
      maxGroupSize: maxGroupSize ?? this.maxGroupSize,
      minGroupSize: minGroupSize ?? this.minGroupSize,
    );
  }
}
