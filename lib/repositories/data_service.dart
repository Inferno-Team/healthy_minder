import 'package:http/http.dart' as http;
import 'dart:convert';

class DataService {
  static final DataService _singleton = DataService._internal(debugMode: false);
  late final String baseUrl;

  factory DataService() {
    return _singleton;
  }

  DataService._internal({debugMode = false}) {
    baseUrl =
        debugMode ? "http://192.168.1.8:8000" : "";
  }

  Future<Type?> _createGetRequest<Type>({
    required url,
    headers,
    params,
    required Type Function(Map<String, dynamic> j) fromJson,
  }) async {
    try {
      String finalUrl = _createUrl(url, params);
      final uri = Uri.parse(finalUrl);
      http.Response response = await http.get(uri, headers: headers);
      Map<String, dynamic> map = await json.decode(response.body);
      return fromJson(map);
    } catch (e) {
      print('something wrong $url :  $e');
    }
    return null;
  }

  Future<Type?> _createPostRequest<Type>({
    uri,
    body,
    headers,
    required Type Function(Map<String, dynamic> j) fromJson,
  }) async {
    var _body = '';
    try {
      http.Response response =
          await http.post(uri, body: body, headers: headers);
      _body = response.body;
      Map<String, dynamic> jsonData =
          await json.decode(response.body); // Map<String,dynamic>
      return fromJson(jsonData);
    } catch (e) {
      print('something wrong $uri :  $_body');
    }
    return null;
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
}
