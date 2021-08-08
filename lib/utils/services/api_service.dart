import 'dart:convert';
import 'dart:io';

import 'package:demos_app/utils/services/token.service.dart';
import 'package:http/http.dart' as http;

class ApiSerivce {
  Map<String, String> getDefaultHeaders() {
    Map<String, String> headers = {};
    String? accessToken = TokenService().accessToken;
    if (accessToken != null) {
      headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
    }
    return headers;
  }

  Future<http.Response> get(String endpoint) {
    return http.get(Uri.parse(endpoint), headers: getDefaultHeaders());
  }

  Future<Map<String, dynamic>> post(String endpoint, Object? body) async {
    Future<http.Response> call = http.post(Uri.parse(endpoint),
        headers: getDefaultHeaders(), body: body);
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
