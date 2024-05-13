import 'package:healthy_minder/models/channel.dart';

class SavedUser {
  final String username;
  final String fullName;
  final String imageUrl;
  final String email;
  final int id;
  final List<Channel> channels;

  SavedUser({
    required this.username,
    required this.fullName,
    required this.imageUrl,
    required this.email,
    required this.id,
    required this.channels,
  });

  factory SavedUser.empty() => SavedUser(
        username: '',
        fullName: '',
        email: '',
        id: -1,
        imageUrl: '',
        channels: [],
      );

  factory SavedUser.fromJson(dynamic json) => SavedUser(
        username: json['username'] ?? '',
        fullName: json['fullname'] ?? '',
        imageUrl: json['avatar'] ?? '',
        email: json['email'] ?? '',
        id: json['id'] ?? -1,
        channels: Channel.fromJsonList(json['channels'] ?? []),
      );

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "imageUrl": imageUrl,
      "fullname": fullName,
      "id": id,
      "email": email,
      "channels": channels,
    };
  }
}
