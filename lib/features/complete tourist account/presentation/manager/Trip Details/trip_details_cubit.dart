import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/data/model/tourist_travel_info_model.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/data/repo/complete_tourist_account_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

part 'trip_details_state.dart';

class TripDetailsCubit extends Cubit<TripDetailsState> {
  TripDetailsCubit(this._repo) : super(TripDetailsInitial());
  final CompleteTouristAccountRepo _repo;

  // Values
  DateTime? fromDate;
  DateTime? toDate;
  String? destinationCity;
  String? tripType;
  int numberOfTravelers = 1;

  Future<void> submitTravelInfo() async {
    if (fromDate == null || toDate == null) {
      emit(TripDetailsError('val_select_travel_dates'.tr()));
      return;
    }
    if (destinationCity == null) {
      emit(TripDetailsError('val_select_destination'.tr()));
      return;
    }
    if (tripType == null) {
      emit(TripDetailsError('val_select_trip_type'.tr()));
      return;
    }

    emit(TripDetailsLoading());
    try {
      final model = TouristTravelInfoModel(
        travelDateFrom: _formatDate(fromDate!),
        travelDateTo: _formatDate(toDate!),
        destinationCity: destinationCity!,
        tripType: tripType!,
        numberOfTravelers: numberOfTravelers,
      );

      debugPrint('📤 Travel Info: ${model.toJson()}');

      final result = await _repo.submitTravelInfo(model);

      if (result['success'] == true) {
        emit(
          TripDetailsSuccess(result['message'] ?? 'success_travel_info'.tr()),
        );
      } else {
        emit(TripDetailsError(result['message'] ?? 'error_travel_info'.tr()));
      }
    } on ApiException catch (e) {
      emit(TripDetailsError(e.message));
    } catch (e) {
      emit(TripDetailsError(e.toString()));
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
