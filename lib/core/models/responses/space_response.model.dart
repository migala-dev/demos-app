import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/core/models/member.model.dart';

class SpaceResponse {
  late Space _space;
  late Member _member;

  Space get space => this._space;
  Member get member => this._member;

  SpaceResponse.fromObject(dynamic o) {
    this._space = Space.fromObject(o["space"]);
    this._member = Member.fromObject(o["member"]);
  }
}
