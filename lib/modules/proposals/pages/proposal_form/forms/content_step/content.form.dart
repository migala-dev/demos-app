/*
  DEMOS
  Copyright (C) 2022 Julian Alejandro Ortega Zepeda, Erik Ivanov Domínguez Rivera, Luis Ángel Meza Acosta
  This file is part of DEMOS.

  DEMOS is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  DEMOS is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

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
  const ContentForm({Key? key}) : super(key: key);

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
      decoration: InputDecoration(
          labelText: 'Título de la propuesta',
          errorText: title.isEmpty ? 'El título es requerido' : null),
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
