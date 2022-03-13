import 'dart:convert';

import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form_bloc.events.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/models/proposal_form_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/forms/content_step/widgets/view_content.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:demos_app/shared/screens/edit_content.screen.dart';

class ContentForm extends StatefulWidget {

  const ContentForm({Key? key })
      : super(key: key);

  @override
  _ContentFormState createState() => _ContentFormState();
}

class _ContentFormState extends State<ContentForm> {
  QuillController controller = QuillController.basic();

  @override
  void initState() {
    String content = ProposalFormBloc().state.content;
    if (content.isNotEmpty) {
      controller = QuillController(
          document: Document.fromJson(jsonDecode(content)),
          selection: const TextSelection.collapsed(offset: 0));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProposalFormBloc, ProposalFormView>(
      bloc: ProposalFormBloc(),
      builder: (context, proposalFormView) {
        return Column(
          children: [
              getTitleField(proposalFormView.title),
              const SizedBox(height: 16),
              getContentField(proposalFormView.content)
          ],
        );
      },
    );
  }

  Widget getTitleField(String title) {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Título de la propuesta'),
      initialValue: title,
      textCapitalization: TextCapitalization.words,
      onChanged: (title) {
        ProposalFormBloc().add(ProposalFormOnTitleChange(title));
      },
      validator: (title) {
        if (title == null || title.isEmpty) {
          return 'El título de la propuesta es requerido';
        }

        return null;
      },
    );
  }

  Widget getContentField(String content) {
    return ListTile(
      title: const Text('Contenido'),
      subtitle: ViewContent(controller: controller),
      trailing: IconButton(
        onPressed: () => openContentEditor(content),
        icon: const Icon(
          Icons.edit,
          color: Colors.blue,
        ),
      ),
      contentPadding: const EdgeInsets.only(left: 4),
    );
  }

  void openContentEditor(String content) async {
  
    String? contentUpdated = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditContentScreen(content: content)));

    if (contentUpdated != null) {
      setState(
        () {
          ProposalFormBloc().add(ProposalFormOnContentChange(contentUpdated));
          controller = QuillController(
              document: Document.fromJson(jsonDecode(contentUpdated)),
              selection: const TextSelection.collapsed(offset: 0));
        },
      );
    }
  }
}
