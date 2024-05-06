class Message {
  final String message;
  final String id;
  final DateTime createdAt;

  Message({
    required this.message,
    required this.id,
    required this.createdAt,
  });

  factory Message.fromJson(jsonData) {
    return Message(
      message: jsonData['message'],
      id: jsonData['id'],
      createdAt: DateTime.now(),
    );
  }
}
