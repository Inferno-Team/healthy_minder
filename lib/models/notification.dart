class Notification {
  final String id;
  final String title;
  final String body;
  final int timestamp;

  Notification(
      {required this.id,
      required this.title,
      required this.body,
      required this.timestamp});

  factory Notification.fromJson(json) => Notification(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        timestamp: json['timestamp'],
      );

  factory Notification.empty() => Notification(
        id: "",
        title: "",
        body: "",
        timestamp: -1,
      );

  static List<Notification> listFromJson(json) =>
      (json as List).map((j) => Notification.fromJson(j)).toList();
}
