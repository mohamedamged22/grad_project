import 'package:bloc/bloc.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/repo/tourist_landmark_repo.dart';
import 'tourist_landmark_trips_state.dart';

class TouristLandmarkTripsCubit extends Cubit<TouristLandmarkTripsState> {
  final TouristLandmarkRepo _repo;

  TouristLandmarkTripsCubit(this._repo)
      : super(const TouristLandmarkTripsState());

  Future<void> fetchLandmarkTrips({
    required int landmarkId,
    int page = 0,
    int size = 10,
  }) async {
    emit(state.copyWith(status: TouristLandmarkTripsStatus.loading));

    try {
      final trips = await _repo.fetchLandmarkTrips(
        landmarkId: landmarkId,
        page: page,
        size: size,
      );
      emit(
        state.copyWith(
          status: TouristLandmarkTripsStatus.success,
          trips: trips,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: TouristLandmarkTripsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
