import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:flutter/material.dart';

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
              return 'El título de la propuesta es requerida';
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
            onPressed: () {},
            icon: const Icon(
              Icons.edit,
              color: Colors.blue,
            ),
          ),
          contentPadding: const EdgeInsets.only(left: 4),
        ),
        const Spacer(),
        BigButton(text: 'Continuar', onPressed: () => widget.goToNextStep()),
      ],
    );
  }
}
