class TouristPublicTrip {
  final int id;
  final String title;
  final String city;
  final String startDate;
  final String endDate;
  final String duration;
  final String? imageUrl;
  final String creatorName;
  final num price;

  const TouristPublicTrip({
    required this.id,
    required this.title,
    required this.city,
    required this.startDate,
    required this.endDate,
    required this.duration,
    required this.imageUrl,
    required this.creatorName,
    required this.price,
  });

  factory TouristPublicTrip.fromJson(Map<String, dynamic> json) {
    return TouristPublicTrip(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      startDate: json['startDate']?.toString() ?? '',
      endDate: json['endDate']?.toString() ?? '',
      duration: json['duration']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString(),
      creatorName: json['creatorName']?.toString() ?? '',
      price: json['price'] as num? ?? 0,
    );
  }

  String? get normalizedImageUrl {
    final raw = imageUrl?.trim();
    if (raw == null || raw.isEmpty || raw.toLowerCase() == 'null') return null;
    if (raw.startsWith('http://') || raw.startsWith('https://')) return raw;
    final normalized = raw.startsWith('/') ? raw.substring(1) : raw;
    return 'https://asmaa-project.karem.live/$normalized';
  }

  String get formattedPrice {
    if (price % 1 == 0) return price.toInt().toString();
    return price.toStringAsFixed(2);
  }

  String get dateRange {
    if (startDate.isEmpty && endDate.isEmpty) return 'Date not set';
    if (startDate == endDate) return startDate;
    if (startDate.isNotEmpty && endDate.isNotEmpty)
      return '$startDate → $endDate';
    return startDate.isNotEmpty ? startDate : endDate;
  }
}
