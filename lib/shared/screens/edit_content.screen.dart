import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class EditContentScreen extends StatelessWidget {
  final String? content;
  late final QuillController controller;

  EditContentScreen({Key? key, required this.content}) : super(key: key) {
    if (content != null) {
      controller = QuillController(
          document: Document.fromJson(jsonDecode(content!)),
          selection: const TextSelection.collapsed(offset: 0));
    } else {
      controller = QuillController.basic();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: getAppBar(context),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [Container()],
            leading: Container(),
            leadingWidth: 0,
            floating: true,
            title: getToolbar(),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: getEditor(),
          )
        ],
      ),
    );
  }

  AppBar getAppBar(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          icon: const Icon(Icons.done),
          onPressed: () {
            String json = jsonEncode(controller.document.toDelta().toJson());
            Navigator.pop(context, json);
          },
        )
      ],
    );
  }

  Widget getEditor() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: QuillEditor(
        controller: controller,
        scrollController: ScrollController(),
        scrollable: true,
        focusNode: FocusNode(),
        autoFocus: true,
        readOnly: false,
        placeholder: 'Agrega tu propuesta aquí.',
        expands: false,
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget getToolbar() {
    return QuillToolbar.basic(
      controller: controller,
      multiRowsDisplay: false,
      showAlignmentButtons: true,
      showCodeBlock: false,
      showClearFormat: false,
      showInlineCode: false,
      showStrikeThrough: false,
      showColorButton: false,
      showVideoButton: false,
      showImageButton: false,
      showListCheck: false,
      showQuote: false,
      toolbarIconSize: 22,
    );
  }
}
