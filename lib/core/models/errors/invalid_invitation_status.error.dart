import 'package:demos_app/core/models/errors/error.model.dart';

class InvalidInvitationStatusError implements IError {
   static final InvalidInvitationStatusError _invalidInvitationStatusError = InvalidInvitationStatusError._internal();

  InvalidInvitationStatusError._internal();

  factory InvalidInvitationStatusError() {
    return _invalidInvitationStatusError;
  }

  @override
  String get message => 'This invitation is not in a valid status.';
}
