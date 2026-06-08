part of 'tourist_trip_history_cubit.dart';

enum TouristTripHistoryStatus { initial, loading, success, failure }

class TouristTripHistoryState {
  final TouristTripHistoryStatus status;
  final List<GuideBookingModel> bookings;
  final String? errorMessage;

  const TouristTripHistoryState({
    this.status = TouristTripHistoryStatus.initial,
    this.bookings = const [],
    this.errorMessage,
  });

  TouristTripHistoryState copyWith({
    TouristTripHistoryStatus? status,
    List<GuideBookingModel>? bookings,
    String? errorMessage,
  }) {
    return TouristTripHistoryState(
      status: status ?? this.status,
      bookings: bookings ?? this.bookings,
      errorMessage: errorMessage,
    );
  }

  int get pendingCount => bookings.where((b) => b.status == 'PENDING').length;
  int get acceptedCount => bookings.where((b) => b.status == 'ACCEPTED').length;
  int get rejectedCount => bookings.where((b) => b.status == 'REJECTED').length;
}