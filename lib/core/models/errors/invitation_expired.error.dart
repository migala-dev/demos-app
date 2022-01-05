import 'package:demos_app/core/models/errors/error.model.dart';

class InvitationExpiredError implements IError {
   static final InvitationExpiredError _invitationExpired = InvitationExpiredError._internal();

  InvitationExpiredError._internal();

  factory InvitationExpiredError() {
    return _invitationExpired;
  }

  @override
  String get message => 'Invitation expired.';
}
