import 'package:beyond_the_pramids/features/tourist%20home/data/model/tourist_landmark_list_item.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/repo/tourist_landmark_repo.dart';
import 'package:bloc/bloc.dart';

part 'tourist_landmarks_state.dart';

class TouristLandmarksCubit extends Cubit<TouristLandmarksState> {
  TouristLandmarksCubit(this._repo) : super(const TouristLandmarksState());

  final TouristLandmarkRepo _repo;

  Future<void> fetchLandmarks({
    String? name,
    String? city,
    String? type,
  }) async {
    emit(state.copyWith(status: TouristLandmarksStatus.loading));

    try {
      final items = await _repo.fetchLandmarks(
        name: name,
        city: city,
        type: type,
      );
      emit(
        state.copyWith(
          status: TouristLandmarksStatus.success,
          landmarks: items,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: TouristLandmarksStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
