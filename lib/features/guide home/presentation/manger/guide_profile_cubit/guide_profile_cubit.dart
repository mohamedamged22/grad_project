import 'package:bloc/bloc.dart';
import 'package:beyond_the_pramids/core/services/theme_service.dart';

part 'guide_profile_state.dart';

class GuideProfileCubit extends Cubit<GuideProfileState> {
  GuideProfileCubit()
    : super(
        GuideProfileState(
          notificationEnabled: true,
          darkModeEnabled: ThemeService.isDark,
          faceIdEnabled: true,
        ),
      );

  void setNotificationEnabled(bool value) {
    emit(state.copyWith(notificationEnabled: value));
  }

  void toggleNotification() {
    emit(state.copyWith(notificationEnabled: !state.notificationEnabled));
  }

  void setDarkModeEnabled(bool value) {
    ThemeService.setDarkMode(value);
    emit(state.copyWith(darkModeEnabled: value));
  }

  void toggleDarkMode() {
    final nextValue = !state.darkModeEnabled;
    ThemeService.setDarkMode(nextValue);
    emit(state.copyWith(darkModeEnabled: nextValue));
  }

  void setFaceIdEnabled(bool value) {
    emit(state.copyWith(faceIdEnabled: value));
  }

  void toggleFaceId() {
    emit(state.copyWith(faceIdEnabled: !state.faceIdEnabled));
  }
}
