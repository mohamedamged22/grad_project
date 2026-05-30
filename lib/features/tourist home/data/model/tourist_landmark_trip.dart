class TouristLandmarkTrip {
  final int id;
  final String title;
  final String city;
  final String category;
  final String? coverImageUrl;
  final String duration;
  final String status;
  final num pricePerTourist;

  const TouristLandmarkTrip({
    required this.id,
    required this.title,
    required this.city,
    required this.category,
    required this.coverImageUrl,
    required this.duration,
    required this.status,
    required this.pricePerTourist,
  });

  factory TouristLandmarkTrip.fromJson(Map<String, dynamic> json) {
    return TouristLandmarkTrip(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      coverImageUrl: json['coverImageUrl']?.toString(),
      duration: json['duration']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      pricePerTourist: json['pricePerTourist'] as num? ?? 0,
    );
  }

  String? get normalizedImageUrl {
    final raw = coverImageUrl?.trim();
    if (raw == null || raw.isEmpty || raw.toLowerCase() == 'null') return null;
    if (raw.startsWith('http://') || raw.startsWith('https://')) return raw;
    final normalized = raw.startsWith('/') ? raw.substring(1) : raw;
    return 'https://asmaa-project.karem.live/$normalized';
  }
}
