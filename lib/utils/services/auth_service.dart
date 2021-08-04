import 'dart:convert';

import 'package:demos_app/constans/api_path.dart';
import 'package:demos_app/utils/services/api_service.dart';

class AuthService {
  String? _phoneNumber;
  String? _session;
  static final AuthService _authService = AuthService._internal();
  AuthService._internal();

  factory AuthService() {
    return _authService;
  }

  Future<bool> signIn(String phoneNumber) async {
    String endpoint = ApiPath().getSignInPath();
    _phoneNumber = phoneNumber;
    Object params = {
      "phoneNumber": phoneNumber,
    };

    final response = await ApiSerivce().post(endpoint, params);

    _session = response['session'];

    return true;
  }

  Future<bool> verifyCode(int code) async {
    String endpoint = ApiPath().getVerifyCodePath();
    Object params = {
      "phoneNumber": _phoneNumber,
      "code": code,
      "session": _session,
    };
    final response = await ApiSerivce().post(endpoint, params);

    print(response);

    return true;
  }
}
