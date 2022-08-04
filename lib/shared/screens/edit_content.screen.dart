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

import 'package:demos_app/config/themes/main_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class EditContentScreen extends StatelessWidget {
  final String? content;
  late final quill.QuillController controller;

  EditContentScreen({Key? key, required this.content}) : super(key: key) {
    if (content != null && content!.isNotEmpty) {
      controller = quill.QuillController(
          document: quill.Document.fromJson(jsonDecode(content!)),
          selection: const TextSelection.collapsed(offset: 0));
    } else {
      controller = quill.QuillController.basic();
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
      child: quill.QuillEditor(
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
    final fontSizes = {
      'Small': 'small',
      'Large': 'large',
      'Huge': 'huge',
      'Clear': '0'
    };

    final quill.QuillIconTheme iconTheme = quill.QuillIconTheme(
      iconUnselectedColor: secondaryColor,
      iconUnselectedFillColor: primaryColor,
      disabledIconColor: secondaryColorLight,
      disabledIconFillColor: primaryColorLight,
      iconSelectedColor: secondaryColor,
      iconSelectedFillColor: primaryColorDark,
    );

    const double iconSize = 22;

    return quill.QuillToolbar(
      multiRowsDisplay: false,
      toolbarSectionSpacing: 8,
      color: primaryColor,
      children: [
        quill.HistoryButton(
          icon: Icons.undo_outlined,
          controller: controller,
          undo: true,
          iconTheme: iconTheme,
        ),
        quill.HistoryButton(
          icon: Icons.redo_outlined,
          controller: controller,
          undo: false,
          iconTheme: iconTheme,
        ),
        quill.QuillFontSizeButton(
          iconTheme: iconTheme,
          iconSize: iconSize,
          items: [
            for (MapEntry<String, String> fontSize in fontSizes.entries)
              PopupMenuItem<String>(
                key: ValueKey(fontSize.key),
                value: fontSize.value,
                child: Text(fontSize.key.toString(),
                    style: TextStyle(
                        color: fontSize.value == '0' ? Colors.red : null)),
              ),
          ],
          rawItemsMap: fontSizes,
          attribute: quill.Attribute.size,
          controller: controller,
          onSelected: (newSize) {
            controller.formatSelection(quill.Attribute.fromKeyValue(
                'size', newSize == '0' ? null : getFontSize(newSize)));
          },
        ),
        quill.ToggleStyleButton(
          attribute: quill.Attribute.bold,
          icon: Icons.format_bold,
          iconSize: iconSize,
          controller: controller,
          iconTheme: iconTheme,
        ),
        quill.ToggleStyleButton(
          attribute: quill.Attribute.italic,
          icon: Icons.format_italic,
          iconSize: iconSize,
          controller: controller,
          iconTheme: iconTheme,
        ),
        quill.ToggleStyleButton(
          attribute: quill.Attribute.underline,
          icon: Icons.format_underline,
          iconSize: iconSize,
          controller: controller,
          iconTheme: iconTheme,
        ),
        quill.ColorButton(
          icon: Icons.color_lens,
          iconSize: iconSize,
          controller: controller,
          background: false,
          iconTheme: iconTheme,
        ),
        quill.ColorButton(
          icon: Icons.format_color_fill,
          iconSize: iconSize,
          controller: controller,
          background: true,
          iconTheme: iconTheme,
        ),
        quill.SelectHeaderStyleButton(
          controller: controller,
          iconSize: iconSize,
          iconTheme: iconTheme,
        ),
        quill.ToggleStyleButton(
          attribute: quill.Attribute.ol,
          controller: controller,
          icon: Icons.format_list_numbered,
          iconSize: iconSize,
          iconTheme: iconTheme,
        ),
        quill.ToggleStyleButton(
          attribute: quill.Attribute.ul,
          controller: controller,
          icon: Icons.format_list_bulleted,
          iconSize: iconSize,
          iconTheme: iconTheme,
        ),
        quill.ToggleCheckListButton(
          attribute: quill.Attribute.unchecked,
          controller: controller,
          icon: Icons.check_box,
          iconSize: iconSize,
          iconTheme: iconTheme,
        ),
        quill.IndentButton(
          icon: Icons.format_indent_increase,
          iconSize: iconSize,
          controller: controller,
          isIncrease: true,
          iconTheme: iconTheme,
        ),
        quill.IndentButton(
          icon: Icons.format_indent_decrease,
          iconSize: iconSize,
          controller: controller,
          isIncrease: false,
          iconTheme: iconTheme,
        ),
        quill.LinkStyleButton(
          controller: controller,
          iconSize: iconSize,
          iconTheme: iconTheme,
          dialogTheme: quill.QuillDialogTheme(),
        ),
      ],
    );
  }

  dynamic getFontSize(dynamic sizeValue) {
    if (sizeValue is String && ['small', 'large', 'huge'].contains(sizeValue)) {
      return sizeValue;
    }

    if (sizeValue is double) {
      return sizeValue;
    }

    if (sizeValue is int) {
      return sizeValue.toDouble();
    }

    assert(sizeValue is String);
    final fontSize = double.tryParse(sizeValue);
    if (fontSize == null) {
      throw 'Invalid size $sizeValue';
    }
    return fontSize;
  }
}
