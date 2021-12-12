

import 'package:demos_app/core/models/errors/error.model.dart';

class UserIsNotMemberError implements IError {
   static final UserIsNotMemberError _userIsNotMemberError = UserIsNotMemberError._internal();

  UserIsNotMemberError._internal();

  factory UserIsNotMemberError() {
    return _userIsNotMemberError;
  }

  @override
  String get message => 'This user is not member of this space';
}
