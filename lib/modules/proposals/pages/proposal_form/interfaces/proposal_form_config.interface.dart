import 'package:flutter/material.dart';

abstract class ProposalFormConfig {
  String formTitle = '';
  String primaryButtonLabel = '';

  Future<bool> openOnWillPopDialog(BuildContext context);
  void openPublishDialog(BuildContext context);
  List<Widget>? getEditorActions();
}
