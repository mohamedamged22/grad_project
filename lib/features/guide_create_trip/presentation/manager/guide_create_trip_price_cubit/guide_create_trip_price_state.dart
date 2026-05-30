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
      selectedPrice: null,
      includedItems: {
        'Private transportation': false,
        'Entry fees to the Pyramids': false,
        'Professional licensed tour guide': false,
        'Lunch at a local restaurant': false,
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
