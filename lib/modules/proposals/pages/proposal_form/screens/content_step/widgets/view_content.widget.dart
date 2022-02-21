import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class ViewContent extends StatelessWidget {
  const ViewContent({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final quill.QuillController controller;

  @override
  Widget build(BuildContext context) {
    if (controller.document.isEmpty()) {
      return const Text('Ingresa el contenido de tu propuesta aquí.');
    } else {
      return getViewContent();
    }
  }

  Widget getViewContent() {
    return quill.QuillEditor(
      controller: controller,
      scrollController: ScrollController(),
      scrollable: true,
      focusNode: FocusNode(),
      autoFocus: false,
      readOnly: true,
      expands: false,
      showCursor: false,
      padding: EdgeInsets.zero,
    );
  }
}
