class Conversation {
  final int id;
  final String name;
  final String? avatar;
  final int channelId;
  final String? channelName;
  final String? channelType;

  Conversation({
    required this.id,
    required this.name,
    required this.channelId,
    required this.avatar,
    this.channelName,
    this.channelType,
  });

  factory Conversation.fromJson(json) => Conversation(
        id: json['id'],
        name: json['name'],
        avatar: json['avatar'],
        channelId: json['channel_id'],
        channelName: json['channel_name'],
        channelType: json['channel_type'],
      );

  static fromJsonList(json) =>
      (json as List).map((j) => Conversation.fromJson(j)).toList();

  toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "channel_id": channelId,
        "channel_name": channelName,
      };
}
