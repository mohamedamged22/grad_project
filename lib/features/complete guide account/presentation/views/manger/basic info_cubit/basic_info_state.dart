part of 'basic_info_cubit.dart';

@immutable
abstract class BasicInfoState {}

class BasicInfoInitial extends BasicInfoState {}

class BasicInfoLoading extends BasicInfoState {}

class BasicInfoLoaded extends BasicInfoState {
  final BasicInfoModel basicInfo;
  BasicInfoLoaded(this.basicInfo);
}

class BasicInfoSuccess extends BasicInfoState {
  final String message;
  BasicInfoSuccess(this.message);
}

class BasicInfoError extends BasicInfoState {
  final String message;
  BasicInfoError(this.message);
}
