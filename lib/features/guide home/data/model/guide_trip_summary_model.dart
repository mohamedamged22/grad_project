class GuideTripSummaryModel {
  final int id;
  final String title;
  final String city;
  final String category;
  final String? coverImageUrl;
  final String? duration;
  final String status;
  final double? pricePerTourist;
  final String? startDate;
  final String? endDate;

  const GuideTripSummaryModel({
    required this.id,
    required this.title,
    required this.city,
    required this.category,
    required this.coverImageUrl,
    required this.duration,
    required this.status,
    required this.pricePerTourist,
    this.startDate,
    this.endDate,
  });

  factory GuideTripSummaryModel.fromJson(Map<String, dynamic> json) {
    final rawPrice = json['pricePerTourist'];
    final parsedPrice = rawPrice is num
        ? rawPrice.toDouble()
        : double.tryParse(rawPrice?.toString() ?? '');

    return GuideTripSummaryModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      coverImageUrl: json['coverImageUrl']?.toString(),
      duration: json['duration']?.toString(),
      status: json['status']?.toString() ?? '',
      pricePerTourist: parsedPrice,
      startDate: json['startDate']?.toString(),
      endDate: json['endDate']?.toString(),
    );
  }

  String? get normalizedCoverImageUrl {
    final raw = coverImageUrl?.trim();
    if (raw == null || raw.isEmpty || raw.toLowerCase() == 'null') return null;
    if (raw.startsWith('http://') || raw.startsWith('https://')) return raw;
    final normalized = raw.startsWith('/') ? raw.substring(1) : raw;
    return 'https://asmaa-project.karem.live/$normalized';
  }
}
