class TourGuideProfile {
  final int id;
  final String name;
  final String city;
  final int yearsOfExperience;
  final List<String> specialization;
  final List<String> languages;
  final String profilePhoto;
  final String guideType;
  final String tourType;

  const TourGuideProfile({
    required this.id,
    required this.name,
    required this.city,
    required this.yearsOfExperience,
    required this.specialization,
    required this.languages,
    required this.profilePhoto,
    required this.guideType,
    required this.tourType,
  });

  factory TourGuideProfile.fromJson(Map<String, dynamic> json) {
    return TourGuideProfile(
      id: _asInt(json['id']),
      name: _asString(json['name']),
      city: _asString(json['city']),
      yearsOfExperience: _asInt(json['yearsOfExperience']),
      specialization: _asStringList(json['specialization']),
      languages: _asStringList(json['languages']),
      profilePhoto: _asString(json['profilePhoto']),
      guideType: _asString(json['guideType']),
      tourType: _asString(json['tourType']),
    );
  }
}

int _asInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? 0;
}

String _asString(dynamic value) => value?.toString() ?? '';

List<String> _asStringList(dynamic value) {
  if (value is List) return value.map((e) => e.toString()).toList();
  return const [];
}
