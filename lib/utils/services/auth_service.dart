import 'dart:convert';

import 'package:demos_app/constans/api_path.dart';
import 'package:demos_app/utils/services/api_service.dart';

class AuthService {
  String? _session;
  static final AuthService _authService = AuthService._internal();
  AuthService._internal();

  factory AuthService() {
    return _authService;
  }

  Future<bool> signIn(String phoneNumber) async {
    String endpoint = ApiPath().getSignInPath();
    Object params = {
      phoneNumber: phoneNumber,
    };
    final response = await ApiSerivce().post(endpoint, params);

    bool itSignInSuccessfully = response.statusCode == 200;

    if (itSignInSuccessfully) {
      Map<String, dynamic> responseDecoded = jsonDecode(response.body);
      _session = responseDecoded['session'];
    }

    return itSignInSuccessfully;
  }
}
