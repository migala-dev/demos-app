import 'dart:async';
import 'package:demos_app/constans/api_path.dart';
import 'package:demos_app/core/api/api.dart';
import 'package:demos_app/core/models/tokens.model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  String _refreshTokenKey = 'refresh-token';
  String? _accessToken;
  static TokenService _tokenService = new TokenService._internal();
  final _storage = new FlutterSecureStorage();

  TokenService._internal() {
    refreshTokens();
    createJobToRequestNewAccessToken();
  }

  factory TokenService() {
    return _tokenService;
  }

  String? get accessToken => this._accessToken;

  Future<void> saveTokens(Tokens tokens) async {
    this._accessToken = tokens.accessToken;
    await _storage.write(key: _refreshTokenKey, value: tokens.refreshToken);
  }

  Future<bool> isAuthenticate() async {
    String? value = await _getRefreshToken();

    return value != null;
  }

  void createJobToRequestNewAccessToken() {
    Duration duration = new Duration(hours: 20);
    Timer.periodic(duration, (timer) {
      refreshTokens();
    });
  }

  Future<bool> refreshTokens() async {
    String endpoint = ApiPath().getRefreshTokenPath();
    String? refreshToken = await _getRefreshToken();

    if (refreshToken == null) {
      return false;
    }

    Object params = {
      'refreshToken': refreshToken,
    };

    final httpResponse = await Api.post(endpoint, params);

    Tokens tokens = Tokens.fromObject(httpResponse);

    saveTokens(tokens);

    return true;
  }

  Future<String?> _getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }
}
