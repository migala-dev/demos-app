import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class QuillProposalController {
  QuillController controller = QuillController.basic();

  QuillController getController() {
    return controller;
  }

  String saveJson() {
    var json = jsonEncode(
        QuillProposalController().getController().document.toDelta().toJson());

    return json;
  }

  QuillController getContent() {
    var json = jsonDecode(
      jsonEncode(
        QuillProposalController().getController().document.toDelta().toJson(),
      ),
    );

    controller = QuillController(
      document: Document.fromJson(json),
      selection: const TextSelection.collapsed(offset: 0),
    );

    return controller;
  }
}
