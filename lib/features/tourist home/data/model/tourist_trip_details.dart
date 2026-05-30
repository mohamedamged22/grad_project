class TouristTripDetails {
  final int id;
  final String title;
  final String city;
  final String meetingPoint;
  final String description;
  final int minGroupSize;
  final int maxGroupSize;
  final String tourDuration;
  final String startDate;
  final String endDate;
  final num pricePerTourist;
  final String status;
  final String? coverImageUrl;
  final List<String> categories;
  final List<String> inclusions;
  final List<TouristTripLandmark> landmarks;
  final TouristTripGuide? guide;

  const TouristTripDetails({
    required this.id,
    required this.title,
    required this.city,
    required this.meetingPoint,
    required this.description,
    required this.minGroupSize,
    required this.maxGroupSize,
    required this.tourDuration,
    required this.startDate,
    required this.endDate,
    required this.pricePerTourist,
    required this.status,
    required this.coverImageUrl,
    required this.categories,
    required this.inclusions,
    required this.landmarks,
    required this.guide,
  });

  factory TouristTripDetails.fromJson(Map<String, dynamic> json) {
    return TouristTripDetails(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      meetingPoint: json['meetingPoint']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      minGroupSize: (json['minGroupSize'] as num?)?.toInt() ?? 0,
      maxGroupSize: (json['maxGroupSize'] as num?)?.toInt() ?? 0,
      tourDuration: json['tourDuration']?.toString() ?? '',
      startDate: json['startDate']?.toString() ?? '',
      endDate: json['endDate']?.toString() ?? '',
      pricePerTourist: json['pricePerTourist'] as num? ?? 0,
      status: json['status']?.toString() ?? '',
      coverImageUrl: json['coverImageUrl']?.toString(),
      categories:
          (json['categories'] as List?)
              ?.map((e) => e?.toString() ?? '')
              .where((e) => e.isNotEmpty)
              .toList() ??
          const [],
      inclusions:
          (json['inclusions'] as List?)
              ?.map((e) => e?.toString() ?? '')
              .where((e) => e.isNotEmpty)
              .toList() ??
          const [],
      landmarks:
          (json['landmarks'] as List?)
              ?.whereType<Map<String, dynamic>>()
              .map(TouristTripLandmark.fromJson)
              .toList() ??
          const [],
      guide:
          json['guide'] is Map<String, dynamic>
              ? TouristTripGuide.fromJson(
                json['guide'] as Map<String, dynamic>,
              )
              : null,
    );
  }

  String? get normalizedCoverImageUrl {
    final raw = coverImageUrl?.trim();
    if (raw == null || raw.isEmpty || raw.toLowerCase() == 'null') return null;
    if (raw.startsWith('http://') || raw.startsWith('https://')) return raw;
    final normalized = raw.startsWith('/') ? raw.substring(1) : raw;
    return 'https://asmaa-project.karem.live/$normalized';
  }

  String get formattedPrice {
    if (pricePerTourist % 1 == 0) {
      return pricePerTourist.toInt().toString();
    }
    return pricePerTourist.toStringAsFixed(2);
  }

  String get dateRange {
    if (startDate.isEmpty && endDate.isEmpty) return '';
    if (startDate.isNotEmpty && endDate.isNotEmpty) {
      return '$startDate - $endDate';
    }
    return startDate.isNotEmpty ? startDate : endDate;
  }

  String get groupSizeLabel {
    if (minGroupSize == 0 && maxGroupSize == 0) return '';
    if (minGroupSize > 0 && maxGroupSize > 0) {
      return '$minGroupSize-$maxGroupSize';
    }
    return minGroupSize > 0 ? minGroupSize.toString() : maxGroupSize.toString();
  }
}

class TouristTripLandmark {
  final int id;
  final String name;
  final String city;
  final String type;
  final String? imageUrl;

  const TouristTripLandmark({
    required this.id,
    required this.name,
    required this.city,
    required this.type,
    required this.imageUrl,
  });

  factory TouristTripLandmark.fromJson(Map<String, dynamic> json) {
    return TouristTripLandmark(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString(),
    );
  }

  String? get normalizedImageUrl {
    final raw = imageUrl?.trim();
    if (raw == null || raw.isEmpty || raw.toLowerCase() == 'null') return null;
    if (raw.startsWith('http://') || raw.startsWith('https://')) return raw;
    final normalized = raw.startsWith('/') ? raw.substring(1) : raw;
    return 'https://asmaa-project.karem.live/$normalized';
  }
}

class TouristTripGuide {
  final int id;
  final String name;
  final String? profilePhoto;
  final String city;
  final num rating;
  final int yearsOfExperience;

  const TouristTripGuide({
    required this.id,
    required this.name,
    required this.profilePhoto,
    required this.city,
    required this.rating,
    required this.yearsOfExperience,
  });

  factory TouristTripGuide.fromJson(Map<String, dynamic> json) {
    return TouristTripGuide(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      profilePhoto: json['profilePhoto']?.toString(),
      city: json['city']?.toString() ?? '',
      rating: json['rating'] as num? ?? 0,
      yearsOfExperience: (json['yearsOfExperience'] as num?)?.toInt() ?? 0,
    );
  }

  String? get normalizedProfilePhoto {
    final raw = profilePhoto?.trim();
    if (raw == null || raw.isEmpty || raw.toLowerCase() == 'null') return null;
    if (raw.startsWith('http://') || raw.startsWith('https://')) return raw;
    final normalized = raw.startsWith('/') ? raw.substring(1) : raw;
    return 'https://asmaa-project.karem.live/$normalized';
  }
}
