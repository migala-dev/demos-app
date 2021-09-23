import 'package:demos_app/core/models/role_user_space.model.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/core/models/user_space.dart';

class NewSpaceResponse {
  late Space? _space;
  late UserSpace? _userSpace;
  late RoleUserSpace? _roleUserSpace;

  Space? get space => this._space;
  UserSpace? get userSpace => this._userSpace;
  RoleUserSpace? get roleUserSpace => this._roleUserSpace;

  NewSpaceResponse.fromObject(dynamic o) {
    this._space = Space.fromObject(o["space"]);
    this._userSpace = UserSpace.fromObject(o["userSpace"]);
    this._roleUserSpace = RoleUserSpace.fromObject(o["roleUserSpace"]);
  }
}
