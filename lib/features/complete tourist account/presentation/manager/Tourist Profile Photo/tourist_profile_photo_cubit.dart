import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/data/repo/complete_tourist_account_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';

part 'tourist_profile_photo_state.dart';

class TouristProfilePhotoCubit extends Cubit<TouristProfilePhotoState> {
  TouristProfilePhotoCubit(this._repo)
      : super(const TouristProfilePhotoState());

  final CompleteTouristAccountRepo _repo;

  void setSelectedFile(PlatformFile file) {
    emit(state.copyWith(selectedFile: file, status: TouristProfilePhotoStatus.initial));
  }

  Future<void> submitPhoto() async {
    final file = state.selectedFile;
    if (file == null || file.path == null || file.path!.trim().isEmpty) {
      emit(
        state.copyWith(
          status: TouristProfilePhotoStatus.failure,
          errorMessage: 'Please select a profile photo',
        ),
      );
      return;
    }

    emit(state.copyWith(status: TouristProfilePhotoStatus.loading, errorMessage: null));

    try {
      final response = await _repo.uploadProfilePhoto(file.path!);
      final message = response['message']?.toString() ?? 'Profile photo uploaded';
      emit(
        state.copyWith(
          status: TouristProfilePhotoStatus.success,
          successMessage: message,
        ),
      );
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          status: TouristProfilePhotoStatus.failure,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: TouristProfilePhotoStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
