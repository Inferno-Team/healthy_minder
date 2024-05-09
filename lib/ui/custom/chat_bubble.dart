import 'package:flutter/material.dart';
import 'package:healthy_minder/models/masseage.dart';

class ChatBubble extends StatelessWidget {
  final Message message;
  final double width;

  const ChatBubble({
    super.key,
    required this.message,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMe ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        width: width,
        padding:
            const EdgeInsets.only(left: 16, top: 24, bottom: 24, right: 24),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: message.isMe
            ? const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                color: Color.fromRGBO(251, 99, 64, 1),
              )
            : const BoxDecoration(
                color: Color.fromRGBO(52, 71, 103, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                  bottomLeft: Radius.circular(24),
                ),
              ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.fullName,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              message.message,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                message.createdAt,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _createTimeStamp(DateTime createdAt) {
    DateTime now = DateTime.now();
    Duration duration = now.difference(createdAt);
    int hour = createdAt.hour;
    int min = createdAt.minute;
    int sec = createdAt.second;
    if (duration.inHours > 24) {
      // this means show full date.
      int year = createdAt.year;
      int month = createdAt.month;
      int day = createdAt.day;
      return "$year/$month/$day $hour:$min:$sec";
    } else {
      // this means show shorter date. [hh:mm:ss]
      return "$hour:$min:$sec";
    }
  }
}
