import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'current_user_private_key.dart';

class CurrentUserStorage {
  final String _currentUserIdKey = 'current-user-id-key';
  final _storage = const FlutterSecureStorage();

  static final _currentUserStorage = CurrentUserStorage._internal();
  CurrentUserStorage._internal();
  factory CurrentUserStorage() => _currentUserStorage;

  Future<void> setCurrentUserId(String userId) async {
    await _storage.write(key: _currentUserIdKey, value: userId);
    await UserPrivateKey(userId).generatePrivateKey();
  }

  Future<String?> getCurrentUserId() async {
    String? currentUserId = await _storage.read(key: _currentUserIdKey);

    return currentUserId;
  }
}
