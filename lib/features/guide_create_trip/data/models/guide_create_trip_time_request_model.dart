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
    final payload = <String, dynamic>{
      'startDate': startDate,
      'endDate': endDate,
      'description': description,
      'minGroupSize': minGroupSize,
      'maxGroupSize': maxGroupSize,
      'tourDuration': tourDuration,
      'start_date': startDate,
      'end_date': endDate,
      'min_group_size': minGroupSize,
      'max_group_size': maxGroupSize,
      'tour_duration': tourDuration,
    };

    final durationDays = _extractDurationDays(tourDuration);
    if (durationDays != null) {
      payload['duration'] = durationDays;
      payload['durationDays'] = durationDays;
      payload['tourDurationDays'] = durationDays;
      payload['tour_duration_days'] = durationDays;
    }

    return payload;
  }

  int? _extractDurationDays(String value) {
    final numeric = RegExp(r'\d+').firstMatch(value)?.group(0);
    if (numeric == null) return null;
    return int.tryParse(numeric);
  }
}
