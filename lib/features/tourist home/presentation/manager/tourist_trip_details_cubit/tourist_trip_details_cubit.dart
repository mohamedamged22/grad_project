import 'package:beyond_the_pramids/features/tourist%20home/data/model/tourist_trip_details.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/repo/tourist_trip_details_repo.dart';
import 'package:bloc/bloc.dart';

part 'tourist_trip_details_state.dart';

class TouristTripDetailsCubit extends Cubit<TouristTripDetailsState> {
  TouristTripDetailsCubit(this._repo)
      : super(const TouristTripDetailsState());

  final TouristTripDetailsRepo _repo;

  Future<void> fetchTripDetails({required int tripId}) async {
    emit(state.copyWith(status: TouristTripDetailsStatus.loading));

    try {
      final details = await _repo.fetchTripDetails(tripId: tripId);
      emit(
        state.copyWith(
          status: TouristTripDetailsStatus.success,
          details: details,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: TouristTripDetailsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
