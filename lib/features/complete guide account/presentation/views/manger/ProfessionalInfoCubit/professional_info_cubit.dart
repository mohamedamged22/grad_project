import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/data/repo/complete_guide_account_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

part 'professional_info_state.dart';

class ProfessionalInfoCubit extends Cubit<ProfessionalInfoState> {
  ProfessionalInfoCubit(this._repo) : super(ProfessionalInfoInitial());
  final CompleteGuideAccountRepo _repo;

  GlobalKey<FormState> formKey = GlobalKey();

  // Controllers
  TextEditingController licenseController = TextEditingController();

  // ✅ Values - نفس القيم الافتراضية اللي في الـ View
  String selectedGuideType = 'LICENSED_GUIDE';
  int selectedExperience = 1;
  List<String> selectedSpecializations = [];

  // ✅ Map من الـ UI text للـ API value
  String mapGuideType(String uiType) {
    return uiType == 'Licensed Guide' ? 'LICENSED_GUIDE' : 'LOCAL_GUIDE';
  }

  int mapExperience(String uiExp) {
    switch (uiExp) {
      case '1 Year':
        return 1;
      case '2 Years':
        return 2;
      case '3 Years':
        return 3;
      case '4 Years':
        return 4;
      case '5 Years':
        return 5;
      case '5+ Years':
        return 6;
      case '10+ Years':
        return 10;
      default:
        return 1;
    }
  }

  Future<void> submitProfessionalInfo() async {
    emit(ProfessionalInfoLoading());
    try {
      final result = await _repo.updateProfessionalInfo(
        guideType: selectedGuideType,
        licensedNumber: licenseController.text.trim(),
        yearsOfExperience: selectedExperience,
        specialization: selectedSpecializations,
      );

      if (result['success'] == true) {
        emit(
          ProfessionalInfoSuccess(
            result['message'] ?? 'success_professional_info'.tr(),
          ),
        );
      } else {
        emit(ProfessionalInfoError('error_professional_info'.tr()));
      }
    } on ApiException catch (e) {
      emit(ProfessionalInfoError(e.message));
    } catch (e) {
      emit(ProfessionalInfoError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    licenseController.dispose();
    return super.close();
  }
}
