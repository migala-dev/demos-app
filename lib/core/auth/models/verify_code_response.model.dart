import 'package:demos_app/core/models/tokens.model.dart';
import 'package:demos_app/core/models/user.model.dart';

class VerifyCodeReponse {
  late User _user;
  late Tokens _tokens;

  User get user => this._user;
  Tokens get tokens => this._tokens;

  VerifyCodeReponse.fromObject(dynamic o) {
    this._user = User.fromObject(o["user"]);
    this._tokens = Tokens.fromObject(o["tokens"]);
  }
}
