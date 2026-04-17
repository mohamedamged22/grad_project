part of 'pricing_cubit.dart';

abstract class PricingState {}

class PricingInitial extends PricingState {}

class PricingLoading extends PricingState {}

class PricingSuccess extends PricingState {
  final String message;
  PricingSuccess(this.message);
}

class PricingError extends PricingState {
  final String message;
  PricingError(this.message);
}
