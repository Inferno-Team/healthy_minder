import 'package:dart_pusher_channels/dart_pusher_channels.dart';

class PusherSocket {
  void init() async {
    const customOptions = PusherChannelsOptions.fromHost(
      scheme: 'ws',
      host: '192.168.251.160',
      key: 'myKey',
      port: 6001,
    );
    final client = PusherChannelsClient.websocket(
      options: customOptions,
      connectionErrorHandler: (exception, trace, refresh) {
        print(exception.toString());
        refresh();
      },
    );
    await client.connect();
    print("Connected");
    // final publicChannel = client.publicChannel('channelName').subscribe();
    final myPrivateChannel = client.privateChannel(
      'private-channel',
      authorizationDelegate: _buildPrivate(),
    );
    myPrivateChannel.subscribe();
    myPrivateChannel
        .whenSubscriptionSucceeded()
        .first
        .then((value) => print(value.data));
    myPrivateChannel
        .onSubscriptionError()
        .first
        .then((value) => print(value.data));
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
