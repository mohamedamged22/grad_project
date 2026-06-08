class GuideBookingModel {
  final int id;
  final String title;
  final String startDate;
  final String endDate;
  final String description;
  final double? price;
  final String status;
  final String? createdAt;
  final int? touristCount;
  final BookingTourist? tourist;
  final BookingTourGuide? tourGuide;

  const GuideBookingModel({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.description,
    this.price,
    required this.status,
    this.createdAt,
    this.touristCount,
    this.tourist,
    this.tourGuide,
  });

  factory GuideBookingModel.fromJson(Map<String, dynamic> json) {
    return GuideBookingModel(
      id: json['id'] as int? ?? 0,
      title: json['title']?.toString() ?? '',
      startDate: json['startDate']?.toString() ?? '',
      endDate: json['endDate']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble(),
      status: json['status']?.toString() ?? 'PENDING',
      createdAt: json['createdAt']?.toString(),
      touristCount: json['touristCount'] as int?,
      tourist: json['tourist'] != null
          ? BookingTourist.fromJson(json['tourist'] as Map<String, dynamic>)
          : null,
      tourGuide: json['tourGuide'] != null
          ? BookingTourGuide.fromJson(json['tourGuide'] as Map<String, dynamic>)
          : null,
    );
  }

  String get formattedPrice {
    if (price == null) return '\$ 0';
    final v = price! % 1 == 0 ? price!.toInt().toString() : price.toString();
    return '\$ $v';
  }

  String get touristName => tourist?.username ?? '';
  String? get touristPhoto => tourist?.profilePhoto;
  String get guideName => tourGuide?.username ?? '';
  String? get guidePhoto => tourGuide?.profilePhoto;

  String get formattedCreatedAt {
    if (createdAt == null || createdAt!.isEmpty) return '';
    try {
      final dt = DateTime.parse(createdAt!);
      final months = [
        '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      final h = dt.hour.toString().padLeft(2, '0');
      final m = dt.minute.toString().padLeft(2, '0');
      return '${months[dt.month]} ${dt.day}, ${dt.year} at $h:$m';
    } catch (_) {
      return createdAt!;
    }
  }
}

class BookingTourGuide {
  final int id;
  final String username;
  final String? profilePhoto;

  const BookingTourGuide({
    required this.id,
    required this.username,
    this.profilePhoto,
  });

  factory BookingTourGuide.fromJson(Map<String, dynamic> json) {
    return BookingTourGuide(
      id: json['id'] as int? ?? 0,
      username: json['username']?.toString() ?? '',
      profilePhoto: json['profilePhoto']?.toString(),
    );
  }
}

class BookingTourist {
  final int id;
  final String username;
  final String? profilePhoto;

  const BookingTourist({
    required this.id,
    required this.username,
    this.profilePhoto,
  });

  factory BookingTourist.fromJson(Map<String, dynamic> json) {
    return BookingTourist(
      id: json['id'] as int? ?? 0,
      username: json['username']?.toString() ?? '',
      profilePhoto: json['profilePhoto']?.toString(),
    );
  }
}