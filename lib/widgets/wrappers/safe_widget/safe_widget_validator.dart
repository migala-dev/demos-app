import 'package:demos_app/core/bloc/connection/connection_status_bloc.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/widget_validator.interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SafeWidgetValidator extends StatefulWidget {
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
  State<SafeWidgetValidator> createState() => _SafeWidgetValidatorState();
}

class _SafeWidgetValidatorState extends State<SafeWidgetValidator> {
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    runValidations();
  }

  void runValidations() async {
    bool isValid = await validate();
    setState(() {
      this.isValid = isValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionStatusBloc, ConnectionStatusState>(
      builder: (context, connectionState) {
        if (isValid && isValidConnection(connectionState)) {
          return widget.child;
        }
        return const SizedBox(
          height: 0,
          width: 0,
        );
      },
    );
  }

  Future<bool> validate() async {
    if (widget.validators == null) {
      return true;
    } else {
      List<bool> validatosResult = await Future.wait(
          widget.validators!.map((v) => v.canActivate()).toList());

      return validatosResult.every((r) => r);
    }
  }

  bool isValidConnection(ConnectionStatusState connectionState) {
    return !widget.safeInternetConnectionMode ||
        connectionState == ConnectionStatusState.connected;
  }
}
