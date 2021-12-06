import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/core/models/member.model.dart';
import 'package:demos_app/core/models/user.model.dart';

class SpaceResponse {
  late Space _space;
  late Member _member;
  late User? _invitedBy;

  Space get space => _space;
  Member get member => _member;
  User? get invitedBy => _invitedBy;

  SpaceResponse.fromObject(dynamic o) {
    _space = Space.fromObject(o['space']);
    _member = Member.fromObject(o['member']);

    if (o['invitedBy'] != null) {
      _invitedBy = User.fromObject(o['invitedBy']);
    }
  }
}
