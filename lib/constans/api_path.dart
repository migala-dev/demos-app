class ApiPath {
  final String _authServiceUrl = 'http://10.0.2.2:3000/v1';
  final String _websocketService = 'ws://10.0.2.2:8080';
  final String _cacheService = 'http://10.0.2.2:8080';

  //  Auth paths
  String _getAuthPath() {
    return '$_authServiceUrl/auth';
  }

  String getSignInPath() {
    return '${_getAuthPath()}/login';
  }

  String getVerifyCodePath() {
    return '${_getAuthPath()}/verify-code';
  }

  String getRefreshTokenPath() {
    return '${_getAuthPath()}/refresh-tokens';
  }

  //  Users paths
  String getUserPath() {
    return '$_authServiceUrl/user';
  }

  String getUpdateProfileImagePath() {
    return '${getUserPath()}/avatar';
  }

  String getWebsocketServicePath() => '$_websocketService/ws?id=pruebaflutter';

  String getGetCache() => '$_cacheService/get_cache';
}
