import 'package:demos_app/core/bloc/connection/connection_status_bloc.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/widget_validator.interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectionWidgetValidator extends StatelessWidget {
  final Widget child;
  const ConnectionWidgetValidator({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionStatusBloc, ConnectionStatusState>(
      builder: (context, connectionState) {
        if (isValidConnection(connectionState)) {
          return child;
        }
        return const SizedBox(
          height: 0,
          width: 0,
        );
      },
    );
  }

  bool isValidConnection(ConnectionStatusState connectionState) {
    return connectionState == ConnectionStatusState.connected;
  }
}

class SafeWidgetValidator extends StatelessWidget {
  final List<WidgetValidator>? validators;
  final Widget child;
  final bool safeInternetConnectionMode;

  const SafeWidgetValidator(
      {Key? key,
      this.validators,
      required this.child,
      this.safeInternetConnectionMode = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: validate(),
      builder: (context, snapshot) {
        bool isValid = snapshot.data != null && snapshot.data!;
        if (isValid) {
          return safeInternetConnectionMode
              ? ConnectionWidgetValidator(
                  child: child,
                )
              : child;
        }
        return const SizedBox(
          height: 0,
          width: 0,
        );
      },
    );
  }

  Future<bool> validate() async {
    if (validators == null) {
      return true;
    } else {
      List<bool> validatosResult =
          await Future.wait(validators!.map((v) => v.canActivate()).toList());

      return validatosResult.every((r) => r);
    }
  }
}
