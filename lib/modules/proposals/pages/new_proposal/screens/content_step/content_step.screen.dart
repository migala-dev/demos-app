import 'dart:convert';

import 'package:demos_app/modules/proposals/pages/new_proposal/screens/content_step/widgets/view_content.widget.dart';
import 'package:demos_app/modules/proposals/pages/new_proposal/services/new_proposal_content.service.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:demos_app/shared/screens/edit_content.screen.dart';

class ContentStepScreen extends StatefulWidget {
  final VoidCallback goToNextStep;

  const ContentStepScreen({Key? key, required this.goToNextStep})
      : super(key: key);

  @override
  _ContentStepScreenState createState() => _ContentStepScreenState();
}

class _ContentStepScreenState extends State<ContentStepScreen> {
  NewProposalContentService newProposalContent = NewProposalContentService();
  QuillController controller = QuillController.basic();

  @override
  void initState() {
    if (newProposalContent.content != null) {
      controller = QuillController(
          document: Document.fromJson(jsonDecode(newProposalContent.content!)),
          selection: const TextSelection.collapsed(offset: 0));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getProposalNameField(),
          const SizedBox(height: 16),
          Expanded(child: SingleChildScrollView(child: getContentField())),
          BigButton(text: 'Continuar', onPressed: () => widget.goToNextStep())
        ],
      ),
    );
  }

  Widget getContentField() {
    return ListTile(
      title: const Text('Contenido'),
      subtitle: ViewContent(controller: controller),
      trailing: IconButton(
        onPressed: () => openContentEditor(),
        icon: const Icon(
          Icons.edit,
          color: Colors.blue,
        ),
      ),
      contentPadding: const EdgeInsets.only(left: 4),
    );
  }

  Widget getProposalNameField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Título de la propuesta'),
      initialValue: newProposalContent.title,
      textCapitalization: TextCapitalization.words,
      onChanged: (title) {
        newProposalContent.title = title;
      },
      validator: (title) {
        if (title == null || title.isEmpty) {
          return 'El título de la propuesta es requerido';
        }

        return null;
      },
    );
  }

  void openContentEditor() async {
    String? content = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                EditContentScreen(content: newProposalContent.content)));

    if (content != null) {
      setState(
        () {
          newProposalContent.content = content;
          controller = QuillController(
              document: Document.fromJson(jsonDecode(content)),
              selection: const TextSelection.collapsed(offset: 0));
        },
      );
    }
  }
}
