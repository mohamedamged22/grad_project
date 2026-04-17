import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/data/models/guide_create_trip_time_request_model.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/data/repo/guide_create_trip_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'guide_create_trip_time_state.dart';

class GuideCreateTripTimeCubit extends Cubit<GuideCreateTripTimeState> {
  GuideCreateTripTimeCubit(this._repo) : super(GuideCreateTripTimeState.initial());

  final GuideCreateTripRepo _repo;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();

  final List<String> durations = const [
    '1 day',
    '2 days',
    '3 days',
    '5 days',
    '7 days',
    '10 days',
  ];

  void setDateRange(DateTime from, DateTime to) {
    emit(
      state.copyWith(
        dateRange: DateTimeRange(start: from, end: to),
        status: GuideCreateTripTimeStatus.initial,
      ),
    );
  }

  void selectDuration(String? duration) {
    emit(
      state.copyWith(
        selectedDuration: duration,
        status: GuideCreateTripTimeStatus.initial,
      ),
    );
  }

  void increaseMax() {
    emit(state.copyWith(maxGroupSize: state.maxGroupSize + 1));
  }

  void decreaseMax() {
    if (state.maxGroupSize > state.minGroupSize) {
      emit(state.copyWith(maxGroupSize: state.maxGroupSize - 1));
    }
  }

  void increaseMin() {
    if (state.minGroupSize < state.maxGroupSize) {
      emit(state.copyWith(minGroupSize: state.minGroupSize + 1));
    }
  }

  void decreaseMin() {
    if (state.minGroupSize > 1) {
      emit(state.copyWith(minGroupSize: state.minGroupSize - 1));
    }
  }

  Future<void> submitTripTime() async {
    final description = descriptionController.text.trim();

    if (state.dateRange == null) {
      emit(
        state.copyWith(
          status: GuideCreateTripTimeStatus.failure,
          message: 'Please select available date range',
        ),
      );
      return;
    }

    if (state.dateRange!.end.isBefore(state.dateRange!.start)) {
      emit(
        state.copyWith(
          status: GuideCreateTripTimeStatus.failure,
          message: 'End date must be after start date',
        ),
      );
      return;
    }

    if (state.selectedDuration == null || state.selectedDuration!.trim().isEmpty) {
      emit(
        state.copyWith(
          status: GuideCreateTripTimeStatus.failure,
          message: 'Please select tour duration',
        ),
      );
      return;
    }

    if (description.isEmpty) {
      emit(
        state.copyWith(
          status: GuideCreateTripTimeStatus.failure,
          message: 'Description is required',
        ),
      );
      return;
    }

    if (description.length < 10) {
      emit(
        state.copyWith(
          status: GuideCreateTripTimeStatus.failure,
          message: 'Description must be at least 10 characters',
        ),
      );
      return;
    }

    if (state.minGroupSize > state.maxGroupSize) {
      emit(
        state.copyWith(
          status: GuideCreateTripTimeStatus.failure,
          message: 'Min group size cannot be greater than max group size',
        ),
      );
      return;
    }

    emit(state.copyWith(status: GuideCreateTripTimeStatus.loading, message: null));

    try {
      final message = await _repo.createTripTime(
        GuideCreateTripTimeRequestModel(
          startDate: DateFormat('yyyy-MM-dd').format(state.dateRange!.start),
          endDate: DateFormat('yyyy-MM-dd').format(state.dateRange!.end),
          description: description,
          minGroupSize: state.minGroupSize,
          maxGroupSize: state.maxGroupSize,
          tourDuration: state.selectedDuration!,
        ),
      );

      emit(
        state.copyWith(
          status: GuideCreateTripTimeStatus.success,
          message: message,
        ),
      );
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          status: GuideCreateTripTimeStatus.failure,
          message: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GuideCreateTripTimeStatus.failure,
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    descriptionController.dispose();
    return super.close();
  }
}
