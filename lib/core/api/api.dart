/*
  DEMOS
  Copyright (C) 2022 Julian Alejandro Ortega Zepeda, Erik Ivanov Domínguez Rivera, Luis Ángel Meza Acosta
  This file is part of DEMOS.

  DEMOS is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  DEMOS is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'dart:convert';
import 'dart:io';
import 'package:demos_app/config/themes/cubit/api-pending.cubit.dart';
import 'package:demos_app/config/themes/cubit/request_behavior.dart';
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

  static Future<dynamic> get(
      String endpoint, RequestBehavior? requestBehavior) async {
    Future<http.Response> call =
        http.get(Uri.parse(endpoint), headers: _getDefaultHeaders());
    var response = await _handleErrors(call, requestBehavior);
    if (response!.body.isEmpty) {
      throw Error.safeToString('Body Response empty');
    }
    return jsonDecode(response.body);
  }

  static Future<dynamic> post(
      String endpoint, Object? body, RequestBehavior? requestBehavior) async {
    Map<String, String> headers =
        body != null ? _getHeadersWithApplicationJSON() : _getDefaultHeaders();
    String bodyFormatted = body != null ? json.encoder.convert(body) : '';

    Future<http.Response> call =
        http.post(Uri.parse(endpoint), headers: headers, body: bodyFormatted);
    var response = await _handleErrors(call, requestBehavior);
    return response!.body != '' ? jsonDecode(response.body) : null;
  }

  static Future<dynamic> put(
      String endpoint, Object? body, RequestBehavior? requestBehavior) async {
    Map<String, String> headers =
        body != null ? _getHeadersWithApplicationJSON() : _getDefaultHeaders();
    String bodyFormatted = body != null ? json.encoder.convert(body) : '';

    Future<http.Response> call =
        http.put(Uri.parse(endpoint), headers: headers, body: bodyFormatted);
    var response = await _handleErrors(call, requestBehavior);
    return response!.body != '' ? jsonDecode(response.body) : null;
  }

  static Future<dynamic> patch(
      String endpoint, Object? body, RequestBehavior? requestBehavior) async {
    Future<http.Response> call = http.patch(Uri.parse(endpoint),
        headers: _getHeadersWithApplicationJSON(),
        body: json.encoder.convert(body));
    var response = await _handleErrors(call, requestBehavior);
    return jsonDecode(response!.body);
  }

  static Future<dynamic> delete(
      String endpoint, RequestBehavior? requestBehavior) async {
    Future<http.Response> call = http.delete(
      Uri.parse(endpoint),
      headers: _getHeadersWithApplicationJSON(),
    );
    var response = await _handleErrors(call, requestBehavior);

    return response!.body != '' ? jsonDecode(response.body) : null;
  }

  static Future<dynamic> upload(
      String endpoint, File imageFile, RequestBehavior? requestBehavior) async {
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
    var response = await _handleErrors(call, requestBehavior);
    return jsonDecode(response!.body);
  }

  static Future<http.Response?> _handleErrors(
      Future<http.Response> call, RequestBehavior? requestBehavior) async {
    requestBehavior ??= RequestBehavior();
    try {
      http.Response response = await _loadingWrapper(call, requestBehavior);
      if (response.statusCode != 200) {
        await _handleServerErrors(response);
      }
      return response;
    } catch (err) {
      String messege = err.toString();
      if (requestBehavior.showError) {
        _displayMessageError(messege);
      }
      throw (getErrorByMessage(messege));
    }
  }

  static Future<http.Response> _loadingWrapper(
      Future<http.Response> call, RequestBehavior requestBehavior) async {
    ApiTimestamp timestamp = ApiTimestamp();
    if (requestBehavior.showLoading) {
      ApiPendingCubit().addApiTimestamp(timestamp);
    }
    try {
      http.Response response = await call;
      return response;
    } catch (err) {
      rethrow;
    } finally {
      if (requestBehavior.showLoading) {
        ApiPendingCubit().removeApiTimestamp(timestamp);
      }
    }
  }

  static Future<void> _handleServerErrors(http.Response response) async {
    var body = await jsonDecode(response.body);
    throw (body['message']);
  }

  static void _displayMessageError(String message) {
    ToastUtil.showError(ErrorMessageTraslation.getMessage(message));
  }
}
