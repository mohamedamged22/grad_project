class GuideCreateTripPriceRequestModel {
  final double pricePerTourist;
  final List<String> inclusions;

  const GuideCreateTripPriceRequestModel({
    required this.pricePerTourist,
    required this.inclusions,
  });

  Map<String, dynamic> toJson() {
    return {
      'pricePerTourist': pricePerTourist,
      'price_per_tourist': pricePerTourist,
      'price': pricePerTourist,
      'inclusions': inclusions,
      'included': inclusions,
      'includedServices': inclusions,
    };
  }
}
