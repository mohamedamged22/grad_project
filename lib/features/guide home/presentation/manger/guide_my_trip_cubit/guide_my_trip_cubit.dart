import 'package:beyond_the_pramids/features/guide%20home/data/repo/guide_my_trip_repo.dart';
import 'package:beyond_the_pramids/features/guide%20home/data/model/guide_trip_summary_model.dart';
import 'package:bloc/bloc.dart';

part 'guide_my_trip_state.dart';

class GuideMyTripCubit extends Cubit<GuideMyTripState> {
  GuideMyTripCubit(this._repo) : super(const GuideMyTripState());

  final GuideMyTripRepo _repo;

  void selectFilter(MyTripFilter filter) {
    emit(state.copyWith(filter: filter));
    loadTrips();
  }

  void dismissBanner() {
    emit(state.copyWith(showCreatedBanner: false));
  }

  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  Future<void> loadTrips() async {
    emit(state.copyWith(status: GuideMyTripStatus.loading, errorMessage: null));

    try {
      final statusKey = _mapFilterToStatusKey(state.filter);
      final trips = await _repo.fetchTrips(statusKey: statusKey);
      emit(
        state.copyWith(
          status: GuideMyTripStatus.success,
          trips: trips,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GuideMyTripStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  String? _mapFilterToStatusKey(MyTripFilter filter) {
    switch (filter) {
      case MyTripFilter.newTrips:
        return 'NEW';
      case MyTripFilter.upcoming:
        return 'UPCOMING';
      case MyTripFilter.all:
        return null;
    }
  }
}
