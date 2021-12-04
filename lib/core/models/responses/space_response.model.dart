import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/core/models/member.model.dart';

class SpaceResponse {
  late Space _space;
  late Member _member;

  Space get space => _space;
  Member get member => _member;

  SpaceResponse.fromObject(dynamic o) {
    _space = Space.fromObject(o['space']);
    _member = Member.fromObject(o['member']);
  }
}
