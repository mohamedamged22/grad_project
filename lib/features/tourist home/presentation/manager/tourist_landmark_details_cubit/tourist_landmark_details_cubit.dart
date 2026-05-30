import 'package:bloc/bloc.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/repo/tourist_landmark_repo.dart';
import 'tourist_landmark_details_state.dart';

class TouristLandmarkDetailsCubit extends Cubit<TouristLandmarkDetailsState> {
  final TouristLandmarkRepo _repo;

  TouristLandmarkDetailsCubit(this._repo)
      : super(const TouristLandmarkDetailsState());

  Future<void> fetchLandmarkDetails(int id) async {
    emit(state.copyWith(status: TouristLandmarkDetailsStatus.loading));

    try {
      final details = await _repo.fetchLandmarkDetails(id: id);
      emit(
        state.copyWith(
          status: TouristLandmarkDetailsStatus.success,
          details: details,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: TouristLandmarkDetailsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
