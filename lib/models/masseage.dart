class Message {
  final int id;
  final String message;
  final String createdAt;
  final String? status;
  final String fullName;
  final String? avatar;
  final bool isMe;
  final int? statusId;

  Message({
    required this.id,
    required this.message,
    required this.createdAt,
    this.status,
    required this.fullName,
    this.avatar,
    required this.isMe,
    this.statusId,
  });

  factory Message.fromJson(jsonData) {
    return Message(
      message: jsonData['message'],
      id: jsonData['message_id'],
      createdAt: jsonData['created_at'],
      fullName: jsonData['full_name'],
      isMe: jsonData['is_me'],
      status: jsonData['status'],
      avatar: jsonData['avatar'],
      statusId: jsonData['status_id'],
    );
  }
}
