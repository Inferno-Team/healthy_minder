import 'package:healthy_minder/models/saved_user.dart';

class LoginResponse {
  String token;
  SavedUser user;

  LoginResponse({
    required this.token,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        token: json['token'] ?? "",
        user: json['user'] == null
            ? SavedUser.empty()
            : SavedUser.fromJson(json['user']),
      );
}
