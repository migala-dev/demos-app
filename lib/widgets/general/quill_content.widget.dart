import 'dart:convert';

import 'package:demos_app/modules/proposals/pages/proposal_form/screens/content_step/widgets/view_content.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_quill/flutter_quill.dart';

class QuillContent extends StatefulWidget {
  final String? content;

  const QuillContent({Key? key, required this.content}) : super(key: key);

  @override
  State<QuillContent> createState() => _QuillContentState();
}

class _QuillContentState extends State<QuillContent> {
  QuillController controller = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    if (widget.content == null) {
      return Container();
    }
    try {
      controller = QuillController(
          document: Document.fromJson(jsonDecode(widget.content!)),
          selection: const TextSelection.collapsed(offset: 0));
      return ViewContent(controller: controller);
    } on FormatException catch (e) {
      return Container();
    }
  }
}
