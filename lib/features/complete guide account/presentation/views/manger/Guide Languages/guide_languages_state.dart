part of 'guide_languages_cubit.dart';

abstract class GuideLanguagesState {}

class GuideLanguagesInitial extends GuideLanguagesState {}

class GuideLanguagesLoading extends GuideLanguagesState {}

class GuideLanguagesSuccess extends GuideLanguagesState {
  final String message;
  GuideLanguagesSuccess(this.message);
}

class GuideLanguagesError extends GuideLanguagesState {
  final String message;
  GuideLanguagesError(this.message);
}
