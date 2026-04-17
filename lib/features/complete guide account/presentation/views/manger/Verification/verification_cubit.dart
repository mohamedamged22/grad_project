import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/data/repo/complete_guide_account_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';

part 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit(this._repo) : super(VerificationInitial());
  final CompleteGuideAccountRepo _repo;

  PlatformFile? idFile;
  PlatformFile? licenseFile;
  PlatformFile? photoFile;

  Future<void> submitAll() async {
    // ✅ Validate
    if (idFile == null || licenseFile == null || photoFile == null) {
      emit(VerificationError('val_upload_documents'.tr()));
      return;
    }

    if (idFile!.path == null ||
        licenseFile!.path == null ||
        photoFile!.path == null) {
      emit(VerificationError('val_file_path_error'.tr()));
      return;
    }

    emit(VerificationLoading());

    try {
      // ✅ بعت الـ 3 files واحدة واحدة
      final idResult = await _repo.uploadId(filePath: idFile!.path!);
      if (idResult['success'] != true) {
        emit(VerificationError(idResult['message'] ?? 'error_upload_id'.tr()));
        return;
      }

      final licenseResult = await _repo.uploadLicense(
        filePath: licenseFile!.path!,
      );
      if (licenseResult['success'] != true) {
        emit(
          VerificationError(
            licenseResult['message'] ?? 'error_upload_license'.tr(),
          ),
        );
        return;
      }

      final photoResult = await _repo.uploadPhoto(filePath: photoFile!.path!);
      if (photoResult['success'] != true) {
        emit(
          VerificationError(
            photoResult['message'] ?? 'error_upload_photo'.tr(),
          ),
        );
        return;
      }

      emit(VerificationSuccess('success_documents'.tr()));
    } on ApiException catch (e) {
      emit(VerificationError(e.message));
    } catch (e) {
      emit(VerificationError(e.toString()));
    }
  }
}
