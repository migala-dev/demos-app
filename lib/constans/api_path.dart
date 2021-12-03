import 'package:demos_app/enviroments/enviroment.interface.dart';
import 'package:demos_app/enviroments/get_enviroment.dart';

class ApiPath {
  //  Auth paths
  String _getAuthPath() {
    Enviroment enviroment = getEnviroment();
    return '${enviroment.authServiceUrl}/auth';
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
    Enviroment enviroment = getEnviroment();
    return '${enviroment.authServiceUrl}/user';
  }

  String getUpdateProfileImagePath() {
    return '${getUserPath()}/avatar';
  }

  String getWebsocketServicePath(String userId) {
    Enviroment enviroment = getEnviroment();
    return '${enviroment.websocketServiceUrl}/$userId';
  }

  String getGetCachePath() {
    Enviroment enviroment = getEnviroment();
    return '${enviroment.cacheServiceUrl}/cache';
  }
}
