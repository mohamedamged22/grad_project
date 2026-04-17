import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/data/models/guide_last_created_trip_model.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/data/repo/guide_create_trip_repo.dart';
import 'package:bloc/bloc.dart';

part 'guide_last_created_trip_state.dart';

class GuideLastCreatedTripCubit extends Cubit<GuideLastCreatedTripState> {
  GuideLastCreatedTripCubit(this._repo) : super(GuideLastCreatedTripState.initial());

  final GuideCreateTripRepo _repo;

  Future<void> fetchLastCreatedTrip() async {
    emit(state.copyWith(status: GuideLastCreatedTripStatus.loading, message: null));

    try {
      final trip = await _repo.getLastCreatedTrip();
      emit(
        state.copyWith(
          status: GuideLastCreatedTripStatus.success,
          trip: trip,
        ),
      );
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          status: GuideLastCreatedTripStatus.failure,
          message: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GuideLastCreatedTripStatus.failure,
          message: e.toString(),
        ),
      );
    }
  }
}
