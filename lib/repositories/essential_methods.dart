import 'package:healthy_minder/models/return_types.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

mixin EssentialMethod {
  Future<ReturnType<Type?>?> createGetRequest<Type>({
    required url,
    headers,
    params,
    String? key,
    Type Function(dynamic j)? fromJson,
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
        data: key != null ? fromJson!(jsonData[key]) : null,
      );
    } catch (e) {
      print('something wrong $url :  $body0');
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

  Future<ReturnType<Type?>?> createPostRequest<Type>({
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
      if (key != null) {
        return ReturnDataType(
          msg: jsonData['msg'],
          code: jsonData['code'],
          data: key != null ? fromJson!(jsonData[key]) : null,
        );
      } else {
        return ReturnType(
          msg: jsonData['msg'],
          code: jsonData['code'],
        );
      }
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

  Map<String, String> createAuthHeader(String token) =>
      {"Authorization": "Bearer $token"};
}