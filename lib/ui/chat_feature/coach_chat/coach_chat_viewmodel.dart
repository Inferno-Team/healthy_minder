import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/models/channel.dart';
import 'package:healthy_minder/models/conversation.dart';
import 'package:healthy_minder/models/loading_status.dart';
import 'package:healthy_minder/models/masseage.dart';
import 'package:healthy_minder/models/return_types.dart';
import 'package:healthy_minder/models/saved_user.dart';
import 'package:healthy_minder/repositories/data_service.dart';
import 'package:healthy_minder/socket/pusher_socket.dart';
import 'package:healthy_minder/ui/home/home_viewmodel.dart';
import 'package:healthy_minder/utils/storage_helper.dart';

class CoachChatViewModel extends GetxController {
  final DataService dataService;
  CoachChatViewModel({required this.dataService});
  final RxList<Message> _messagesList = <Message>[].obs;
  final ScrollController scrollController = ScrollController();
  late final Conversation conversation;
  Timer? _timer;
  String _inputFieldStatus = "stopped";
  final _channel = Channel.empty().obs;
  final _messageLoadingStatus = LoadingStatus.idle.obs;
  final _sendButtonDisabledStatus = false.obs;

  LoadingStatus get messageLoadingStatus => _messageLoadingStatus.value;
  get sendButtonDisabledStatus => _sendButtonDisabledStatus.value;


  List<Message> get messages => _messagesList;
  TextEditingController textController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    textController.addListener(() {
      _sendButtonDisabledStatus.value = textController.text.isEmpty;
    });
    String token = StorageHelper.getToken();
    _messageLoadingStatus.value = LoadingStatus.started;
    ReturnType<Conversation?>? res =
        await dataService.getCoachConversationWithMe(token);
    if (res != null && res is ReturnDataType<Conversation?>) {
      conversation = res.data!;
      PusherSocket().connectToAllChatChannel(
          token,
          "${conversation.channelType}-${conversation.channelName}",
          onNewMessageEvent,
          whenOtherIsTyping);
      _messageLoadingStatus.value = LoadingStatus.loading;
      ReturnType<List<Message>?>? response =
          await dataService.getConversationOldMessages(token, conversation.id);
      _messageLoadingStatus.value = LoadingStatus.finished;

      if (response is ReturnDataType) {
        _messageLoadingStatus.value = LoadingStatus.succeeded;
        List<Message>? messages =
            (response as ReturnDataType<List<Message>?>).data;
        _messagesList.addAll(messages!);
        await Future.delayed(const Duration(milliseconds: 250));
        try {
          await _scrollDown();
        } catch (e) {
          print(e);
        }
      } else {
        _messageLoadingStatus.value = LoadingStatus.failed;
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
    if (_inputFieldStatus == 'stopped') {
      _sendStartTypingWhisper();
    }
    _timer?.cancel();

    _sendStoppedTypingWhisper();
  }

  void sendNewMessage() {
    String message = textController.text;
    String token = StorageHelper.getToken();
    dataService.sendNewMessage(token, conversation.id, message);
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
        "${conversation.channelType}-${conversation.channelName}",
        conversation.id,
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
      "${conversation.channelType}-${conversation.channelName}",
      conversation.id,
      user.id,
      user.username,
      _inputFieldStatus,
    );
  }

  setChannel(Channel? channel) => _channel.value = channel ?? Channel.empty();
}
