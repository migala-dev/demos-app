
import 'package:demos_app/core/models/member.model.dart';
import 'package:demos_app/core/models/user.model.dart';

class MemberResponse {
  late Member _member;
  late User _user;

  Member get member => this._member;
  User get user => this._user; 


  MemberResponse.fromObject(dynamic o) {
    this._member = Member.fromObject(o["member"]);
    this._user = User.fromObject(o["user"]);
  }
}