import 'dart:convert';
import 'dart:io';
import 'package:demos_app/config/themes/cubit/api-pending.cubit.dart';
import 'package:demos_app/config/themes/cubit/throw_behavior.dart';
import 'package:demos_app/core/models/errors/get_error_by_message.dart';
import 'package:demos_app/core/services/token.service.dart';
import 'package:demos_app/utils/ui/toast.util.dart';
import 'package:http/http.dart' as http;

import 'error_message_translation.service.dart';

class Api {
  static Map<String, String> _getDefaultHeaders() {
    Map<String, String> headers = {};
    String? accessToken = TokenService().accessToken;
    if (accessToken != null) {
      headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
    }
    return headers;
  }

  static Map<String, String> _getHeadersWithApplicationJSON() {
    Map<String, String> headers = _getDefaultHeaders();
    headers['Content-Type'] = 'application/json';

    return headers;
  }

  static Future<dynamic> get(String endpoint, ThrowBehavior? throwBehavior) async {
    Future<http.Response> call =
        http.get(Uri.parse(endpoint), headers: _getDefaultHeaders());
    var response = await _handleErrors(call, throwBehavior);
    return jsonDecode(response!.body);
  }

  static Future<dynamic> post(String endpoint, Object? body, ThrowBehavior? throwBehavior) async {
    Map<String, String> headers =
        body != null ? _getHeadersWithApplicationJSON() : _getDefaultHeaders();
    String bodyFormatted = body != null ? json.encoder.convert(body) : '';

    Future<http.Response> call =
        http.post(Uri.parse(endpoint), headers: headers, body: bodyFormatted);
    var response = await _handleErrors(call, throwBehavior);
    return response!.body != '' ?jsonDecode(response.body) : null;
  }

  static Future<dynamic> patch(String endpoint, Object? body, ThrowBehavior? throwBehavior) async {
    Future<http.Response> call = http.patch(Uri.parse(endpoint),
        headers: _getHeadersWithApplicationJSON(),
        body: json.encoder.convert(body));
    var response = await _handleErrors(call, throwBehavior);
    return jsonDecode(response!.body);
  }

  static Future<dynamic> delete(String endpoint, ThrowBehavior? throwBehavior) async {
    Future<http.Response> call = http.delete(
      Uri.parse(endpoint),
      headers: _getHeadersWithApplicationJSON(),
    );
    var response = await _handleErrors(call, throwBehavior);
    return response;
  }

  static Future<dynamic> upload(String endpoint, File imageFile, ThrowBehavior? throwBehavior) async {
    var stream = http.ByteStream(imageFile.openRead());
    stream.cast();
    var length = await imageFile.length();

    var uri = Uri.parse(endpoint);

    var request = http.MultipartRequest(
      'POST',
      uri,
    );
    var multipartFile = http.MultipartFile('file', stream, length,
        filename: imageFile.path.split('/').last);

    request.headers.addAll(_getDefaultHeaders());
    request.files.add(multipartFile);

    Future<http.Response> call = http.Response.fromStream(await request.send());
    var response = await _handleErrors(call, throwBehavior);
    return jsonDecode(response!.body);
  }

  static Future<http.Response?> _handleErrors(
      Future<http.Response> call, ThrowBehavior? throwBehavior) async {
    try {
      http.Response response = await _loadingWrapper(call);
      if (response.statusCode != 200) {
        await _handleServerErrors(response);
      }
      return response;
    } catch (err) {
      throwBehavior ??= ThrowBehavior();
      String messege = err.toString();
      if (throwBehavior.showError) {
        _displayMessageError(messege);
      }
      throw (getErrorByMessage(messege));
    }
  }

  static Future<http.Response>  _loadingWrapper(Future<http.Response> call) async {
    ApiTimestamp timestamp = ApiTimestamp();
    ApiPendingCubit().addApiTimestamp(timestamp);
    http.Response response = await call;

    ApiPendingCubit().removeApiTimestamp(timestamp);

    return response;
  }

  static Future<void> _handleServerErrors(http.Response response) async {
    var body = await jsonDecode(response.body);
    throw (body['message']);
  }

  static void _displayMessageError(String message) {
    ToastUtil.showError(ErrorMessageTraslation.getMessage(message));
  }
}
