import 'package:flutter/material.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:flutter_quill/widgets/editor.dart';

class ViewContent extends StatelessWidget {
  const ViewContent({
    Key? key,
    required this.controller,
    required this.focusNode,
  }) : super(key: key);

  final QuillController controller;
  final FocusNode focusNode;

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
      focusNode: focusNode,
      autoFocus: false,
      readOnly: true,
      expands: false,
      showCursor: false,
      padding: EdgeInsets.zero,
    );
  }
}
