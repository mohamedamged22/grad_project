class TouristLandmarkListItem {
  final int id;
  final String name;
  final String city;
  final String type;
  final String? imageUrl;

  const TouristLandmarkListItem({
    required this.id,
    required this.name,
    required this.city,
    required this.type,
    required this.imageUrl,
  });

  factory TouristLandmarkListItem.fromJson(Map<String, dynamic> json) {
    return TouristLandmarkListItem(
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
