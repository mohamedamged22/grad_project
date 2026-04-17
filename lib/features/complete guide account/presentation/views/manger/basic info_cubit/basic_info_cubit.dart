import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/data/models/basicInfo_model.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/data/repo/complete_guide_account_repo.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

part 'basic_info_state.dart';

class BasicInfoCubit extends Cubit<BasicInfoState> {
  BasicInfoCubit(this._basicInfoRepo) : super(BasicInfoInitial());
  final CompleteGuideAccountRepo _basicInfoRepo;

  // Form Key
  GlobalKey<FormState> basicInfoFormKey = GlobalKey();

  // Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? selectedCity;

  /// ----------------------------
  /// LOAD BASIC INFO (Optional - only for edit mode)
  /// ----------------------------
  Future<void> loadBasicInfo() async {
    emit(BasicInfoLoading());
    try {
      final basicInfo = await _basicInfoRepo.getBasicInfo();

      if (basicInfo != null) {
        // Fill controllers with existing data
        nameController.text = basicInfo.name;
        emailController.text = basicInfo.email;
        phoneController.text = basicInfo.phone;
        selectedCity = basicInfo.city;

        emit(BasicInfoLoaded(basicInfo));
        debugPrint('✅ Basic info loaded');
      } else {
        // ⭐ No data found - this is OK for first-time users
        emit(BasicInfoInitial());
        debugPrint('ℹ️ No basic info found (first time user)');
      }
    } on ApiException catch (e) {
      // ⭐ Don't emit error if it's just "no data found"
      if (e.message.toLowerCase().contains('not found') ||
          e.message.toLowerCase().contains('no data')) {
        emit(BasicInfoInitial());
        debugPrint('ℹ️ No existing data');
      } else {
        emit(BasicInfoError(e.message));
        debugPrint('❌ Load error: ${e.message}');
      }
    } catch (e) {
      // ⭐ Silent fail for first-time users
      emit(BasicInfoInitial());
      debugPrint('ℹ️ No data to load: $e');
    }
  }

  /// ----------------------------
  /// SUBMIT/UPDATE BASIC INFO
  /// ----------------------------
  Future<void> submitBasicInfo() async {
    emit(BasicInfoLoading());
    try {
      debugPrint('📤 Submitting basic info...');
      debugPrint('Name: ${nameController.text}');
      debugPrint('Email: ${emailController.text}');
      debugPrint('Phone: ${phoneController.text}');
      debugPrint('City: $selectedCity');

      final result = await _basicInfoRepo.updateBasicInfo(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        city: selectedCity ?? '',
      );

      if (result['success'] == true) {
        emit(BasicInfoSuccess(result['message'] ?? 'success_basic_info'.tr()));
        debugPrint('✅ Basic info submitted successfully');
      } else {
        emit(BasicInfoError('error_basic_info'.tr()));
      }
    } on ApiException catch (e) {
      emit(BasicInfoError(e.message));
      debugPrint('❌ Submit error: ${e.message}');
    } catch (e) {
      emit(BasicInfoError(e.toString()));
      debugPrint('❌ Unexpected error: $e');
    }
  }

  /// ----------------------------
  /// CLEAR DATA
  /// ----------------------------
  void clearData() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    selectedCity = null;
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    return super.close();
  }
}
