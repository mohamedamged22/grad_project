import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'guide_create_new_trip_step2_state.dart';

class GuideCreateNewTripStep2Cubit extends Cubit<GuideCreateNewTripStep2State> {
  GuideCreateNewTripStep2Cubit()
    : super(GuideCreateNewTripStep2State.initial());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();

  final List<String> durations = const [
    '1 Day',
    '2 Days',
    '3 Days',
    '4 Days',
    '5 Days',
    '7 Days',
  ];

  void setDateRange(DateTime from, DateTime to) {
    emit(state.copyWith(dateRange: DateTimeRange(start: from, end: to)));
  }

  void selectDuration(String? duration) {
    emit(state.copyWith(selectedDuration: duration));
  }

  void increaseMax() {
    emit(state.copyWith(maxGroupSize: state.maxGroupSize + 1));
  }

  void decreaseMax() {
    if (state.maxGroupSize > 1) {
      emit(state.copyWith(maxGroupSize: state.maxGroupSize - 1));
    }
  }

  void increaseMin() {
    emit(state.copyWith(minGroupSize: state.minGroupSize + 1));
  }

  void decreaseMin() {
    if (state.minGroupSize > 1) {
      emit(state.copyWith(minGroupSize: state.minGroupSize - 1));
    }
  }

  @override
  Future<void> close() {
    descriptionController.dispose();
    return super.close();
  }
}
