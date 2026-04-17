part of 'trip_details_cubit.dart';

abstract class TripDetailsState {}

class TripDetailsInitial extends TripDetailsState {}

class TripDetailsLoading extends TripDetailsState {}

class TripDetailsSuccess extends TripDetailsState {
  final String message;
  TripDetailsSuccess(this.message);
}

class TripDetailsError extends TripDetailsState {
  final String message;
  TripDetailsError(this.message);
}
