import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/data/models/guide_create_trip_price_request_model.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/data/repo/guide_create_trip_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'guide_create_trip_price_state.dart';

class GuideCreateTripPriceCubit extends Cubit<GuideCreateTripPriceState> {
  GuideCreateTripPriceCubit(this._repo) : super(GuideCreateTripPriceState.initial());

  final GuideCreateTripRepo _repo;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final List<String> priceOptions = const [
    '100.00',
    '120.00',
    '150.50',
    '200.00',
    '250.00',
  ];

  void selectPrice(String? price) {
    emit(state.copyWith(selectedPrice: price, status: GuideCreateTripPriceStatus.initial));
  }

  void setIncludedItem(String item, bool value) {
    final included = Map<String, bool>.from(state.includedItems);
    included[item] = value;
    emit(state.copyWith(includedItems: included, status: GuideCreateTripPriceStatus.initial));
  }

  Future<void> submitTripPrice() async {
    if (state.selectedPrice == null || state.selectedPrice!.trim().isEmpty) {
      emit(
        state.copyWith(
          status: GuideCreateTripPriceStatus.failure,
          message: 'Please select price per tourist',
        ),
      );
      return;
    }

    final priceValue = double.tryParse(state.selectedPrice!.trim());
    if (priceValue == null || priceValue <= 0) {
      emit(
        state.copyWith(
          status: GuideCreateTripPriceStatus.failure,
          message: 'Price per tourist must be a valid number greater than 0',
        ),
      );
      return;
    }

    final selectedInclusions = state.includedItems.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    if (selectedInclusions.isEmpty) {
      emit(
        state.copyWith(
          status: GuideCreateTripPriceStatus.failure,
          message: 'Please select at least one inclusion',
        ),
      );
      return;
    }

    emit(state.copyWith(status: GuideCreateTripPriceStatus.loading, message: null));

    try {
      final message = await _repo.createTripPrice(
        GuideCreateTripPriceRequestModel(
          pricePerTourist: priceValue,
          inclusions: selectedInclusions,
        ),
      );

      emit(
        state.copyWith(
          status: GuideCreateTripPriceStatus.success,
          message: message,
        ),
      );
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          status: GuideCreateTripPriceStatus.failure,
          message: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GuideCreateTripPriceStatus.failure,
          message: e.toString(),
        ),
      );
    }
  }
}
