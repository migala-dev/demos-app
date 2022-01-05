import 'package:flutter/material.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:flutter_quill/widgets/editor.dart';

class ViewContent extends StatelessWidget {
  const ViewContent({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final QuillController controller;

  @override
  Widget build(BuildContext context) {
    if (controller.document.isEmpty()) {
      return const Text('Ingresa el contenido de tu propuesta aquí.');
    } else {
      return getViewContent();
    }
  }

  Widget getViewContent() {
    return QuillEditor(
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
