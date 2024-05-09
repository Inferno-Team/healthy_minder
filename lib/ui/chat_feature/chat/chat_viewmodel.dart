import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/models/masseage.dart';
import 'package:healthy_minder/models/return_types.dart';
import 'package:healthy_minder/models/saved_user.dart';
import 'package:healthy_minder/repositories/data_service.dart';
import 'package:healthy_minder/socket/pusher_socket.dart';
import 'package:healthy_minder/ui/home/home_viewmodel.dart';
import 'package:healthy_minder/utils/storage_helper.dart';

class ChatViewModel extends GetxController {
  final DataService dataService;
  final RxList<Message> _messagesList = <Message>[].obs;
  final ScrollController scrollController = ScrollController();
  Timer? _timer;
  String _inputFieldStatus = "stopped";
  String _currentMessage = "";

  // TODO make it dynamic.
  final int channelId = 13;

  ChatViewModel({required this.dataService});

  List<Message> get messages => _messagesList;
  TextEditingController textController = TextEditingController();

  @override
  void onInit() async {
    String token = StorageHelper.getToken();
    PusherSocket()
        .connectToAllChatChannel(token, onNewMessageEvent, whenOtherIsTyping);
    ReturnType<List<Message>?>? response =
        await dataService.getChannelOldMessages(token, channelId);
    super.onInit();
    if (response is ReturnDataType) {
      List<Message>? messages =
          (response as ReturnDataType<List<Message>?>).data;
      _messagesList.addAll(messages!);
      await Future.delayed(const Duration(milliseconds: 250));
      try {
        await _scrollDown();
      } catch (e) {
        print(e);
      }
    }
  }

  void onNewMessageEvent(Message message) async {
    messages.add(message);
    await Future.delayed(const Duration(milliseconds: 250));
    try {
      _scrollDown();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _scrollDown() async {
    await scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastOutSlowIn,
    );
  }

  void onChange(String? change) {
    _currentMessage = change ?? "";
    if (_inputFieldStatus == 'stopped') {
      _sendStartTypingWhisper();
    }
    _timer?.cancel();

    _sendStoppedTypingWhisper();
  }

  void sendNewMessage() {
    String message = textController.text;
    String token = StorageHelper.getToken();
    dataService.sendNewMessage(token, channelId, message);
    textController.text = "";
  }

  @override
  void onClose() {
    PusherSocket().unSubscribeToAllChatChannel();
    scrollController.dispose();
    _timer?.cancel();
    super.onClose();
  }

  void whenOtherIsTyping(dynamic eventData) {
    Map<String, dynamic> data = eventData;
    print(data);
    String fullName = data['fullname'];
    String status = data['status'];
    HomeViewModel homeController = Get.find<HomeViewModel>();
    if (status != 'stopped') {
      homeController.setMessage("$fullName is Typing.");
    } else {
      homeController.setMessage("");
    }
  }

  void _sendStoppedTypingWhisper() {
    _timer = Timer(const Duration(milliseconds: 1000), () {
      _inputFieldStatus = 'stopped';
      SavedUser user = StorageHelper.getUser();
      PusherSocket().sendTypingWhisper(
        channelId,
        user.id,
        user.username,
        _inputFieldStatus,
      );
    });
  }

  void _sendStartTypingWhisper() {
    _inputFieldStatus = "typing";
    SavedUser user = StorageHelper.getUser();
    PusherSocket().sendTypingWhisper(
      channelId,
      user.id,
      user.username,
      _inputFieldStatus,
    );
  }
}
