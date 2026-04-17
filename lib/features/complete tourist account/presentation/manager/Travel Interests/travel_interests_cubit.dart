import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/data/model/tourist_travel_interests_model.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/data/repo/complete_tourist_account_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

part 'travel_interests_state.dart';

class TravelInterestsCubit extends Cubit<TravelInterestsState> {
  TravelInterestsCubit(this._repo) : super(TravelInterestsInitial());
  final CompleteTouristAccountRepo _repo;

  // Selected interests
  List<String> selectedInterests = [];

  void toggleInterest(String interest) {
    if (selectedInterests.contains(interest)) {
      selectedInterests.remove(interest);
    } else {
      selectedInterests.add(interest);
    }
  }

  Future<void> submitTravelInterests() async {
    if (selectedInterests.isEmpty) {
      emit(TravelInterestsError('val_select_interest'.tr()));
      return;
    }

    emit(TravelInterestsLoading());
    try {
      final model = TouristTravelInterestsModel(
        travelInterests: selectedInterests,
      );

      debugPrint('📤 Travel Interests: ${model.toJson()}');

      final result = await _repo.submitTravelInterests(model);

      if (result['success'] == true) {
        emit(
          TravelInterestsSuccess(result['message'] ?? 'success_interests'.tr()),
        );
      } else {
        emit(TravelInterestsError(result['message'] ?? 'error_interests'.tr()));
      }
    } on ApiException catch (e) {
      emit(TravelInterestsError(e.message));
    } catch (e) {
      emit(TravelInterestsError(e.toString()));
    }
  }
}
