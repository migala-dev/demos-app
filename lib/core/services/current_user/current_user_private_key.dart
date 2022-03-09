

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