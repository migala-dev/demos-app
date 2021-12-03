import 'package:demos_app/core/models/member.model.dart';
import 'package:demos_app/core/models/user.model.dart';

class MemberResponse {
  late Member _member;
  late User _user;

  Member get member => _member;
  User get user => _user;

  MemberResponse.fromObject(dynamic o) {
    _member = Member.fromObject(o['member']);
    _user = User.fromObject(o['user']);
  }
}
