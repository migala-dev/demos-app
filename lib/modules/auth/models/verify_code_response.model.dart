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
