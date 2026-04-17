import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/data/repo/complete_guide_account_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';

part 'pricing_state.dart';

class PricingCubit extends Cubit<PricingState> {
  PricingCubit(this._repo) : super(PricingInitial());
  final CompleteGuideAccountRepo _repo;

  // Values
  String selectedTourType = 'GROUP';
  List<String> selectedAreas = []; // ✅ multi-select
  int? selectedDuration;

  // ✅ Map UI text للـ API value
  String mapTourType(String uiType) {
    return uiType == 'Group Tour' ? 'GROUP' : 'PRIVATE';
  }

  int mapDuration(String uiDuration) {
    switch (uiDuration) {
      case '1 - 2 Hours':
        return 2;
      case '3 - 4 Hours':
        return 4;
      case '6 - 8 Hours':
        return 8;
      case '10 - 12 Hours':
        return 12;
      case 'Flexible':
        return 0;
      default:
        return 2;
    }
  }

  Future<void> submitPricing() async {
    // ✅ Validation
    if (selectedAreas.isEmpty) {
      emit(PricingError('val_select_area'.tr()));
      return;
    }
    if (selectedDuration == null) {
      emit(PricingError('val_select_duration'.tr()));
      return;
    }

    emit(PricingLoading());
    try {
      final result = await _repo.updatePricing(
        tourType: selectedTourType,
        coveredAreas: selectedAreas,
        tourDuration: selectedDuration!,
      );

      if (result['success'] == true) {
        emit(PricingSuccess(result['message'] ?? 'success_pricing'.tr()));
      } else {
        emit(PricingError('error_pricing'.tr()));
      }
    } on ApiException catch (e) {
      emit(PricingError(e.message));
    } catch (e) {
      emit(PricingError(e.toString()));
    }
  }
}
