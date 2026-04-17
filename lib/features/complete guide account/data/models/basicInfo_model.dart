class BasicInfoModel {
  final String name;
  final String email;
  final String phone;
  final String city;

  BasicInfoModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.city,
  });

  factory BasicInfoModel.fromJson(Map<String, dynamic> json) {
    return BasicInfoModel(
      name: json['Username']?.toString() ?? json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'phone': phone, 'city': city};
  }

  BasicInfoModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? city,
  }) {
    return BasicInfoModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      city: city ?? this.city,
    );
  }
}
