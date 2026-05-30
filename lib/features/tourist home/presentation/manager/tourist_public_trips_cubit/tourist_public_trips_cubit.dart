import 'package:beyond_the_pramids/features/tourist%20home/data/model/tourist_public_trip.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/repo/tourist_public_trips_repo.dart';
import 'package:bloc/bloc.dart';

part 'tourist_public_trips_state.dart';

class TouristPublicTripsCubit extends Cubit<TouristPublicTripsState> {
  TouristPublicTripsCubit(this._repo) : super(const TouristPublicTripsState());

  final TouristPublicTripsRepo _repo;

  Future<void> fetchTrips({int page = 0, int size = 10}) async {
    emit(state.copyWith(status: TouristPublicTripsStatus.loading));

    try {
      final trips = await _repo.fetchPublicTrips(page: page, size: size);
      emit(
        state.copyWith(
          status: TouristPublicTripsStatus.success,
          trips: trips,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: TouristPublicTripsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
