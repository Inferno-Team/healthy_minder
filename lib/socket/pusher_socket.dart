import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/models/masseage.dart';
import 'package:healthy_minder/utils/constances.dart';
import 'package:healthy_minder/utils/storage_helper.dart';
import 'dart:convert';

class PusherSocket {
  late final PusherChannelsClient client;
  static final PusherSocket _singleton =
      PusherSocket._internal(debugMode: true);

  final Map<String, dynamic> channels = {};

  factory PusherSocket() {
    return _singleton;
  }

  PusherSocket._internal({debugMode = false});

  Future<void> init({
    bool local = true,
  }) async {
    PusherChannelsOptions customOptions;
    if (!local) {
      customOptions = const PusherChannelsOptions.fromHost(
        scheme: 'wss',
        host: 'healthy.inferno-team.site',
        key: 'myKey',
        port: 6002,
      );
    } else {
      customOptions = const PusherChannelsOptions.fromHost(
        scheme: 'ws',
        host: Constance.hostName,
        key: 'myKey',
        port: 6001,
      );
    }
    client = PusherChannelsClient.websocket(
      options: customOptions,
      connectionErrorHandler: (exception, trace, refresh) {
        print(exception.toString());
        refresh();
      },
    );
    await client.connect();
    print("Connected");
    // final publicChannel = client.publicChannel('channelName').subscribe();
    // final myPrivateChannel = client.privateChannel(
    //   'private-channel',
    //   authorizationDelegate: _buildPrivate(),
    // );
    // myPrivateChannel.subscribe();
    // myPrivateChannel
    //     .whenSubscriptionSucceeded()
    //     .first
    //     .then((value) => print(value.data));
    // myPrivateChannel
    //     .onSubscriptionError()
    //     .first
    //     .then((value) => print(value.data));
  }

  void connectToAllChatChannel(
    String token,
    String channelName,
    void Function(Message message) onNewEvent,
    void Function(dynamic data) whenOtherIsTyping,
  ) async {
    final allChatsChannel = client.presenceChannel(
      channelName,
      authorizationDelegate:
          EndpointAuthorizableChannelTokenAuthorizationDelegate
              .forPresenceChannel(
        authorizationEndpoint: Uri.parse(
          'http://${Constance.hostName}:8000/api/authenticate_websocket_mobile',
        ),
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
    allChatsChannel.subscribe();
    allChatsChannel
        .onSubscriptionError()
        .first
        .then((value) => print(value.rootObject));
    allChatsChannel.whenSubscriptionSucceeded().first.then((value) {
      channels["presence-all-chats"] = allChatsChannel;
    });
    allChatsChannel.bind('NewMessage').listen((event) {
      Map<String, dynamic> message = json.decode(event.data);
      onNewEvent(
        Message(
          message: message['message'],
          id: message['message_id'],
          createdAt: message['created_at'],
          fullName: message['sender']['fullname'],
          isMe: message['sender']['email'] == StorageHelper.getUser().email,
          avatar: message['sender']['avatar'],
        ),
      );
    });
    allChatsChannel.bind("client-user-typing-status").listen((event) {
      whenOtherIsTyping(event.data);
    });
  }

  void sendTypingWhisper(
      int channelId, int userId, String fullName, String status) {
    PresenceChannel? allChatChannel =
        channels["presence-all-chats"] as PresenceChannel?;
    allChatChannel?.trigger(eventName: "client-user-typing-status", data: {
      "user_id": userId,
      "chat": channelId,
      "fullname": fullName,
      "status": status,
    });
  }

  void unSubscribeToAllChatChannel() {
    PresenceChannel? allChatChannel =
        channels["presence-all-chats"] as PresenceChannel?;
    allChatChannel?.unsubscribe();
  }

  EndpointAuthorizableChannelAuthorizationDelegate<
      PrivateChannelAuthorizationData> _buildPrivate() {
    return EndpointAuthorizableChannelTokenAuthorizationDelegate
        .forPrivateChannel(
      authorizationEndpoint: Uri.parse(
        'http://${Constance.hostName}:8000/api/authenticate_websocket_mobile',
      ),
      headers: const {},
    );
  }
}
