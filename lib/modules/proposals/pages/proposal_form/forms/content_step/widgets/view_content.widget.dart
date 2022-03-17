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

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class ViewContent extends StatelessWidget {
  const ViewContent({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final quill.QuillController controller;

  @override
  Widget build(BuildContext context) {
    if (controller.document.isEmpty()) {
      return const Text('Ingresa el contenido de tu propuesta aquí.');
    } else {
      return getViewContent();
    }
  }

  Widget getViewContent() {
    return quill.QuillEditor(
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
