import 'package:demos_app/constans/api_path.dart';
import 'package:demos_app/core/api/api.dart';
import 'package:demos_app/modules/auth/models/verify_code_response.model.dart';

class AuthApi {
  static final AuthApi _authApi = AuthApi._internal();

  AuthApi._internal();

  factory AuthApi() {
    return _authApi;
  }

  Future<String> signIn(String phoneNumber) async {
    String endpoint = ApiPath().getSignInPath();
    Object params = {
      'phoneNumber': phoneNumber,
    };

    final response = await Api.post(endpoint, params, null);

    return response['session'];
  }

  Future<VerifyCodeReponse> verifyCode(
      String code, String phoneNumber, String session) async {
    String endpoint = ApiPath().getVerifyCodePath();
    Object params = {
      'phoneNumber': phoneNumber,
      'code': code,
      'session': session,
    };
    final httpResponse = await Api.post(endpoint, params, null);

    VerifyCodeReponse response = VerifyCodeReponse.fromObject(httpResponse);

    return response;
  }
}
