import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiSerivce {
  Map<String, String>? _headers = {};

  Future<http.Response> get(String endpoint) {
    return http.get(Uri.parse(endpoint), headers: _headers);
  }

  Future<Map<String, dynamic>> post(String endpoint, Object? body) async {
    Future<http.Response> call =
        http.post(Uri.parse(endpoint), headers: _headers, body: body);
    var response = await _handleErrors(call);
    return jsonDecode(response!.body);
  }

  Future<http.Response?> _handleErrors(Future<http.Response> call) async {
    try {
      http.Response response = await call;
      if (response.statusCode != 200) {
        await _handleServerErrors(response);
      }
      return response;
    } catch (err) {
      _throwMessageError(err.toString());
    }
  }

  Future<void> _handleServerErrors(http.Response response) async {
    var body = await jsonDecode(response.body);
    throw (body['message']);
  }

  void _throwMessageError(String message) {
    // TODO: Show message error
    throw (message);
  }
}
