import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/models/masseage.dart';

class ChatViewModel extends GetxController {
  final RxList<Message> _messagesList = <Message>[].obs;

  List<Message> get messages => _messagesList;
  TextEditingController textController = TextEditingController();

  @override
  void onInit() {
    for (var i = 0; i < 10; i++) {
      _messagesList.add(
        Message(
          message: "message",
          id: i % 2 == 0 ? "id" : "",
          createdAt: DateTime.utc(2024),
        ),
      );
    }
    super.onInit();
  }

  void sendNewMessage() {
    String msg = textController.text;
    Fluttertoast.showToast(msg: msg);
    textController.text = "";
    // TODO : send message via websocket.
  }
}
