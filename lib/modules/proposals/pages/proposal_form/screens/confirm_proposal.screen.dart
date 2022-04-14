import 'package:demos_app/core/enums/invitation-status.enum.dart';
import 'package:demos_app/modules/spaces/models/member_view.model.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/enums/member_type.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/widgets/members_list_view.widget.dart';
import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:flutter/material.dart';

class ConfirmProposalScreen extends StatelessWidget {
  const ConfirmProposalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close))
        ],
        leading: Container(),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Propuesta',
              style: TextStyle(color: Colors.grey),
            ),
            const Text(
              'Nombre de la propuesta',
              style: TextStyle(fontSize: 48),
            ),
            const SizedBox(height: 24),
            RichText(
              text: const TextSpan(
                text: 'Al ',
                style: TextStyle(color: Colors.black, fontSize: 18),
                children: <TextSpan>[
                  TextSpan(
                    text: 'publicar',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  TextSpan(
                    text:
                        ' la propuesta solo podrán votar los miembros actuales del espacio (3)',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(),
            ),
            Expanded(child: BigButton(text: 'Publicar', onPressed: () {}))
          ],
        ),
      ),
    );
  }
}
