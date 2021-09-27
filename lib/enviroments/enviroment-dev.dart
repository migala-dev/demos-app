import 'package:demos_app/enviroments/enviroment.interface.dart';

class EnviromentDev implements Enviroment {
  final String _authServiceUrl = 'http://10.0.2.2:3000/v1';
  final String _spaceServiceUrl = 'http://10.0.2.2:3001/v1';
  final String _cacheService = 'http://10.0.2.2:8080';
  final String _websocketService = 'ws://10.0.2.2:8080';

  @override
  String get authServiceUrl => _authServiceUrl;
  @override
  String get spaceServiceUrl => _spaceServiceUrl;

  @override
  String get cacheServiceUrl => _cacheService;

  @override
  String get websocketServiceUrl => _websocketService;
}
