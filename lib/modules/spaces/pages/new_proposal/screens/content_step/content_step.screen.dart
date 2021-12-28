import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/modules/spaces/pages/new_proposal/screens/content_step/edit_proposal_content.screen.dart';
import 'package:demos_app/modules/spaces/pages/new_proposal/screens/content_step/quill_controller.dart';
import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

class ContentStepScreen extends StatefulWidget {
  final VoidCallback goToNextStep;

  const ContentStepScreen({
    Key? key,
    required this.goToNextStep,
  }) : super(key: key);

  @override
  _ContentStepScreenState createState() => _ContentStepScreenState();
}

class _ContentStepScreenState extends State<ContentStepScreen> {
  final TextEditingController titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // QuillController controller = QuillController.basic();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextFormField(
          decoration:
              const InputDecoration(labelText: 'Título de la propuesta'),
          textCapitalization: TextCapitalization.words,
          controller: titleController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'El título de la propuesta es requerido';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        ListTile(
          title: const Text('Contenido'),
          subtitle: const Text('Ingresa el contenido de tu propuesta aqui.',
              style: TextStyle(color: Colors.blue)),
          trailing: IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, Routes.editProposalContent),
            icon: const Icon(
              Icons.edit,
              color: Colors.blue,
            ),
          ),
          contentPadding: const EdgeInsets.only(left: 4),
        ),
        QuillEditor.basic(controller: getController(), readOnly: true),
        const Spacer(),
        BigButton(text: 'Continuar', onPressed: () => widget.goToNextStep()),
      ],
    );
  }

  QuillController getController() {
    QuillController controller = QuillController.basic();

    controller = QuillProposalController().getContent();

    return controller;
  }
}
