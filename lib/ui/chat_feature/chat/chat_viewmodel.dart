import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/models/masseage.dart';
import 'package:healthy_minder/repositories/data_service.dart';
import 'package:healthy_minder/socket/pusher_socket.dart';
import 'package:healthy_minder/utils/storage_helper.dart';

class ChatViewModel extends GetxController {
  final DataService dataService;
  final RxList<Message> _messagesList = <Message>[].obs;
  final ScrollController scrollController = ScrollController();
  // TODO make it dynamic.
  final int channelId = 13;

  ChatViewModel({required this.dataService});

  List<Message> get messages => _messagesList;
  TextEditingController textController = TextEditingController();

  @override
  void onInit() async {
    String token = StorageHelper.getToken();
    PusherSocket().connectToAllChatChannel(token, onNewMessageEvent);
    super.onInit();
  }

  void onNewMessageEvent(Message message) {
    messages.add(message);
    try {
      _scrollDown();
    } catch (e) {}
  }

  void _scrollDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  void sendNewMessage() {
    String message = textController.text;
    String token = StorageHelper.getToken();
    dataService.sendNewMessage(token, channelId, message);
    textController.text = "";
  }

  // @override
  // void dispose() {
  //   PusherSocket().unSubscribeToAllChatChannel();
  //   scrollController.dispose();
  //   super.dispose();
  // }
  @override
  void onClose() {
    super.onClose();
    PusherSocket().unSubscribeToAllChatChannel();
    scrollController.dispose();
  }

}
