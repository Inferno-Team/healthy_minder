import 'dart:convert';

import 'package:healthy_minder/models/conversation.dart';

class Channel {
  final int id;
  final String name;
  final ChannelType type;
  final List<Conversation> conversations;

  Channel({
    required this.id,
    required this.name,
    required this.type,
    required this.conversations,
  });

  factory Channel.fromJson(json) => Channel(
        id: json['id'],
        name: json['name'],
        type: ChannelType.values
            .firstWhere((element) => element.name == json['type']),
        conversations: Conversation.fromJsonList(json['conversations']),
      );

  factory Channel.empty() => Channel(
        id: -1,
        name: "",
        type: ChannelType.unknown,
        conversations: [],
      );

  String toJsonString() => json.encode(this);

  toJson() => {
        "id": id,
        "name": name,
        "type": type.name,
        "conversations": conversations.map((e) => e.toJson()).toList(),
      };

  static List<Channel> fromJsonList(json) =>
      (json as List).map((j) => Channel.fromJson(j)).toList();
}

enum ChannelType {
  public,
  private,
  unknown,
  presence,
}
