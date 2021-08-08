import 'package:demos_app/core/models/tokens.model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  String _refreshTokenKey = 'refresh-token';
  String? _accessToken;
  static TokenService _tokenService = new TokenService._internal();
  final _storage = new FlutterSecureStorage();

  TokenService._internal();

  factory TokenService() {
    return _tokenService;
  }

  String? get accessToken => this._accessToken;

  Future<void> saveTokens(Tokens tokens) async {
    this._accessToken = tokens.accessToken;
    await _storage.write(key: _refreshTokenKey, value: tokens.refreshToken);
  }

  Future<bool> isAuthenticate() async {
    String? value = await _storage.read(key: _refreshTokenKey);

    return value != null;
  }
}
