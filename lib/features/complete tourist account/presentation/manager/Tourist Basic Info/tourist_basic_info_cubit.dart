import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/data/model/tourist_basic_info_model.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/data/repo/complete_tourist_account_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

part 'tourist_basic_info_state.dart';

class TouristBasicInfoCubit extends Cubit<TouristBasicInfoState> {
  TouristBasicInfoCubit(this._repo) : super(TouristBasicInfoInitial());
  final CompleteTouristAccountRepo _repo;

  // Form Key
  GlobalKey<FormState> formKey = GlobalKey();

  // Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  // Values
  String selectedGender = 'MALE';
  String? nationality;
  String? motherLanguage;
  List<String> knownLanguages = [];

  // ✅ Map UI لـ API
  String mapGender(String uiGender) => uiGender == 'Male' ? 'MALE' : 'FEMALE';
  Future<void> loadBasicInfo() async {
    try {
      final response = await _repo.getBasicInfo();
      if (response['success'] == true) {
        final data = response['data'];
        nameController.text = data['Username'] ?? data['name'] ?? '';
        emailController.text = data['email'] ?? '';
        emit(TouristBasicInfoLoaded());
      }
    } catch (e) {
      debugPrint('ℹ️ No existing data: $e');
    }
  }

  Future<void> submitBasicInfo() async {
    if (nationality == null) {
      emit(TouristBasicInfoError('val_select_nationality'.tr()));
      return;
    }
    if (motherLanguage == null) {
      emit(TouristBasicInfoError('val_select_mother_lang'.tr()));
      return;
    }
    if (knownLanguages.isEmpty) {
      emit(TouristBasicInfoError('val_select_one_lang'.tr()));
      return;
    }

    emit(TouristBasicInfoLoading());
    try {
      final model = TouristBasicInfoModel(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        type: selectedGender,
        nationality: nationality!,
        motherLanguage: motherLanguage!,
        languages: knownLanguages,
      );

      final result = await _repo.submitBasicInfo(model);

      if (result['success'] == true) {
        emit(
          TouristBasicInfoSuccess(
            result['message'] ?? 'success_basic_info'.tr(),
          ),
        );
      } else {
        emit(
          TouristBasicInfoError(result['message'] ?? 'error_basic_info'.tr()),
        );
      }
    } on ApiException catch (e) {
      emit(TouristBasicInfoError(e.message));
    } catch (e) {
      emit(TouristBasicInfoError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    return super.close();
  }
}
