import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/models/masseage.dart';

class PusherSocket {
  late final PusherChannelsClient client;
  static final PusherSocket _singleton =
      PusherSocket._internal(debugMode: true);

  final Map<String, dynamic> channels = {};

  factory PusherSocket() {
    return _singleton;
  }

  PusherSocket._internal({debugMode = false}) {
    // baseUrl = debugMode ? "http://192.168.251.160:8000" : "";
  }

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
        host: '192.168.251.160',
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
      String token, void Function(Message message) onNewEvent) {
    final allChatsChannel = client.presenceChannel(
      "presence-all-chats",
      authorizationDelegate:
          EndpointAuthorizableChannelTokenAuthorizationDelegate
              .forPresenceChannel(
        authorizationEndpoint: Uri.parse(
          'http://192.168.251.160:8000/api/authenticate_websocket_mobile',
        ),
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
    allChatsChannel.subscribeIfNotUnsubscribed();
    allChatsChannel
        .onSubscriptionError()
        .first
        .then((value) => print(value.rootObject));
    allChatsChannel.whenSubscriptionSucceeded().first.then((value) {
      channels["presence-all-chats"] = allChatsChannel;
    });
    allChatsChannel.bindToAll().listen((event) {
      print(event.data);
      // TODO: make it only for new-message-event
      onNewEvent(
        Message(
          message: "message",
          id: "id",
          createdAt: DateTime.utc(2024, 4, 4),
        ),
      );
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
        'http://192.168.251.160:8000/api/authenticate_websocket_mobile',
      ),
      headers: const {},
    );
  }
}
