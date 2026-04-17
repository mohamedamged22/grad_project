class GuideCreateTripBasicRequestModel {
  final String title;
  final List<String> category;
  final String city;
  final String meetingPoint;

  const GuideCreateTripBasicRequestModel({
    required this.title,
    required this.category,
    required this.city,
    required this.meetingPoint,
  });

  Map<String, dynamic> toJson() {
    final payload = <String, dynamic>{
      'title': title,
      'category': category,
      'categories': category,
      'city': city,
      'meetingPoint': meetingPoint,
      'meeting_point': meetingPoint,
    };

    final point = _parseMeetingPoint(meetingPoint);
    if (point != null) {
      payload['lat'] = point.$1;
      payload['lng'] = point.$2;
      payload['latitude'] = point.$1;
      payload['longitude'] = point.$2;
      payload['meetingLocation'] = {
        'lat': point.$1,
        'lng': point.$2,
      };
    }

    return payload;
  }

  (double, double)? _parseMeetingPoint(String value) {
    final parts = value.split(',');
    if (parts.length != 2) return null;

    final lat = double.tryParse(parts[0].trim());
    final lng = double.tryParse(parts[1].trim());
    if (lat == null || lng == null) return null;

    return (lat, lng);
  }
}
