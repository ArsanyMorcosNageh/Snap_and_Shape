class UserModel {
  final String displayName;
  final String email;
  final String token;

  UserModel({
    required this.displayName,
    required this.email,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      displayName: json['dispalyName'] ?? '', // لاحظ الإملاء الخاطئ في API
      email: json['email'] ?? '',
      token: json['token'] ?? '',
    );
  }
}
