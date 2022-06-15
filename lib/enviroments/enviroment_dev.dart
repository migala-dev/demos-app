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

import 'package:demos_app/enviroments/enviroment.interface.dart';

class EnviromentDev implements Enviroment {
  final String _authServiceUrl = 'http://44.194.95.212:3000/v1';
  final String _spaceServiceUrl = 'http://44.194.95.212:3001/v1';
  final String _cacheService = 'http://44.194.95.212:3002/v1';
  final String _manifestoService = 'http://10.0.2.2:3003/v1';
  final String _websocketService = 'ws://44.194.95.212:5000';

  @override
  String get authServiceUrl => _authServiceUrl;
  @override
  String get spaceServiceUrl => _spaceServiceUrl;

  @override
  String get cacheServiceUrl => _cacheService;

  @override
  String get manifestoServiceUrl => _manifestoService;

  @override
  String get websocketServiceUrl => _websocketService;
}
