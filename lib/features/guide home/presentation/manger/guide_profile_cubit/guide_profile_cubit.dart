import 'package:bloc/bloc.dart';
import 'package:beyond_the_pramids/core/navigation/navigation_service.dart';
import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/core/services/theme_service.dart';
import 'package:beyond_the_pramids/core/utils/pref_helper.dart';
import 'package:beyond_the_pramids/features/guide%20home/data/repo/guide_profile_repo.dart';

part 'guide_profile_state.dart';

class GuideProfileCubit extends Cubit<GuideProfileState> {
  GuideProfileCubit(this._guideProfileRepo)
    : super(
        GuideProfileState(
          notificationEnabled: true,
          darkModeEnabled: ThemeService.isDark,
          faceIdEnabled: true,
        ),
      );

  final GuideProfileRepo _guideProfileRepo;

  Future<void> fetchProfileDashboard() async {
    final cachedDashboard = await _guideProfileRepo.getCachedProfileDashboard();

    if (cachedDashboard != null) {
      emit(
        state.copyWith(
          status: GuideProfileStatus.success,
          guideName: cachedDashboard.guideName,
          guideLocation: cachedDashboard.guideLocation,
          profilePhotoUrl: cachedDashboard.profilePhoto ?? '',
          clearError: true,
        ),
      );
    } else {
      emit(
        state.copyWith(status: GuideProfileStatus.loading, clearError: true),
      );
    }

    try {
      final dashboard = await _guideProfileRepo.getProfileDashboard();
      emit(
        state.copyWith(
          status: GuideProfileStatus.success,
          guideName: dashboard.guideName,
          guideLocation: dashboard.guideLocation,
          profilePhotoUrl: dashboard.profilePhoto ?? '',
          clearError: true,
        ),
      );
    } on ApiException catch (e) {
      if (e.statusCode == 401 || e.statusCode == 403) {
        emit(
          state.copyWith(
            status: GuideProfileStatus.failure,
            errorMessage: e.message,
          ),
        );
        return;
      }

      if (cachedDashboard == null) {
        emit(
          state.copyWith(
            status: GuideProfileStatus.failure,
            errorMessage: e.message,
          ),
        );
      }
    } catch (e) {
      if (cachedDashboard == null) {
        emit(
          state.copyWith(
            status: GuideProfileStatus.failure,
            errorMessage: e.toString().replaceFirst('Exception: ', ''),
          ),
        );
      }
    }
  }

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

  Future<String> signOut() async {
    await PrefHelper.clearSession();
    NavigationService.redirectToSignIn();
    return 'Signed out successfully.';
  }

  Future<String> deleteAccount() async {
    final message = await _guideProfileRepo.deleteAccount();
    await PrefHelper.clearSession();
    NavigationService.redirectToSignIn();
    return _polishServerMessage(message);
  }

  String _polishServerMessage(String message) {
    final value = message.trim();
    if (value.isEmpty) {
      return 'Your account has been deactivated successfully.';
    }

    return value[0].toUpperCase() + value.substring(1);
  }
}
