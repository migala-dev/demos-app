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

import 'package:demos_app/utils/ui/modals/open_update_string_field_modal.dart';
import 'package:flutter/material.dart';

class ManifestoOptionWidget extends StatefulWidget {
  final String? title;
  final void Function(String)? onEdit;
  final void Function()? onRemove;

  const ManifestoOptionWidget({
    Key? key,
    this.title,
    this.onEdit,
    this.onRemove,
  }) : super(key: key);

  @override
  State<ManifestoOptionWidget> createState() => _ManifestoOptionWidgetState();
}

class _ManifestoOptionWidgetState extends State<ManifestoOptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Expanded(child: SizedBox()),
            Expanded(
              flex: 2,
              child: Text(
                widget.title ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            widget.onEdit != null
                ? Row(
                    children: [
                      SizedBox(
                        width: 36,
                        child: IconButton(
                            icon: const Icon(Icons.edit),
                            color: Colors.blue,
                            onPressed: () async {
                              String? title = await getOptionTitle(context);
                              if (title != null &&
                                  title.isNotEmpty &&
                                  widget.onEdit != null) {
                                widget.onEdit!(title);
                              }
                            }),
                      ),
                      SizedBox(
                        width: 35,
                        child: IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.grey,
                          onPressed: () {
                            widget.onRemove!();
                          },
                        ),
                      )
                    ],
                  )
                : Expanded(child: Container()),
          ],
        ),
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Future<String?> getOptionTitle(BuildContext context) async {
    return await openUpdateStringFieldModal(
      context,
      title: 'Título de la respuesta',
      hintText: 'Escribe el título de tu respuesta aquí.',
      initialValue: widget.title,
    );
  }
}
