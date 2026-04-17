import 'package:bloc/bloc.dart';

part 'guide_requests_state.dart';

class GuideRequestsCubit extends Cubit<GuideRequestsState> {
  GuideRequestsCubit() : super(const GuideRequestsState(selectedFilter: 'New'));

  void selectFilter(String filter) {
    emit(GuideRequestsState(selectedFilter: filter));
  }
}
