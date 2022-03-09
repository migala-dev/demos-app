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
