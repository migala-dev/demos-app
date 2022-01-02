import 'package:flutter/material.dart';
import 'package:demos_app/modules/proposals/pages/proposals_page/widgets/no_proposals.widget.dart';

class NoProposalsScreen extends StatelessWidget {
  const NoProposalsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: NoProposals());
  }
}
