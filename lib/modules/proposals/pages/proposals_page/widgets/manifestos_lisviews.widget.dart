import 'package:flutter/material.dart';
import 'package:demos_app/core/models/manifesto/manifesto.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals_page/widgets/proposal_card.widget.dart';

class ManifestosListView extends StatelessWidget {
  final List<Manifesto> manifestos;
  const ManifestosListView({
    Key? key,
    required this.manifestos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: manifestos.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: ProposalCard(manifesto: manifestos[index]),
        );
      },
    );
  }
}
