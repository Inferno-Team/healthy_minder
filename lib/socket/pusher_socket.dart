import 'package:dart_pusher_channels/dart_pusher_channels.dart';

class PusherSocket {
  Future<void> init() async {
    const customOptions = PusherChannelsOptions.fromHost(
      scheme: 'wss',
      host: 'healthy.inferno-team.site',
      key: 'myKey',
      port: 6002,
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
    final publicChannel = client.publicChannel('channelName').subscribe();
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
