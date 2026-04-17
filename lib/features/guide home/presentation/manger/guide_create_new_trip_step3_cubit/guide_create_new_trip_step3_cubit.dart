import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'guide_create_new_trip_step3_state.dart';

class GuideCreateNewTripStep3Cubit extends Cubit<GuideCreateNewTripStep3State> {
  GuideCreateNewTripStep3Cubit()
    : super(GuideCreateNewTripStep3State.initial());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final List<String> priceOptions = const [
    '100\$ per/tourist',
    '150\$ per/tourist',
    '200\$ per/tourist',
    '250\$ per/tourist',
    '300\$ per/tourist',
  ];

  void selectPrice(String? price) {
    emit(state.copyWith(selectedPrice: price));
  }

  void setIncludedItem(String item, bool value) {
    final included = Map<String, bool>.from(state.includedItems);
    included[item] = value;
    emit(state.copyWith(includedItems: included));
  }
}
