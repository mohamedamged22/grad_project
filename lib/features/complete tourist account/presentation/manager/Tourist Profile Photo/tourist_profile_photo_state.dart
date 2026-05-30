part of 'tourist_profile_photo_cubit.dart';

enum TouristProfilePhotoStatus { initial, loading, success, failure }

class TouristProfilePhotoState {
  final TouristProfilePhotoStatus status;
  final PlatformFile? selectedFile;
  final String? errorMessage;
  final String? successMessage;

  const TouristProfilePhotoState({
    this.status = TouristProfilePhotoStatus.initial,
    this.selectedFile,
    this.errorMessage,
    this.successMessage,
  });

  TouristProfilePhotoState copyWith({
    TouristProfilePhotoStatus? status,
    PlatformFile? selectedFile,
    String? errorMessage,
    String? successMessage,
  }) {
    return TouristProfilePhotoState(
      status: status ?? this.status,
      selectedFile: selectedFile ?? this.selectedFile,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }
}
