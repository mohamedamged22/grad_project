import 'package:bloc/bloc.dart';
import 'package:beyond_the_pramids/core/services/service_locator.dart';
import 'package:beyond_the_pramids/features/guide%20home/data/model/guide_booking_model.dart';
import 'package:beyond_the_pramids/features/guide%20home/data/repo/guide_bookings_repo.dart';

part 'guide_requests_state.dart';

class GuideRequestsCubit extends Cubit<GuideRequestsState> {
  final _repo = sl<GuideBookingsRepo>();

  GuideRequestsCubit() : super(const GuideRequestsState()) {
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    emit(state.copyWith(status: GuideRequestsStatus.loading));
    try {
      final bookings = await _repo.getBookings(
        status: state.selectedFilter,
      );
      emit(state.copyWith(
        status: GuideRequestsStatus.success,
        bookings: bookings,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GuideRequestsStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> selectFilter(String filter) async {
    emit(state.copyWith(selectedFilter: filter));
    await fetchBookings();
  }

  Future<void> acceptBooking(int bookingId) async {
    emit(state.copyWith(actionStatus: GuideRequestsActionStatus.loading));
    try {
      await _repo.acceptBooking(bookingId: bookingId);
      final updatedBookings = state.bookings
          .where((b) => b.id != bookingId)
          .toList();
      emit(state.copyWith(
        actionStatus: GuideRequestsActionStatus.success,
        bookings: updatedBookings,
      ));
    } catch (e) {
      emit(state.copyWith(
        actionStatus: GuideRequestsActionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> rejectBooking(int bookingId) async {
    emit(state.copyWith(actionStatus: GuideRequestsActionStatus.loading));
    try {
      await _repo.rejectBooking(bookingId: bookingId);
      final updatedBookings = state.bookings
          .where((b) => b.id != bookingId)
          .toList();
      emit(state.copyWith(
        actionStatus: GuideRequestsActionStatus.success,
        bookings: updatedBookings,
      ));
    } catch (e) {
      emit(state.copyWith(
        actionStatus: GuideRequestsActionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
