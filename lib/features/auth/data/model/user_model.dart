class UserModel {
  final String token;
  final int? id;
  final String? username;
  final String? role;
  final String? name;
  final String? email;
  final TourGuideProfile? tourGuideProfile;
  final Map<String, dynamic>? touristProfile;

  UserModel({
    this.token = '',
    this.id,
    this.username,
    this.role,
    this.name,
    this.email,
    this.tourGuideProfile,
    this.touristProfile,
  });

  /// ⭐ استخدمه لما بتبعتله response كامل
  /// {
  ///   "success": true,
  ///   "data": {
  ///     "token": "eyJ...",
  ///     "name": "Ahmed",
  ///     "email": "ahmed@test.com"
  ///   }
  /// }
  factory UserModel.fromFullResponse(Map<String, dynamic> json) {
    return UserModel(
      token: json['data']?['token']?.toString() ?? '',
      name: json['data']?['name']?.toString(),
      email: json['data']?['email']?.toString(),
    );
  }

  /// ⭐ استخدمه لما بتبعتله data فقط
  /// {
  ///   "token": "eyJ...",
  ///   "name": "Ahmed",
  ///   "email": "ahmed@test.com"
  /// }
  factory UserModel.fromJson(Map<String, dynamic> json) {
    final userNode = json['user'] as Map<String, dynamic>?;
    final guideProfileNode = json['tourGuideProfile'] as Map<String, dynamic>?;
    final touristProfileNode = json['touristProfile'] as Map<String, dynamic>?;
    return UserModel(
      token: json['token']?.toString() ?? '', // ⭐ مباشرة بدون data
      id: userNode?['id'] as int?,
      username: userNode?['username']?.toString(),
      role: userNode?['role']?.toString(),
      name: json['name']?.toString() ?? userNode?['username']?.toString(),
      email: json['email']?.toString() ?? userNode?['email']?.toString(),
      tourGuideProfile:
          guideProfileNode != null ? TourGuideProfile.fromJson(guideProfileNode) : null,
      touristProfile: touristProfileNode,
    );
  }

  factory UserModel.fromAuthMeResponse(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;
    final userNode = data?['user'] as Map<String, dynamic>?;
    final guideProfileNode = data?['tourGuideProfile'] as Map<String, dynamic>?;
    final touristProfileNode = data?['touristProfile'] as Map<String, dynamic>?;
    return UserModel(
      id: userNode?['id'] as int?,
      username: userNode?['username']?.toString(),
      role: userNode?['role']?.toString(),
      name: guideProfileNode?['name']?.toString() ?? userNode?['username']?.toString(),
      email: guideProfileNode?['email']?.toString() ?? userNode?['email']?.toString(),
      tourGuideProfile:
          guideProfileNode != null ? TourGuideProfile.fromJson(guideProfileNode) : null,
      touristProfile: touristProfileNode,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'id': id,
      'username': username,
      'role': role,
      'name': name,
      'email': email,
      'tourGuideProfile': tourGuideProfile?.toJson(),
      'touristProfile': touristProfile,
    };
  }
}

class TourGuideProfile {
  final int? id;
  final String? name;
  final String? email;
  final String? city;
  final String? phone;
  final String? licensedNumber;
  final int? yearsOfExperience;
  final String? guideType;
  final String? tourType;
  final String? coveredArea;
  final int? tourDuration;
  final List<GuideLanguage> languages;
  final String? profilePhoto;
  final String? license;
  final String? idDocument;

  TourGuideProfile({
    this.id,
    this.name,
    this.email,
    this.city,
    this.phone,
    this.licensedNumber,
    this.yearsOfExperience,
    this.guideType,
    this.tourType,
    this.coveredArea,
    this.tourDuration,
    this.languages = const [],
    this.profilePhoto,
    this.license,
    this.idDocument,
  });

  factory TourGuideProfile.fromJson(Map<String, dynamic> json) {
    final languagesRaw = json['languages'] as List<dynamic>? ?? const [];
    return TourGuideProfile(
      id: json['id'] as int?,
      name: json['name']?.toString(),
      email: json['email']?.toString(),
      city: json['city']?.toString(),
      phone: json['phone']?.toString(),
      licensedNumber: json['licensedNumber']?.toString(),
      yearsOfExperience: json['yearsOfExperience'] as int?,
      guideType: json['guideType']?.toString(),
      tourType: json['tourType']?.toString(),
      coveredArea: json['coveredArea']?.toString(),
      tourDuration: json['tourDuration'] as int?,
      languages: languagesRaw
          .whereType<Map<String, dynamic>>()
          .map(GuideLanguage.fromJson)
          .toList(),
      profilePhoto: json['profilePhoto']?.toString(),
      license: json['license']?.toString(),
      idDocument: json['idDocument']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'city': city,
      'phone': phone,
      'licensedNumber': licensedNumber,
      'yearsOfExperience': yearsOfExperience,
      'guideType': guideType,
      'tourType': tourType,
      'coveredArea': coveredArea,
      'tourDuration': tourDuration,
      'languages': languages.map((item) => item.toJson()).toList(),
      'profilePhoto': profilePhoto,
      'license': license,
      'idDocument': idDocument,
    };
  }
}

class GuideLanguage {
  final String? language;
  final String? level;

  GuideLanguage({this.language, this.level});

  factory GuideLanguage.fromJson(Map<String, dynamic> json) {
    return GuideLanguage(
      language: json['language']?.toString(),
      level: json['level']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'language': language, 'level': level};
  }
}
