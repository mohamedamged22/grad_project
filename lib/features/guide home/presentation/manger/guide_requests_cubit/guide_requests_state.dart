part of 'guide_requests_cubit.dart';

enum GuideRequestsStatus { initial, loading, success, failure }
enum GuideRequestsActionStatus { initial, loading, success, failure }

class GuideRequestsState {
  final String selectedFilter;
  final GuideRequestsStatus status;
  final GuideRequestsActionStatus actionStatus;
  final List<GuideBookingModel> bookings;
  final String? errorMessage;

  const GuideRequestsState({
    this.selectedFilter = 'PENDING',
    this.status = GuideRequestsStatus.initial,
    this.actionStatus = GuideRequestsActionStatus.initial,
    this.bookings = const [],
    this.errorMessage,
  });

  GuideRequestsState copyWith({
    String? selectedFilter,
    GuideRequestsStatus? status,
    GuideRequestsActionStatus? actionStatus,
    List<GuideBookingModel>? bookings,
    String? errorMessage,
  }) {
    return GuideRequestsState(
      selectedFilter: selectedFilter ?? this.selectedFilter,
      status: status ?? this.status,
      actionStatus: actionStatus ?? this.actionStatus,
      bookings: bookings ?? this.bookings,
      errorMessage: errorMessage,
    );
  }
}
