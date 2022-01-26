import 'package:demos_app/modules/proposals/pages/new_proposal/screens/answer_step/models/manifesto_option_view.model.dart';
import 'package:demos_app/modules/spaces/pages/new_proposal/screens/answer_step/widgets/add_proposal_answer.widget.dart';
import 'package:demos_app/modules/spaces/pages/new_proposal/screens/answer_step/widgets/proposal_answer.widget.dart';
import 'package:flutter/material.dart';

class MultipleOptionWidget extends StatefulWidget {
  const MultipleOptionWidget({Key? key}) : super(key: key);

  @override
  State<MultipleOptionWidget> createState() => _MultipleOptionWidgetState();
}

class _MultipleOptionWidgetState extends State<MultipleOptionWidget> {
  List<ManifestoOptionView> options = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...options
            .map((option) => ProposalAnswerWidget(
                  title: option.title,
                  onEdit: (title) {
                    setState(() {
                      option.title = title;
                      //onOptionsChange(options);
                    });
                  },
                ))
            .toList(),
        AddProposalAnswer(add: (title) {
          setState(() {
            options.add(ManifestoOptionView(title: title));
          });
        }),
        // TODO: ADD REMOVE_OPTION
      ],
    );
    ;
  }
}
