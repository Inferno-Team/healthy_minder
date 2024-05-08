import 'package:healthy_minder/models/login_response_model.dart';
import 'package:healthy_minder/models/premium_status.dart';
import 'package:healthy_minder/models/return_types.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataService {
  static final DataService _singleton = DataService._internal(debugMode: true);
  late final String baseUrl;

  factory DataService() {
    return _singleton;
  }

  DataService._internal({debugMode = false}) {
    baseUrl = debugMode ? "http://192.168.251.160:8000" : "";
  }

  Future<ReturnType<LoginResponse?>?> login(
      String email, String password) async {
    String route = "/api/login";
    Uri uri = Uri.parse("$baseUrl$route");
    ReturnType<LoginResponse?>? response =
        await _createPostRequest<LoginResponse>(
      uri: uri,
      body: {
        "email": email,
        "password": password,
      },
      fromJson: (json) => LoginResponse.fromJson(json),
      key: "data",
    );
    return response;
  }

  Future<ReturnType<PremiumStatus?>?> myPremiumStatus(String token) async {
    String route = "/api/is-premium";
    ReturnType<PremiumStatus?>? response =
        await _createGetRequest<PremiumStatus>(
      url: "$baseUrl$route",
      fromJson: (json) => PremiumStatus.fromValue(json),
      key: "status",
      headers: _createAuthHeader(token),
    );
    return response;
  }

  Future<void> sendNewMessage(
    String token,
    int channelId,
    String message,
  ) async {
    String route = "/api/send-new-message";
    Uri uri = Uri.parse("$baseUrl$route");
    _createPostRequest(
      fromJson: null,
      headers: _createAuthHeader(token),
      uri: uri,
      body: {
        "message": message,
        "channel_id": channelId.toString(),
      },
    );
  }

  Future<ReturnType<Type?>?> _createGetRequest<Type>({
    required url,
    headers,
    params,
    key,
    required Type Function(dynamic j) fromJson,
  }) async {
    var body0 = '';
    late http.Response response;
    try {
      String finalUrl = _createUrl(url, params);
      final uri = Uri.parse(finalUrl);
      response = await http.get(uri, headers: headers);
      body0 = response.body;
      Map<String, dynamic> jsonData =
          await json.decode(response.body); // Map<String,dynamic>
      return ReturnDataType(
        msg: jsonData['msg'],
        code: jsonData['code'],
        data: key != null ? fromJson(jsonData[key]) : null,
      );
    } catch (e) {
      print('something wrong $url :  $body0');
      try {
        Map<String, dynamic> jsonData = await json.decode(response.body);
        return ReturnError(
          msg: jsonData['msg'],
          code: jsonData['code'],
          errors: Error.fromListJson(jsonData['errors']),
        );
      } catch (ee) {
        return null;
      }
    }
  }

  Future<ReturnType<Type?>?> _createPostRequest<Type>({
    uri,
    body,
    headers,
    Type Function(dynamic j)? fromJson,
    String? key,
  }) async {
    var body0 = '';
    late http.Response response;
    try {
      response = await http.post(uri, body: body, headers: headers);
      body0 = response.body;
      Map<String, dynamic> jsonData =
          await json.decode(response.body); // Map<String,dynamic>
      return ReturnDataType(
        msg: jsonData['msg'],
        code: jsonData['code'],
        data: key != null ? fromJson!(jsonData[key]) : null,
      );
    } catch (e) {
      print('something wrong $uri :  $body0');
      print(e);
      try {
        Map<String, dynamic> jsonData = await json.decode(response.body);
        return ReturnError(
          msg: jsonData['msg'],
          code: jsonData['code'],
          errors: Error.fromListJson(jsonData['errors']),
        );
      } catch (ee) {
        return null;
      }
    }
  }

  String _createUrl(url, Map? params) {
    if (params == null) {
      return url;
    } else {
      var newURL = url;
      var keys = params.keys.toList();
      for (int i = 0; i < keys.length; i++) {
        if (i == 0) {
          newURL += '?${keys[i]}=${params[keys[i]]}';
        } else {
          newURL += '&${keys[i]}=${params[keys[i]]}';
        }
      }
      return newURL;
    }
  }

  Map<String, String> _createAuthHeader(String token) =>
      {"Authorization": "Bearer $token"};
}
