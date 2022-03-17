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

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class UserPrivateKey {
  final _storage = const FlutterSecureStorage();
  final String userId;

  String get _userPrivatekey => 'user-private-key_$userId';

  UserPrivateKey(this.userId);

  Future<String> generatePrivateKey() async {
    String? userPrivateKey = await _storage.read(key: _userPrivatekey);

    if (userPrivateKey != null) {
      return userPrivateKey;
    }
    Uuid uuid = const Uuid();
    String privateKey = uuid.v4();

    await _storage.write(key: _userPrivatekey, value: privateKey);

    return privateKey;
  }

  Future<String> getPrivateKey() async {
    String? userPrivateKey = await _storage.read(key: _userPrivatekey);

    return userPrivateKey!;
  }
}