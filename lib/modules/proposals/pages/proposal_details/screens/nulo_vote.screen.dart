import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:demos_app/widgets/buttons/left_back_button.widget.dart';
import 'package:demos_app/widgets/titles/entity_title.widget.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';
import 'package:flutter/material.dart';

class NuloVoteScreen extends StatefulWidget {
  const NuloVoteScreen({Key? key}) : super(key: key);

  @override
  State<NuloVoteScreen> createState() => _NuloVoteScreenState();
}

class _NuloVoteScreenState extends State<NuloVoteScreen> {
  String reasons = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LeftBackButton(onPressed: () => Navigator.pop(context)),
            const SizedBox(height: 15),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const EntityTitle(name: 'Nulo', type: 'Voto'),
                const Spacer(flex: 1),
                const Text('Motivos'),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      reasons = value;
                    });
                  },
                  maxLines: 3,
                  maxLength: 120,
                ),
                const Spacer(flex: 3),
                SafeWidgetValidator(
                    child: BigButton(
                  text: 'Confirmar',
                  onPressed: () => confirmNuloVote(context),
                  disabled: reasons.isEmpty,
                ))
              ],
            ))
          ],
        ),
      ),
    );
  }

  void confirmNuloVote(BuildContext context) {
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
