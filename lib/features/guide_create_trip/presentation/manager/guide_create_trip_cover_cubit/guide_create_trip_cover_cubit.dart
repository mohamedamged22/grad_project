import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/data/repo/guide_create_trip_repo.dart';
import 'package:bloc/bloc.dart';

part 'guide_create_trip_cover_state.dart';

class GuideCreateTripCoverCubit extends Cubit<GuideCreateTripCoverState> {
  GuideCreateTripCoverCubit(this._repo) : super(GuideCreateTripCoverState.initial());

  final GuideCreateTripRepo _repo;

  void setSelectedFilePath(String? path) {
    emit(
      state.copyWith(
        selectedFilePath: path,
        uploadedImagePath: null,
        status: GuideCreateTripCoverStatus.initial,
      ),
    );
  }

  Future<void> uploadCover() async {
    final path = state.selectedFilePath?.trim() ?? '';

    if (path.isEmpty) {
      emit(
        state.copyWith(
          status: GuideCreateTripCoverStatus.failure,
          message: 'Please select cover file first',
        ),
      );
      return;
    }

    final lowerPath = path.toLowerCase();
    final hasAllowedExtension =
        lowerPath.endsWith('.jpg') ||
        lowerPath.endsWith('.jpeg') ||
        lowerPath.endsWith('.png') ||
        lowerPath.endsWith('.webp') ||
        lowerPath.endsWith('.jfif');

    if (!hasAllowedExtension) {
      emit(
        state.copyWith(
          status: GuideCreateTripCoverStatus.failure,
          message: 'Invalid image format for cover upload',
        ),
      );
      return;
    }

    emit(state.copyWith(status: GuideCreateTripCoverStatus.loading, message: null));

    try {
      final result = await _repo.uploadTripCover(path);
      emit(
        state.copyWith(
          status: GuideCreateTripCoverStatus.success,
          message: result.message,
          uploadedImagePath: result.uploadedImagePath,
        ),
      );
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          status: GuideCreateTripCoverStatus.failure,
          message: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GuideCreateTripCoverStatus.failure,
          message: e.toString(),
        ),
      );
    }
  }
}
