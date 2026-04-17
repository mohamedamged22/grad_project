class TouristBasicInfoModel {
  final String name;
  final String email;
  final String type;
  final String nationality;
  final String motherLanguage;
  final List<String> languages;
  final String destinationCity;

  TouristBasicInfoModel({
    required this.name,
    required this.email,
    required this.type,
    required this.nationality,
    required this.motherLanguage,
    required this.languages,
    this.destinationCity = 'Cairo',
  });

  // ✅ أضف fromJson للـ GET response
  factory TouristBasicInfoModel.fromJson(Map<String, dynamic> json) {
    return TouristBasicInfoModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      type: json['type'] ?? 'MALE',
      nationality: json['nationality'] ?? '',
      motherLanguage: json['motherLanguage'] ?? '',
      languages: List<String>.from(json['languages'] ?? []),
      destinationCity: json['destinationCity'] ?? 'Cairo',
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "type": type,
    "nationality": nationality,
    "motherLanguage": motherLanguage,
    "languages": languages,
    "destinationCity": destinationCity,
  };
}
