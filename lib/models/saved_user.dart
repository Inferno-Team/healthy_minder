import 'package:healthy_minder/models/channel.dart';

class SavedUser {
  final String username;
  final String imageUrl;
  final String email;
  final int id;
  final List<Channel> channels;

  SavedUser({
    required this.username,
    required this.imageUrl,
    required this.email,
    required this.id,
    required this.channels,
  });

  factory SavedUser.empty() => SavedUser(
        username: '',
        email: '',
        id: -1,
        imageUrl: '',
        channels: [],
      );

  factory SavedUser.fromJson(dynamic json) => SavedUser(
        username: json['username'] ?? '',
        imageUrl: json['avatar'] ?? '',
        email: json['email'] ?? '',
        id: json['id'] ?? -1,
        channels: Channel.fromJsonList(json['channels']),
      );

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "imageUrl": imageUrl,
      "id": id,
      "email": email,
      "channels": channels,
    };
  }
}
