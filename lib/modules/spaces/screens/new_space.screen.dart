import 'package:demos_app/modules/spaces/screens/space_percentages_form.screen.dart';
import 'package:flutter/material.dart';

import 'package:demos_app/modules/spaces/widgets/space_picture.widget.dart';
import 'package:demos_app/widgets/buttons/big_button_widget.dart';

class NewSpaceScreen extends StatelessWidget {
  const NewSpaceScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appBarTitle(),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
                child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                    child: Column(children: [
                      SpacePicture(),
                      SizedBox(
                        height: 25,
                      ),
                      Expanded(child: _SpaceForm())
                    ]))),
          ),
        ),
      ),
    );
  }

  Column _appBarTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Crear Espacio'),
        Text(
          'Paso 1 de 2',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        )
      ],
    );
  }
}

class _SpaceForm extends StatefulWidget {
  const _SpaceForm({
    Key? key,
  }) : super(key: key);

  @override
  _SpaceFormState createState() => _SpaceFormState();
}

class _SpaceFormState extends State<_SpaceForm> {
  final int maxLines = 4;
  final _formKey = GlobalKey<FormState>();

  int _descriptionLength = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Nombre del espacio'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nombre vacío';
                }
                return null;
              },
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              maxLines: maxLines,
              decoration: InputDecoration(
                  counterStyle: _descriptionLength > 120
                      ? TextStyle(color: Colors.red[600])
                      : null,
                  labelText: 'Descripción',
                  counterText: '$_descriptionLength/120'),
              onChanged: (desciptionValue) {
                setState(() {
                  _descriptionLength = desciptionValue.length;
                });
              },
              validator: isDescriptionValid,
            ),
            Spacer(),
            BigButton(text: 'CONTINUAR', onPressed: continueToNextStep)
          ],
        ));
  }

  String? isDescriptionValid(String? description) {
    if (description == null ||
        description.isEmpty ||
        _descriptionLength > 120) {
      return '';
    }
    return null;
  }

  void continueToNextStep() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SpacePercentagesFormScreen()));
    }
  }
}
