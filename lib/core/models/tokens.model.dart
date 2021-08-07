class Tokens {
  late String _refreshToken;
  late String _accessToken;

  Tokens(this._refreshToken, this._accessToken);

  String get refreshToken => this._refreshToken;
  String get accessToken => this._accessToken;

  Tokens.fromObject(dynamic o) {
    this._refreshToken = o["refreshToken"];
    this._accessToken = o["accessToken"];
  }
}
