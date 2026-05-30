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
      'inclusions': inclusions,
    };
  }
}
