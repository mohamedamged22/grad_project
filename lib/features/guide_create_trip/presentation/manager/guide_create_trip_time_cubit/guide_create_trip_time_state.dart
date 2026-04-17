part of 'guide_create_trip_time_cubit.dart';

enum GuideCreateTripTimeStatus { initial, loading, success, failure }

class GuideCreateTripTimeState {
  final DateTimeRange? dateRange;
  final String? selectedDuration;
  final int maxGroupSize;
  final int minGroupSize;
  final GuideCreateTripTimeStatus status;
  final String? message;

  const GuideCreateTripTimeState({
    required this.dateRange,
    required this.selectedDuration,
    required this.maxGroupSize,
    required this.minGroupSize,
    required this.status,
    this.message,
  });

  factory GuideCreateTripTimeState.initial() {
    return const GuideCreateTripTimeState(
      dateRange: null,
      selectedDuration: null,
      maxGroupSize: 12,
      minGroupSize: 4,
      status: GuideCreateTripTimeStatus.initial,
      message: null,
    );
  }

  GuideCreateTripTimeState copyWith({
    DateTimeRange? dateRange,
    String? selectedDuration,
    int? maxGroupSize,
    int? minGroupSize,
    GuideCreateTripTimeStatus? status,
    String? message,
  }) {
    return GuideCreateTripTimeState(
      dateRange: dateRange ?? this.dateRange,
      selectedDuration: selectedDuration ?? this.selectedDuration,
      maxGroupSize: maxGroupSize ?? this.maxGroupSize,
      minGroupSize: minGroupSize ?? this.minGroupSize,
      status: status ?? this.status,
      message: message,
    );
  }
}
