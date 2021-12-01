import 'package:demos_app/enviroments/enviroment.interface.dart';

class EnviromentDev implements Enviroment {
  final String _authServiceUrl = 'http://44.194.95.212:3000/v1';
  final String _spaceServiceUrl = 'http://44.194.95.212:3001/v1';
  final String _cacheService = 'http://44.194.95.212:3002/v1';
  final String _websocketService = 'ws://44.194.95.212:5000';

  @override
  String get authServiceUrl => _authServiceUrl;
  @override
  String get spaceServiceUrl => _spaceServiceUrl;

  @override
  String get cacheServiceUrl => _cacheService;

  @override
  String get websocketServiceUrl => _websocketService;
}
