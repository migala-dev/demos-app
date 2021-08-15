import 'package:demos_app/core/models/tokens.model.dart';
import 'package:demos_app/core/models/user.model.dart';

class VerifyCodeReponse {
  late User _user;
  late Tokens _tokens;
  late String _bucketName;

  User get user => this._user;
  Tokens get tokens => this._tokens;
  String get bucketName => this._bucketName;

  VerifyCodeReponse.fromObject(dynamic o) {
    this._user = User.fromObject(o["user"]);
    this._tokens = Tokens.fromObject(o["tokens"]);
    this._bucketName = o["bucketName"];
  }
}
