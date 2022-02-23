import 'package:demos_app/utils/ui/modals/open_update_string_field_modal.dart';
import 'package:flutter/material.dart';

class AddManifestoOption extends StatelessWidget {
  final void Function(String) add;

  const AddManifestoOption({Key? key, required this.add}) : super(key: key);

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
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.add, color: Colors.blue, size: 30),
                  Text(
                    'Añadir opción',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        onPressed: () async {
          String? title = await getOptionTitle(context);
          if (title != null && title.isNotEmpty) {
            add(title);
          }
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}

Future<String?> getOptionTitle(BuildContext context) async {
  return await openUpdateStringFieldModal(
    context,
    title: 'Título de la respuesta',
    hintText: 'Escribe el título de tu respuesta aquí.',
  );
}
