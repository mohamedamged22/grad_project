part of 'tourist_preferences_cubit.dart';

abstract class TouristPreferencesState {}

class TouristPreferencesInitial extends TouristPreferencesState {}

class TouristPreferencesLoading extends TouristPreferencesState {}

class TouristPreferencesSuccess extends TouristPreferencesState {
  final String message;
  TouristPreferencesSuccess(this.message);
}

class TouristPreferencesError extends TouristPreferencesState {
  final String message;
  TouristPreferencesError(this.message);
}
