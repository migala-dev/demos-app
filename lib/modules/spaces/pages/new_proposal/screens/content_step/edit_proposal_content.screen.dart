import 'dart:convert';

import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/modules/spaces/pages/new_proposal/screens/content_step/quill_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class EditProposalContentScreen extends StatefulWidget {
  const EditProposalContentScreen({Key? key}) : super(key: key);

  @override
  _EditProposalContentScreenState createState() =>
      _EditProposalContentScreenState();
}

class _EditProposalContentScreenState extends State<EditProposalContentScreen> {
  //QuillController controller = QuillController.basic();
  final FocusNode focusNode = FocusNode();
  QuillController controller = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () {
              var json = jsonEncode(controller.document.toDelta().toJson());
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.newProposal, (route) => false,
                  arguments: json);
            },
          )
        ],
      ),
      body: Column(
        children: [
          QuillToolbar.basic(
            controller: controller,
            multiRowsDisplay: true,
            showAlignmentButtons: true,
            showCodeBlock: false,
            showClearFormat: false,
            showInlineCode: false,
            showStrikeThrough: false,
            showColorButton: false,
            showVideoButton: false,
            showImageButton: false,
            toolbarIconSize: 22,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: QuillEditor(
                controller: controller,
                scrollController: ScrollController(),
                scrollable: true,
                focusNode: focusNode,
                autoFocus: true,
                readOnly: false,
                placeholder: 'Agrega tu propuesta aquí.',
                expands: false,
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
