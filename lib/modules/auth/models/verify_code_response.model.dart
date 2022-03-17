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

import 'package:demos_app/core/models/tokens.model.dart';
import 'package:demos_app/core/models/user.model.dart';

class VerifyCodeReponse {
  late User? _user;
  late Tokens? _tokens;
  late String? _bucketName;
  late String? _session;

  User? get user => _user;
  Tokens? get tokens => _tokens;
  String? get bucketName => _bucketName;
  String? get session => _session;

  VerifyCodeReponse.fromObject(dynamic o) {
    _session = o['session'];
    if (o['user'] != null && o['tokens'] != null) {
      _user = User.fromObject(o['user']);
      _tokens = Tokens.fromObject(o['tokens']);
      _bucketName = o['bucketName'];
    }
  }
}
