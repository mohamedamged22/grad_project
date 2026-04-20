part of 'profile_personal_information_cubit.dart';

enum ProfilePersonalInformationStatus { initial, submitting, success, failure }

class ProfilePersonalInformationState {
  final ProfilePersonalInformationStatus status;
  final String? errorMessage;
  final String? successMessage;
  final String profilePhotoUrl;
  final String title;

  const ProfilePersonalInformationState({
    this.status = ProfilePersonalInformationStatus.initial,
    this.errorMessage,
    this.successMessage,
    this.profilePhotoUrl = '',
    this.title = 'Licensed Guide',
  });

  ProfilePersonalInformationState copyWith({
    ProfilePersonalInformationStatus? status,
    String? errorMessage,
    String? successMessage,
    String? profilePhotoUrl,
    String? title,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return ProfilePersonalInformationState(
      status: status ?? this.status,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      successMessage:
          clearSuccess ? null : (successMessage ?? this.successMessage),
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      title: title ?? this.title,
    );
  }
}
