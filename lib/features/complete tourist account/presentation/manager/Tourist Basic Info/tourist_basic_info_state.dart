part of 'tourist_basic_info_cubit.dart';

abstract class TouristBasicInfoState {}

class TouristBasicInfoInitial extends TouristBasicInfoState {}

class TouristBasicInfoLoading extends TouristBasicInfoState {}

class TouristBasicInfoSuccess extends TouristBasicInfoState {
  final String message;
  TouristBasicInfoSuccess(this.message);
}

class TouristBasicInfoError extends TouristBasicInfoState {
  final String message;
  TouristBasicInfoError(this.message);
}
class TouristBasicInfoLoaded extends TouristBasicInfoState {
  TouristBasicInfoLoaded();
}
