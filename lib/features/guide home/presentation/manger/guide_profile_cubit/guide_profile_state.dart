part of 'guide_profile_cubit.dart';

enum GuideProfileStatus { initial, loading, success, failure }

class GuideProfileState {
  final GuideProfileStatus status;
  final bool notificationEnabled;
  final bool darkModeEnabled;
  final bool faceIdEnabled;
  final String guideName;
  final String guideLocation;
  final String profilePhotoUrl;
  final String? errorMessage;

  const GuideProfileState({
    this.status = GuideProfileStatus.initial,
    required this.notificationEnabled,
    required this.darkModeEnabled,
    required this.faceIdEnabled,
    this.guideName = '',
    this.guideLocation = '',
    this.profilePhotoUrl = '',
    this.errorMessage,
  });

  GuideProfileState copyWith({
    GuideProfileStatus? status,
    bool? notificationEnabled,
    bool? darkModeEnabled,
    bool? faceIdEnabled,
    String? guideName,
    String? guideLocation,
    String? profilePhotoUrl,
    String? errorMessage,
    bool clearError = false,
  }) {
    return GuideProfileState(
      status: status ?? this.status,
      notificationEnabled: notificationEnabled ?? this.notificationEnabled,
      darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
      faceIdEnabled: faceIdEnabled ?? this.faceIdEnabled,
      guideName: guideName ?? this.guideName,
      guideLocation: guideLocation ?? this.guideLocation,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
