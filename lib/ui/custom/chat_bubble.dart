import 'package:flutter/material.dart';
import 'package:healthy_minder/models/masseage.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 32),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
          color: Color.fromRGBO(251, 99, 64, 1),
        ),
        child: Text(
          message.message,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ChatBubleForFriend extends StatelessWidget {
  const ChatBubleForFriend({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 32),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(52, 71, 103, 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
            bottomLeft: Radius.circular(24),
          ),
        ),
        child: Text(
          message.message,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
