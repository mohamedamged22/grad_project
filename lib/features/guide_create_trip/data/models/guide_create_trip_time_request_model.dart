class GuideCreateTripTimeRequestModel {
  final String startDate;
  final String endDate;
  final String description;
  final int minGroupSize;
  final int maxGroupSize;
  final String tourDuration;

  const GuideCreateTripTimeRequestModel({
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.minGroupSize,
    required this.maxGroupSize,
    required this.tourDuration,
  });

  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate,
      'endDate': endDate,
      'description': description,
      'minGroupSize': minGroupSize,
      'maxGroupSize': maxGroupSize,
      'tourDuration': tourDuration,
    };
  }
}
