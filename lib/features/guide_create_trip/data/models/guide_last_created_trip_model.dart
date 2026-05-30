class GuideLastCreatedTripModel {
  final int? id;
  final String? title;
  final String? city;
  final double? price;
  final String? imageUrl;
  final String? startDate;
  final String? endDate;
  final List<String> categories;
  final String? status;

  const GuideLastCreatedTripModel({
    required this.id,
    required this.title,
    required this.city,
    required this.price,
    required this.imageUrl,
    required this.startDate,
    required this.endDate,
    required this.categories,
    required this.status,
  });

  factory GuideLastCreatedTripModel.fromJson(Map<String, dynamic> json) {
    final rawCategories = json['categories'] ?? json['category'];
    final categories =
      rawCategories is List
        ? rawCategories.map((e) => e.toString()).toList()
        : rawCategories != null
          ? [rawCategories.toString()]
          : <String>[];

    final rawPrice = json['price'] ?? json['pricePerTourist'];
    final parsedPrice =
      rawPrice is num ? rawPrice.toDouble() : double.tryParse(rawPrice?.toString() ?? '');

    return GuideLastCreatedTripModel(
      id: json['id'] as int?,
      title: json['title']?.toString(),
      city: json['city']?.toString(),
      price: parsedPrice,
        imageUrl: json['coverImageUrl']?.toString() ??
          json['tripCoverImage']?.toString() ??
          json['imageUrl']?.toString() ??
          json['trip_cover_image']?.toString() ??
          json['image_url']?.toString(),
      startDate: json['startDate']?.toString(),
      endDate: json['endDate']?.toString(),
      categories: categories,
      status: json['status']?.toString(),
    );
  }
}
