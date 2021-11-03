import 'package:demos_app/core/api/error_message_translation.service.dart';
import 'package:demos_app/core/errors/errors.dart';
import 'package:demos_app/core/errors/network_errors/handle_socket_exception_error.dart';
import 'package:demos_app/utils/ui/toast.util.dart';

void handleError(String message) {
  final error = getError(message);
  switch (error) {
    case SocketExceptionError:
      handleSocketExceptionError();
      break;

    default:
      ToastUtil.showError(ErrorMessageTraslation.getMessage(message));
      throw (message);
  }
}

String getError(String message) {
  final end = ':';
  final endIndex = message.indexOf(end);

  return message.substring(0, endIndex);
}
