import 'package:bloc/bloc.dart';

part 'guide_root_state.dart';

class GuideRootCubit extends Cubit<GuideRootState> {
  GuideRootCubit() : super(const GuideRootState(currentIndex: 0));

  void changeTab(int index) {
    emit(GuideRootState(currentIndex: index));
  }
}
