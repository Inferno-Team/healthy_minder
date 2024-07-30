import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/models/masseage.dart';
import 'package:healthy_minder/utils/constances.dart';
import 'package:healthy_minder/utils/storage_helper.dart';
import 'dart:convert';

class PusherSocket {
  late PusherChannelsClient client;
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
        host: Constance.hostName,
        key: 'myKey',
        port: 6002,
      );
    } else {
      //wathba.tsh-soft.pro:6001/app/test123?protocol=7&client=js&version=4.3.1&flash=false
      customOptions = const PusherChannelsOptions.fromHost(
        scheme: 'ws',
        host: Constance.hostName,
        key: 'myKey',
        port: 6001,
      );
      // customOptions = const PusherChannelsOptions.fromHost(
      //   scheme: 'ws',
      //   host: '192.168.98.43',
      //   key: 'test123', // test123
      //   port: 6001,
      // );
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
    // final channel = client.privateChannel(
    //   "vendors.3",
    //   authorizationDelegate:
    //       EndpointAuthorizableChannelTokenAuthorizationDelegate
    //           .forPrivateChannel(
    //     authorizationEndpoint: Uri.parse(
    //       'http://192.168.98.43:8000/broadcasting/auth',
    //     ),
    //     headers: {
    //       "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiOTNkNTlmOGFjMzA5MTM1OTUyNjg2ZmYzNTRiMjI3NGNkNWM2ZjQ0ZjJmNmNkMTVlNmQ5OTJiM2JhZWQyOTllODdjZWExNzBkMjFkMjQ3MmQiLCJpYXQiOjE3MjIxNzI0NTEuODA4OTU5LCJuYmYiOjE3MjIxNzI0NTEuODA4OTYxLCJleHAiOjE3NTM3MDg0NTEuNjc0MjEyLCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.KwnIIShHfcVylHA7Z6tx-f9ykWnMnacrsymCwzqAaYG3kzQFL7CaCN_elHv05Z5ee6zO9wRKJla8iWOo9eWx_fWMzzGuFn1IJcn0WZjjStHgPPV1aEZXVFtJeWf4DwuGwfhe4hYtuELDRyiUCjVeY1Bdq4gSjlFjYLa5yTg3Y_o2TuwMgS72W4ZzB0agIQKq6VgIY5UjHfmLyvBa6n3GnXxLjaTiVWEbh_hBgYzQnUB-gNM9XIsSDfzssawc1yQ_8ZO028KYjS5VfSHMByIEv8UvwMa3j15v1dKwuYIXkSvR3aiRIWv1WnOC5PwTYr0B_CZ1lsbYcqL9Vn9GGoASCaXb9KpELIGFNa6trrynj1t_o9fenuaxcnKYsjiyrS39hLYL4UB1jVVZIv2P5--ioJp0fI66_3xBxFcJsSh-ryj0pkZv_YDfrYFUuqtROAI-OF2pBJYZJyssq1xEyhthkPd3pVb0CPifnw7JlxwER_unEo34Wfg_Y0dLTJBR8UOVA996kiWqLASFh7Mau7fs1o-UBr-pccV6JqEdKa7eSypuqS3aiBXj8odUV1-JBiv_7NwyWuBFXCnSC9CBrk01DzUUlQ-_Zv3uX--s0rUv3UrHjCSWubxpKLMw2sRF9u7_hHcN0-STy9O1GC5Fg5WtpfpmZETK0VkapJsSJUg04Xk",
    //       "vendor" : "1"
    //     },
    //   ),
    // );
    // channel.subscribe();
    // channel.whenSubscriptionSucceeded().listen((event){
    //   print(event);
    // });
    // channel.onSubscriptionError().listen((event){
    //   print("error");
    //   print(event.data);
    // });
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
          '${Constance.fullHostName}/api/authenticate_websocket_mobile',
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
      channels[channelName] = allChatsChannel;
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

  void connectToUserChannel(
    String token,
    String channelName,
    Map<String, void Function(ChannelReadEvent data)> functions,
  ) async {
    final channel = client.presenceChannel(
      "presence-$channelName",
      authorizationDelegate:
          EndpointAuthorizableChannelTokenAuthorizationDelegate
              .forPresenceChannel(
        authorizationEndpoint: Uri.parse(
          '${Constance.fullHostName}/api/authenticate_user_private_channel',
        ),
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
    channel.subscribe();

    channel.whenSubscriptionSucceeded().listen((event) {
      print(event.name);
      for (String key in functions.keys) {
        channel.bind(key).listen(functions[key]);
      }
    });
    channel.onSubscriptionError().listen((event) {
      print("Error");
      print(event.name);
      print(event.data);
    });
  }

  void sendTypingWhisper(String channelName, int conversationId, int userId,
      String fullName, String status) {
    PresenceChannel? allChatChannel = channels[channelName] as PresenceChannel?;
    allChatChannel?.trigger(eventName: "client-user-typing-status", data: {
      "user_id": userId,
      "chat": conversationId,
      "fullname": fullName,
      "status": status,
    });
  }

  void unSubscribeToAllChatChannel() {
    for (String key in channels.keys) {
      Channel? channel = channels[key];
      channel?.unsubscribe();
    }
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

  void disconnect() async {
    for (Channel channel in channels.values) {
      channel.unsubscribe();
    }
    await client.disconnect();
  }
}
