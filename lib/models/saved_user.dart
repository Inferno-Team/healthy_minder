class SavedUser {
  final String username;
  final String imageUrl;
  final String email;
  final int id;

  SavedUser({
    required this.username,
    required this.imageUrl,
    required this.email,
    required this.id,
  });

  factory SavedUser.empty() => SavedUser(
        username: '',
        email: '',
        id: -1,
        imageUrl: '',
      );

  factory SavedUser.fromJson(dynamic json) => SavedUser(
        username: json['username'] ?? '',
        imageUrl: json['avatar'] ?? '',
        email: json['email'] ?? '',
        id: json['id'] ?? -1,
      );

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "imageUrl": imageUrl,
      "id": id,
      "email": email,
    };
  }
}
