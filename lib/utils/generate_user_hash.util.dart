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

import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:demos_app/core/bloc/current_user_bloc/current_user_bloc.dart';
import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/core/services/current_user/current_user_private_key.dart';

Future<String> generateUserHash(String id) async {
  User currentUser = CurrentUserBloc().state!;
  String privateKey = await UserPrivateKey(currentUser.userId!).getPrivateKey();

  List<int> bytes = utf8.encode('${id}_$privateKey');
  Digest digest = sha256.convert(bytes);

  return digest.toString();
}
