import 'package:demos_app/core/models/errors/error.model.dart';
import 'package:demos_app/core/models/errors/invitation_expired.error.dart';
import 'package:demos_app/core/models/errors/unknown.error.dart';
import 'package:demos_app/core/models/errors/user_is_not_member.error.dart';

import 'invalid_invitation_status.error.dart';

List<IError> errors = [
  UserIsNotMemberError(),
  InvitationExpiredError(),
  InvalidInvitationStatusError()
];

IError getErrorByMessage(String message) {
  IError error = errors.firstWhere((e) => e.message == message,
      orElse: () => UnknownError());

  return error;
}
