import 'package:bloc/bloc.dart';

part 'guide_my_trip_state.dart';

class GuideMyTripCubit extends Cubit<GuideMyTripState> {
  GuideMyTripCubit() : super(const GuideMyTripState());

  void selectFilter(MyTripFilter filter) {
    emit(state.copyWith(filter: filter));
  }

  void dismissBanner() {
    emit(state.copyWith(showCreatedBanner: false));
  }

  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }
}
