part of 'guide_profile_cubit.dart';

class GuideProfileState {
  final bool notificationEnabled;
  final bool darkModeEnabled;
  final bool faceIdEnabled;

  const GuideProfileState({
    required this.notificationEnabled,
    required this.darkModeEnabled,
    required this.faceIdEnabled,
  });

  GuideProfileState copyWith({
    bool? notificationEnabled,
    bool? darkModeEnabled,
    bool? faceIdEnabled,
  }) {
    return GuideProfileState(
      notificationEnabled: notificationEnabled ?? this.notificationEnabled,
      darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
      faceIdEnabled: faceIdEnabled ?? this.faceIdEnabled,
    );
  }
}
