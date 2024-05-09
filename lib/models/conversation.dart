class Conversation {
  final int id;
  final String name;
  final String? avatar;
  final int channelId;

  Conversation({
    required this.id,
    required this.name,
    required this.channelId,
    required this.avatar,
  });

  factory Conversation.fromJson(json) => Conversation(
        id: json['id'],
        name: json['name'],
        avatar: json['avatar'],
        channelId: json['channel_id'],
      );

  static fromJsonList(json) =>
      (json as List).map((j) => Conversation.fromJson(j)).toList();

  toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "channel_id": channelId,
      };
}
