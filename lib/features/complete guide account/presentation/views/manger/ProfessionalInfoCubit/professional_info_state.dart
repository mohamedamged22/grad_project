part of 'professional_info_cubit.dart';

abstract class ProfessionalInfoState {}

class ProfessionalInfoInitial extends ProfessionalInfoState {}

class ProfessionalInfoLoading extends ProfessionalInfoState {}

class ProfessionalInfoSuccess extends ProfessionalInfoState {
  final String message;
  ProfessionalInfoSuccess(this.message);
}

class ProfessionalInfoError extends ProfessionalInfoState {
  final String message;
  ProfessionalInfoError(this.message);
}
