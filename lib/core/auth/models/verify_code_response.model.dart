import 'package:demos_app/core/models/tokens.model.dart';
import 'package:demos_app/core/models/user.model.dart';

class VerifyCodeReponse {
  late User? _user;
  late Tokens? _tokens;
  late String? _bucketName;
  late String? _session;

  User? get user => this._user;
  Tokens? get tokens => this._tokens;
  String? get bucketName => this._bucketName;
  String? get session => this._session;

  VerifyCodeReponse.fromObject(dynamic o) {
    this._session = o["session"];
    if (o["user"] != null && o["tokens"] != null) {
      this._user = User.fromObject(o["user"]);
      this._tokens = Tokens.fromObject(o["tokens"]);
      this._bucketName = o["bucketName"];
    }
  }
}
