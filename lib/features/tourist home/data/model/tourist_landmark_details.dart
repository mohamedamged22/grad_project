class TouristLandmarkDetails {
  final int id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String type;
  final String? imageUrl;

  const TouristLandmarkDetails({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.type,
    required this.imageUrl,
  });

  factory TouristLandmarkDetails.fromJson(Map<String, dynamic> json) {
    return TouristLandmarkDetails(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
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
