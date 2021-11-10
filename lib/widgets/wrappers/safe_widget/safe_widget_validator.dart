import 'package:demos_app/widgets/wrappers/safe_widget/widget_validator.interface.dart';
import 'package:flutter/material.dart';

class SafeWidgetValidator extends StatefulWidget {
  final List<WidgetValidator> validators;
  final Widget child;

  const SafeWidgetValidator(
      {Key? key, required this.validators, required this.child})
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
    if (isValid) {
      return widget.child;
    }
    return Container();
  }

  Future<bool> validate() async {
    List<bool> validatosResult = await Future.wait(
        widget.validators.map((v) => v.canActivate()).toList());

    return validatosResult.every((r) => r);
  }
}
