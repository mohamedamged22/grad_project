import 'package:bloc/bloc.dart';
import 'package:beyond_the_pramids/features/guide%20home/data/model/guide_trip_summary_model.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/model/tour_guide_profile.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/repo/tour_guide_profiles_repo.dart';

part 'tour_guide_profile_state.dart';

class TourGuideProfileCubit extends Cubit<TourGuideProfileState> {
  TourGuideProfileCubit(this._repo) : super(const TourGuideProfileState());

  final TourGuideProfilesRepo _repo;

  Future<void> fetchProfile(int id) async {
    emit(state.copyWith(status: TourGuideProfileStatus.loading));

    try {
      final guide = await _repo.fetchProfileById(id);
      emit(
        state.copyWith(
          status: TourGuideProfileStatus.success,
          guide: guide,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: TourGuideProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> fetchGuideTrips({required int guideId, int page = 0, int size = 10}) async {
    emit(state.copyWith(tripsStatus: TourGuideTripsStatus.loading));

    try {
      final trips = await _repo.fetchGuideTrips(
        guideId: guideId,
        page: page,
        size: size,
      );
      emit(
        state.copyWith(
          tripsStatus: TourGuideTripsStatus.success,
          trips: trips,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          tripsStatus: TourGuideTripsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
