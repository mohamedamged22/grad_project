class GuideProfileDashboardModel {
  final String guideName;
  final String guideLocation;
  final String city;
  final String? profilePhoto;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String title;
  final double rating;
  final int completedTrips;
  final double earnings;

  const GuideProfileDashboardModel({
    required this.guideName,
    required this.guideLocation,
    required this.city,
    required this.profilePhoto,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.title,
    required this.rating,
    required this.completedTrips,
    required this.earnings,
  });

  factory GuideProfileDashboardModel.fromJson(Map<String, dynamic> json) {
    final stats = json['stats'] as Map<String, dynamic>? ?? const {};
    final firstName = _humanizeText((json['firstName'] ?? '').toString());
    final lastName = _humanizeText((json['lastName'] ?? '').toString());
    final title = _humanizeText((json['title'] ?? '').toString());
    final guideName = _humanizeText((json['guideName'] ?? '').toString());
    final city = _humanizeText((json['city'] ?? '').toString());
    final normalizedGuideName =
        guideName.isNotEmpty ? guideName : _composeName(firstName, lastName);
    final guideLocation = _humanizeText(
      (json['guideLocation'] ?? '').toString(),
    );

    return GuideProfileDashboardModel(
      guideName: normalizedGuideName,
      guideLocation:
          city.isNotEmpty
              ? city
              : (guideLocation.isNotEmpty ? guideLocation : title),
      city: city,
      profilePhoto: _normalizeUrl(json['profilePhoto']?.toString()),
      firstName: firstName,
      lastName: lastName,
      email: (json['email'] ?? '').toString().trim(),
      phone: (json['phone'] ?? '').toString().trim(),
      title: title,
      rating: _toDouble(stats['rating']),
      completedTrips: _toInt(stats['completedTrips']),
      earnings: _toDouble(stats['earnings']),
    );
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static double _toDouble(dynamic value) {
    if (value is double) return value;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0;
    return 0;
  }

  static String? _normalizeUrl(String? url) {
    if (url == null) return null;
    final value = url.trim();
    if (value.isEmpty || value.toLowerCase() == 'null') return null;
    final normalized = value.replaceAll('\\', '/');
    return normalized.replaceAll('://localhost', '://10.0.2.2');
  }

  static String _humanizeText(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return '';

    final withSpaces =
        trimmed
            .replaceAll('_', ' ')
            .replaceAll(RegExp(r'(?<=[a-z])(?=[A-Z])'), ' ')
            .replaceAll(RegExp(r'\s+'), ' ')
            .trim();

    return withSpaces
        .split(' ')
        .where((part) => part.isNotEmpty)
        .map((part) => part[0].toUpperCase() + part.substring(1).toLowerCase())
        .join(' ');
  }

  static String _composeName(String firstName, String lastName) {
    if (firstName.isEmpty && lastName.isEmpty) return '';
    if (firstName.isEmpty) return lastName;
    if (lastName.isEmpty) return firstName;
    return '$firstName $lastName';
  }
}
