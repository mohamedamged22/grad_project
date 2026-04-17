part of 'guide_create_new_trip_step3_cubit.dart';

class GuideCreateNewTripStep3State {
  final String? selectedPrice;
  final Map<String, bool> includedItems;

  const GuideCreateNewTripStep3State({
    required this.selectedPrice,
    required this.includedItems,
  });

  factory GuideCreateNewTripStep3State.initial() {
    return const GuideCreateNewTripStep3State(
      selectedPrice: '200\$ per/tourist',
      includedItems: {
        'Transportation': true,
        'Entry Tickets': true,
        'Lunch': true,
        'Photographer': true,
        'Tour Guide Only': false,
      },
    );
  }

  GuideCreateNewTripStep3State copyWith({
    String? selectedPrice,
    Map<String, bool>? includedItems,
  }) {
    return GuideCreateNewTripStep3State(
      selectedPrice: selectedPrice ?? this.selectedPrice,
      includedItems: includedItems ?? this.includedItems,
    );
  }
}
