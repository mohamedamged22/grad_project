import 'package:bloc/bloc.dart';
import 'package:beyond_the_pramids/core/services/service_locator.dart';
import 'package:beyond_the_pramids/features/guide%20home/data/model/guide_booking_model.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/repo/tourist_booking_repo.dart';

part 'tourist_trip_history_state.dart';

class TouristTripHistoryCubit extends Cubit<TouristTripHistoryState> {
  final _repo = sl<TouristBookingRepo>();

  TouristTripHistoryCubit() : super(const TouristTripHistoryState()) {
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    emit(state.copyWith(status: TouristTripHistoryStatus.loading));
    try {
      final bookings = await _repo.getTouristBookings();
      emit(state.copyWith(
        status: TouristTripHistoryStatus.success,
        bookings: bookings,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TouristTripHistoryStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}