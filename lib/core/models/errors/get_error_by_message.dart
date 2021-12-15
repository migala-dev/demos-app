

import 'package:demos_app/core/models/errors/error.model.dart';
import 'package:demos_app/core/models/errors/unknown.error.dart';
import 'package:demos_app/core/models/errors/user_is_not_member.error.dart';

List<IError> errors = [UserIsNotMemberError()];

IError getErrorByMessage(String message) {

  IError error = errors.firstWhere((e) => e.message == message, orElse: () => UnknownError());

  return error;
}