import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class EditProposalContentScreen extends StatefulWidget {
  const EditProposalContentScreen({Key? key}) : super(key: key);

  @override
  _EditProposalContentScreenState createState() =>
      _EditProposalContentScreenState();
}

class _EditProposalContentScreenState extends State<EditProposalContentScreen> {
  QuillController controller = QuillController.basic();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          QuillToolbar.basic(
            controller: controller,
            showAlignmentButtons: true,
            showCodeBlock: false,
            showClearFormat: false,
            showInlineCode: false,
            showStrikeThrough: false,
            showColorButton: false,
            showVideoButton: false,
            showImageButton: false,
          ),
          Padding(
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
        ],
      ),
    );
  }
}
