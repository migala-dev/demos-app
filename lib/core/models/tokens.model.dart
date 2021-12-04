class Tokens {
  late String _refreshToken;
  late String _accessToken;

  Tokens(this._refreshToken, this._accessToken);

  String get refreshToken => _refreshToken;
  String get accessToken => _accessToken;

  Tokens.fromObject(dynamic o) {
    _refreshToken = o['refreshToken'];
    _accessToken = o['accessToken'];
  }
}
