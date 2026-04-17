import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/data/model/tourist_preferences_model.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/data/repo/complete_tourist_account_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

part 'tourist_preferences_state.dart';

class TouristPreferencesCubit extends Cubit<TouristPreferencesState> {
  TouristPreferencesCubit(this._repo) : super(TouristPreferencesInitial());
  final CompleteTouristAccountRepo _repo;

  // Controllers
  TextEditingController foodAllergiesController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  // Values
  String? specialNeeds;
  List<String> travelPreferences = [];
  String? foodPreference;

  // Map UI values to API values
  String _mapSpecialNeeds(String uiValue) {
    switch (uiValue) {
      case 'Mobility restrictions':
        return 'MOBILITY_ASSISTANCE';
      case 'Visual / hearing support':
        return 'VISUAL_HEARING_SUPPORT';
      case 'Intellectual/invisible/chronic':
        return 'INTELLECTUAL_CHRONIC';
      default:
        return uiValue.toUpperCase().replaceAll(' ', '_');
    }
  }

  String _mapFoodPreference(String uiValue) {
    switch (uiValue) {
      case 'Vegetarian':
        return 'VEGETARIAN';
      case 'Vegen':
        return 'VEGAN';
      case 'Halal':
        return 'HALAL';
      case 'Food allergies':
        return 'FOOD_ALLERGIES';
      default:
        return uiValue.toUpperCase().replaceAll(' ', '_');
    }
  }

  Future<void> submitPreferences() async {
    if (specialNeeds == null) {
      emit(TouristPreferencesError('val_select_special_needs'.tr()));
      return;
    }
    if (travelPreferences.isEmpty) {
      emit(TouristPreferencesError('val_select_travel_pref'.tr()));
      return;
    }
    if (foodPreference == null) {
      emit(TouristPreferencesError('val_select_food_pref'.tr()));
      return;
    }

    emit(TouristPreferencesLoading());
    try {
      final model = TouristPreferencesModel(
        specialNeeds: _mapSpecialNeeds(specialNeeds!),
        travelPreferences: travelPreferences,
        foodPreference: _mapFoodPreference(foodPreference!),
        foodAllergies: foodAllergiesController.text.trim(),
        notes: notesController.text.trim(),
      );

      debugPrint('📤 Preferences: ${model.toJson()}');

      final result = await _repo.submitPreferences(model);

      if (result['success'] == true) {
        emit(
          TouristPreferencesSuccess(
            result['message'] ?? 'success_preferences'.tr(),
          ),
        );
      } else {
        emit(
          TouristPreferencesError(
            result['message'] ?? 'error_preferences'.tr(),
          ),
        );
      }
    } on ApiException catch (e) {
      emit(TouristPreferencesError(e.message));
    } catch (e) {
      emit(TouristPreferencesError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    foodAllergiesController.dispose();
    notesController.dispose();
    return super.close();
  }
}
