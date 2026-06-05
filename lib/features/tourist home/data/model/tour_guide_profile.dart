class TourGuideProfile {
  final int id;
  final String name;
  final String email;
  final String type;
  final String phone;
  final String city;
  final String guideType;
  final String licensedNumber;
  final int yearsOfExperience;
  final List<String> specialization;
  final List<TourGuideLanguage> languages;
  final String tourType;
  final String coveredArea;
  final TourGuidePriceRange? priceRange;
  final int tourDuration;
  final String profilePhoto;
  final String license;
  final String idDocument;

  const TourGuideProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.type,
    required this.phone,
    required this.city,
    required this.guideType,
    required this.licensedNumber,
    required this.yearsOfExperience,
    required this.specialization,
    required this.languages,
    required this.tourType,
    required this.coveredArea,
    required this.priceRange,
    required this.tourDuration,
    required this.profilePhoto,
    required this.license,
    required this.idDocument,
  });

  factory TourGuideProfile.fromJson(Map<String, dynamic> json) {
    return TourGuideProfile(
      id: _asInt(json['id']),
      name: _asString(json['name']),
      email: _asString(json['email']),
      type: _asString(json['type']),
      phone: _asString(json['phone']),
      city: _asString(json['city']),
      guideType: _asString(json['guideType']),
      licensedNumber: _asString(json['licensedNumber']),
      yearsOfExperience: _asInt(json['yearsOfExperience']),
      specialization: _asStringList(json['specialization']),
      languages: _asLanguages(json['languages']),
      tourType: _asString(json['tourType']),
      coveredArea: _asString(json['coveredArea']),
      priceRange: _asPriceRange(json['priceRange']),
      tourDuration: _asInt(json['tourDuration']),
      profilePhoto: _asString(json['profilePhoto']),
      license: _asString(json['license']),
      idDocument: _asString(json['idDocument']),
    );
  }
}

class TourGuideLanguage {
  final String language;
  final String level;

  const TourGuideLanguage({required this.language, required this.level});

  factory TourGuideLanguage.fromJson(Map<String, dynamic> json) {
    return TourGuideLanguage(
      language: _asString(json['language']),
      level: _asString(json['level']),
    );
  }
}

class TourGuidePriceRange {
  final int min;
  final int max;

  const TourGuidePriceRange({required this.min, required this.max});

  factory TourGuidePriceRange.fromJson(Map<String, dynamic> json) {
    return TourGuidePriceRange(
      min: _asInt(json['min']),
      max: _asInt(json['max']),
    );
  }
}

int _asInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? 0;
}

String _asString(dynamic value) {
  return value?.toString() ?? '';
}

List<String> _asStringList(dynamic value) {
  if (value is List) {
    return value.map((item) => item.toString()).toList();
  }
  return const [];
}

List<TourGuideLanguage> _asLanguages(dynamic value) {
  if (value is List) {
    return value
        .whereType<Map<String, dynamic>>()
        .map(TourGuideLanguage.fromJson)
        .toList();
  }
  return const [];
}

TourGuidePriceRange? _asPriceRange(dynamic value) {
  if (value is Map<String, dynamic>) {
    return TourGuidePriceRange.fromJson(value);
  }
  return null;
}
