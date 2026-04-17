part of 'guide_create_trip_cover_cubit.dart';

enum GuideCreateTripCoverStatus { initial, loading, success, failure }

class GuideCreateTripCoverState {
  final String? selectedFilePath;
  final String? uploadedImagePath;
  final GuideCreateTripCoverStatus status;
  final String? message;

  const GuideCreateTripCoverState({
    required this.selectedFilePath,
    required this.uploadedImagePath,
    required this.status,
    this.message,
  });

  factory GuideCreateTripCoverState.initial() {
    return const GuideCreateTripCoverState(
      selectedFilePath: null,
      uploadedImagePath: null,
      status: GuideCreateTripCoverStatus.initial,
      message: null,
    );
  }

  GuideCreateTripCoverState copyWith({
    String? selectedFilePath,
    String? uploadedImagePath,
    GuideCreateTripCoverStatus? status,
    String? message,
  }) {
    return GuideCreateTripCoverState(
      selectedFilePath: selectedFilePath ?? this.selectedFilePath,
      uploadedImagePath: uploadedImagePath ?? this.uploadedImagePath,
      status: status ?? this.status,
      message: message,
    );
  }
}
