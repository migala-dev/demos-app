import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/bloc/proposal_details.bloc.dart';
import 'package:demos_app/shared/models/option.model.dart';
import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:demos_app/widgets/buttons/right_close_button.widget.dart';
import 'package:demos_app/widgets/general/select_options.widget.dart';
import 'package:demos_app/widgets/titles/entity_title.widget.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';
import 'package:flutter/material.dart';

class VoteProposalScreen extends StatefulWidget {
  const VoteProposalScreen({Key? key}) : super(key: key);

  @override
  State<VoteProposalScreen> createState() => _VoteProposalScreenState();
}

class _VoteProposalScreenState extends State<VoteProposalScreen> {
  Option? optionSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          children: [
            RightCloseButton(onPressed: () => Navigator.pop(context)),
            const SizedBox(height: 15),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EntityTitle(name: getProposalName(), type: 'Propuesta'),
                const Spacer(),
                const Text('Opción'),
                Expanded(
                  flex: 3,
                  child: SafeWidgetValidator(
                      child: SelectOptionListWidget(
                    options: getOptions(),
                    onChange: (option) {
                      setState(() {
                        optionSelected = option;
                      });
                    },
                  )),
                ),
                const Spacer(),
                SafeWidgetValidator(
                    child: BigButton(
                  text: 'Votar',
                  disabled: optionSelected == null,
                  onPressed: () {
                    if (optionSelected != null) {
                      optionSelected!.accept();
                    }
                  },
                ))
              ],
            ))
          ],
        ),
      ),
    );
  }

  List<Option> getOptions() {
    return [
      Option('A favor', () {}),
      Option('En contra', () {}),
      Option('Nulo', goToNuleVoteScreen)
    ];
  }

  String getProposalName() => ProposalDetailsBloc().state!.title!;

  void goToNuleVoteScreen() => Navigator.pushNamed(context, Routes.nuloVote);
}
