import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/data/models/guide_create_trip_basic_request_model.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/data/repo/guide_create_trip_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'guide_create_trip_basic_state.dart';

class GuideCreateTripBasicCubit extends Cubit<GuideCreateTripBasicState> {
  GuideCreateTripBasicCubit(this._repo) : super(GuideCreateTripBasicState.initial());

  final GuideCreateTripRepo _repo;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController tripTitleController = TextEditingController();
  final TextEditingController meetingPointController = TextEditingController();

  final List<String> categories = const [
    'Historical',
    'Cultural',
    'Adventure',
    'Food Tour',
    'Religious',
    'Desert Safari',
  ];

  final List<String> cities = const [
    '6th of October',
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
    emit(state.copyWith(selectedCategories: selected, status: GuideCreateTripBasicStatus.initial));
  }

  void selectCity(String? city) {
    emit(state.copyWith(selectedCity: city, status: GuideCreateTripBasicStatus.initial));
  }

  void setMeetingPoint(String value) {
    meetingPointController.text = value;
    emit(state.copyWith(status: GuideCreateTripBasicStatus.initial));
  }

  Future<void> submitBasicTrip() async {
    final title = tripTitleController.text.trim();
    final meetingPoint = meetingPointController.text.trim();

    if (title.isEmpty) {
      emit(
        state.copyWith(
          status: GuideCreateTripBasicStatus.failure,
          message: 'Trip title is required',
        ),
      );
      return;
    }

    if (title.length < 3) {
      emit(
        state.copyWith(
          status: GuideCreateTripBasicStatus.failure,
          message: 'Trip title must be at least 3 characters',
        ),
      );
      return;
    }

    if (meetingPoint.isEmpty) {
      emit(
        state.copyWith(
          status: GuideCreateTripBasicStatus.failure,
          message: 'Meeting point is required',
        ),
      );
      return;
    }

    if (state.selectedCategories.isEmpty) {
      emit(
        state.copyWith(
          status: GuideCreateTripBasicStatus.failure,
          message: 'Please select at least one category',
        ),
      );
      return;
    }

    if (state.selectedCity == null || state.selectedCity!.trim().isEmpty) {
      emit(
        state.copyWith(
          status: GuideCreateTripBasicStatus.failure,
          message: 'Please select city',
        ),
      );
      return;
    }

    emit(state.copyWith(status: GuideCreateTripBasicStatus.loading, message: null));

    try {
      final message = await _repo.createBasicTrip(
        GuideCreateTripBasicRequestModel(
          title: title,
          category: state.selectedCategories.toList(),
          city: state.selectedCity!.trim(),
          meetingPoint: meetingPoint,
        ),
      );

      emit(
        state.copyWith(
          status: GuideCreateTripBasicStatus.success,
          message: message,
        ),
      );
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          status: GuideCreateTripBasicStatus.failure,
          message: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GuideCreateTripBasicStatus.failure,
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    tripTitleController.dispose();
    meetingPointController.dispose();
    return super.close();
  }
}
