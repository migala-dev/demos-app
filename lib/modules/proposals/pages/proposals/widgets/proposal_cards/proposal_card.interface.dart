
import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';
import 'package:flutter/material.dart';

abstract class ProposalCard implements Widget {
  final ProposalView proposal;

  ProposalCard({ required this.proposal });
}