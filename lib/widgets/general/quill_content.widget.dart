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

import 'package:demos_app/modules/proposals/pages/proposal_form/forms/content_step/widgets/view_content.widget.dart';
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
    } on FormatException {
      return Container();
    }
  }
}
