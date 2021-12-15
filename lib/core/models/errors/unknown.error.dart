

import 'package:demos_app/core/models/errors/error.model.dart';

class UnknownError implements IError {
  static final UnknownError _unknownError = UnknownError._internal();

  UnknownError._internal();

  factory UnknownError() {
    return _unknownError;
  }

  @override
  String get message => 'unknown';
}
