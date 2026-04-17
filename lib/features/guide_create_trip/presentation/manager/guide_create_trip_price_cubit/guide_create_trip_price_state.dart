part of 'guide_create_trip_price_cubit.dart';

enum GuideCreateTripPriceStatus { initial, loading, success, failure }

class GuideCreateTripPriceState {
  final String? selectedPrice;
  final Map<String, bool> includedItems;
  final GuideCreateTripPriceStatus status;
  final String? message;

  const GuideCreateTripPriceState({
    required this.selectedPrice,
    required this.includedItems,
    required this.status,
    this.message,
  });

  factory GuideCreateTripPriceState.initial() {
    return const GuideCreateTripPriceState(
      selectedPrice: '150.50',
      includedItems: {
        'Private transportation': true,
        'Entry fees to the Pyramids': true,
        'Professional licensed tour guide': true,
        'Lunch at a local restaurant': true,
      },
      status: GuideCreateTripPriceStatus.initial,
      message: null,
    );
  }

  GuideCreateTripPriceState copyWith({
    String? selectedPrice,
    Map<String, bool>? includedItems,
    GuideCreateTripPriceStatus? status,
    String? message,
  }) {
    return GuideCreateTripPriceState(
      selectedPrice: selectedPrice ?? this.selectedPrice,
      includedItems: includedItems ?? this.includedItems,
      status: status ?? this.status,
      message: message,
    );
  }
}
