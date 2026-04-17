class UserModel {
  final String token;
  final String? name;
  final String? email;

  UserModel({required this.token, this.name, this.email});

  /// ⭐ استخدمه لما بتبعتله response كامل
  /// {
  ///   "success": true,
  ///   "data": {
  ///     "token": "eyJ...",
  ///     "name": "Ahmed",
  ///     "email": "ahmed@test.com"
  ///   }
  /// }
  factory UserModel.fromFullResponse(Map<String, dynamic> json) {
    return UserModel(
      token: json['data']?['token']?.toString() ?? '',
      name: json['data']?['name']?.toString(),
      email: json['data']?['email']?.toString(),
    );
  }

  /// ⭐ استخدمه لما بتبعتله data فقط
  /// {
  ///   "token": "eyJ...",
  ///   "name": "Ahmed",
  ///   "email": "ahmed@test.com"
  /// }
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['token']?.toString() ?? '', // ⭐ مباشرة بدون data
      name: json['name']?.toString(),
      email: json['email']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'token': token, 'name': name, 'email': email};
  }
}
