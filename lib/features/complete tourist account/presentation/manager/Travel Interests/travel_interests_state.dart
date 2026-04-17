part of 'travel_interests_cubit.dart';

abstract class TravelInterestsState {}

class TravelInterestsInitial extends TravelInterestsState {}

class TravelInterestsLoading extends TravelInterestsState {}

class TravelInterestsSuccess extends TravelInterestsState {
  final String message;
  TravelInterestsSuccess(this.message);
}

class TravelInterestsError extends TravelInterestsState {
  final String message;
  TravelInterestsError(this.message);
}
