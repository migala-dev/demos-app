import 'package:demos_app/config/routes/application.dart';
import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/core/enums/manifesto_option_type.enum.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/bloc/proposal_details.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/screens/option_step/models/manifesto_option_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_event.dart';
import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';
import 'package:demos_app/modules/proposals/services/proposal_vote.service.dart';
import 'package:demos_app/shared/models/option.model.dart';
import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:demos_app/widgets/buttons/right_close_button.widget.dart';
import 'package:demos_app/widgets/general/select_options.widget.dart';
import 'package:demos_app/widgets/titles/entity_title.widget.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class VoteProposalScreen extends StatefulWidget {
  final ProposalView proposal;

  const VoteProposalScreen({Key? key, required this.proposal})
      : super(key: key);

  @override
  State<VoteProposalScreen> createState() => _VoteProposalScreenState();
}

class _VoteProposalScreenState extends State<VoteProposalScreen> {
  Option? optionSelected;

  String get spaceId {
    return widget.proposal.spaceId;
  }

  String get proposalId {
    return widget.proposal.proposalId;
  }

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
    late List<Option> options;
    if (widget.proposal.optionType == ManifestoOptionType.inFavorOrOpposing) {
      options = getInFavorOrOpposingOptions();
    } else {
      options = getManifestoOptions();
    }
    return [...options, Option('Nulo', goToNullVoteScreen)];
  }

  List<Option> getInFavorOrOpposingOptions() {
    return [
      Option('A favor',
          () => _vote(() async => await ProposalVoteService().voteInFavor(spaceId, proposalId, true))),
      Option('En contra',
          () => _vote(() async => await ProposalVoteService().voteInFavor(spaceId, proposalId, true))),
    ];
  }

  List<Option> getManifestoOptions() {
    List<ManifestoOptionView> options = widget.proposal.manifestoOptions;
    return options.map<Option>((o) => Option(o.title, 
      () => 
      _vote(() async => await ProposalVoteService().voteManifestoOption(spaceId, proposalId, o.manifestoOptionId!))
    )).toList();
  }

  String getProposalName() => ProposalDetailsBloc().state!.title!;

  Future<void> _vote(Future<void> Function()vote) async {
    await vote();
    ProposalViewListBloc().add(ProposalViewListLoaded(widget.proposal.spaceId));
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void goToNullVoteScreen() {
     Application.router.navigateTo(
        context,
        Routes.nullVote,
        transition: TransitionType.inFromRight,
        routeSettings: RouteSettings(
          arguments: widget.proposal,
        )
      );
  }
}
