import 'package:flutter/material.dart';

abstract class ProposalFormEditor {
  String editProposalTitle = '';
  String publishButtonLabel = '';

  Future<bool> openOnWillPopDialog(BuildContext context);
  void openPublishDialog(BuildContext context);
  List<Widget>? getEditorActions();
}
