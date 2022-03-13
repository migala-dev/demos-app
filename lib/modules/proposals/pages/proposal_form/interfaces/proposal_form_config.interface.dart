import 'package:flutter/material.dart';

abstract class ProposalFormConfig {
  String formTitle = '';
  String primaryButtonLabel = '';
  bool showRemoveButton = false;
  bool showSaveDraftButton = false;
  String saveDraftLabel = '';

  Future<bool> openOnWillPopDialog(BuildContext context);
  Future<void> saveDraft();
  Future<void> remove(BuildContext context);
  Future<void> primaryAction();
}
