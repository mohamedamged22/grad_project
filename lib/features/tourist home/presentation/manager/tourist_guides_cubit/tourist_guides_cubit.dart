import 'package:beyond_the_pramids/features/tourist%20home/data/model/tour_guide_profile.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/repo/tour_guide_profiles_repo.dart';
import 'package:bloc/bloc.dart';

part 'tourist_guides_state.dart';

class TouristGuidesCubit extends Cubit<TouristGuidesState> {
  TouristGuidesCubit(this._repo) : super(const TouristGuidesState());

  final TourGuideProfilesRepo _repo;

  Future<void> fetchGuides({int page = 0, int size = 10}) async {
    emit(state.copyWith(status: TouristGuidesStatus.loading));

    try {
      final guides = await _repo.fetchProfiles(page: page, size: size);
      emit(
        state.copyWith(
          status: TouristGuidesStatus.success,
          guides: guides,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: TouristGuidesStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
