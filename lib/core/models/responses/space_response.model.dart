import 'package:demos_app/core/models/role_user_space.model.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/core/models/user_space.dart';

class SpaceResponse {
  late Space? _space;
  late UserSpace? _userSpace;
  late RoleUserSpace? _roleUserSpace;

  Space? get space => this._space;
  UserSpace? get userSpace => this._userSpace;
  RoleUserSpace? get roleUserSpace => this._roleUserSpace;

  SpaceResponse.fromObject(dynamic o) {
    this._space = Space.fromObject(o["space"]);
    this._userSpace = UserSpace.fromObject(o["userSpace"]);
    if (o["roleUserSpace"] != null) {
      this._roleUserSpace = RoleUserSpace.fromObject(o["roleUserSpace"]);
    } else {
      this._roleUserSpace = null;
    }
  }
}
