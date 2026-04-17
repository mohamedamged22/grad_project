import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'guide_create_new_trip_state.dart';

class GuideCreateNewTripCubit extends Cubit<GuideCreateNewTripState> {
  GuideCreateNewTripCubit() : super(GuideCreateNewTripState.initial());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController tripTitleController = TextEditingController(
    text: 'Dahab Adventure',
  );
  final TextEditingController meetingPointController = TextEditingController(
    text: 'Marriott Mena House',
  );

  final List<String> categories = const [
    'Historical',
    'Adventure',
    'Cultural',
    'Food Tour',
    'Religious',
    'Desert Safari',
  ];

  final List<String> cities = const [
    'Cairo',
    'Giza',
    'Alexandria',
    'Luxor',
    'Aswan',
    'Dahab',
  ];

  void toggleCategory(String category) {
    final selected = Set<String>.from(state.selectedCategories);
    if (selected.contains(category)) {
      selected.remove(category);
    } else {
      selected.add(category);
    }
    emit(state.copyWith(selectedCategories: selected));
  }

  void selectCity(String? city) {
    emit(state.copyWith(selectedCity: city));
  }

  void setMeetingPoint(String value) {
    meetingPointController.text = value;
    emit(state.copyWith());
  }

  @override
  Future<void> close() {
    tripTitleController.dispose();
    meetingPointController.dispose();
    return super.close();
  }
}
