import 'package:demos_app/constans/api_path.dart';
import 'package:demos_app/core/auth/models/verify_code_response.model.dart';
import 'package:demos_app/core/models/tokens.model.dart';
import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/core/repositories/users.repository.dart';
import 'package:demos_app/core/services/api_service.dart';
import 'package:demos_app/core/services/bucket.service.dart';
import 'package:demos_app/core/services/token.service.dart';
import 'package:demos_app/core/services/user.service.dart';
import 'package:demos_app/utils/ui/toast.util.dart';

class AuthService {
  String? _phoneNumber;
  String? _session;
  int _attemptCount = 0;
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
    _attemptCount = 3;

    return true;
  }

  Future<User?> verifyCode(String code) async {
    String endpoint = ApiPath().getVerifyCodePath();
    Object params = {
      "phoneNumber": _phoneNumber,
      "code": code,
      "session": _session,
    };
    final httpResponse = await ApiSerivce().post(endpoint, params);

    VerifyCodeReponse response = VerifyCodeReponse.fromObject(httpResponse);

    if (!_isCodeValid(response)) {
      _attemptCount -= 1;
      String message =
          'Código de verificación incorrecto, intentos restantes: $_attemptCount';
      _session = response.session;

      ToastUtil.showError(message);

      return null;
    }

    await _saveUser(response);

    await _saveTokens(response);

    await BucketService().setBucketName(response.bucketName!);

    return response.user;
  }

  bool _isCodeValid(VerifyCodeReponse response) {
    return response.session == null;
  }

  Future<void> _saveUser(VerifyCodeReponse response) async {
    User? user = response.user;
    if (user != null) {
      await UsersRepository().insert(user);

      await UserService().setCurrentUser(user.userId);
    }
  }

  Future<void> _saveTokens(VerifyCodeReponse response) async {
    Tokens? tokens = response.tokens;
    if (tokens != null) {
      await TokenService().saveTokens(tokens);
    }
  }
}
