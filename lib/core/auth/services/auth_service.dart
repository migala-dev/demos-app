import 'package:demos_app/constans/api_path.dart';
import 'package:demos_app/core/auth/models/verify_code_response.model.dart';
import 'package:demos_app/core/repositories/users.repository.dart';
import 'package:demos_app/utils/services/api_service.dart';
import 'package:demos_app/utils/services/bucket.service.dart';
import 'package:demos_app/utils/services/token.service.dart';
import 'package:demos_app/utils/services/user.service.dart';

class AuthService {
  String? _phoneNumber;
  String? _session;
  static final AuthService _authService = AuthService._internal();
  AuthService._internal();

  factory AuthService() {
    return _authService;
  }

  Future<bool> resendCode() async {
    return signIn(_phoneNumber ?? '');
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

  Future<bool> verifyCode(String code) async {
    String endpoint = ApiPath().getVerifyCodePath();
    Object params = {
      "phoneNumber": _phoneNumber,
      "code": code,
      "session": _session,
    };
    final httpResponse = await ApiSerivce().post(endpoint, params);

    VerifyCodeReponse response = VerifyCodeReponse.fromObject(httpResponse);

    await UsersRepository().insert(response.user);

    await UserService().setCurrentUser(response.user.userId);

    await TokenService().saveTokens(response.tokens);

    await BucketService().setBucketName(response.bucketName);

    return true;
  }
}