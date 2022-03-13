import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form_bloc.events.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/models/proposal_form_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/forms/option_step/models/manifesto_option_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/forms/option_step/widgets/add_manifesto_option.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/forms/option_step/widgets/manifesto_option.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultipleOptionWidget extends StatelessWidget {
  const MultipleOptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProposalFormBloc, ProposalFormView>(
      bloc: ProposalFormBloc(),
      builder: (context, proposalFormView) {
        return Column(
          children: [
            ...proposalFormView.manifestoOptions
                .map(
                  (option) => ManifestoOptionWidget(
                    title: option.title,
                    onEdit: (title) {
                      List<ManifestoOptionView> manifestoOptions =
                          proposalFormView.manifestoOptions.map((o) {
                        if (o == option) {
                          option.title = title;
                          return option;
                        }
                        return o;
                      }).toList();

                      ProposalFormBloc().add(
                          ProposalFormOnManifestoOptionsChange(
                              manifestoOptions));
                    },
                    onRemove: () {
                      List<ManifestoOptionView> manifestoOptions =
                          proposalFormView.manifestoOptions
                              .where((element) => element != option)
                              .toList();

                      ProposalFormBloc().add(
                          ProposalFormOnManifestoOptionsChange(
                              manifestoOptions));
                    },
                  ),
                )
                .toList(),
            AddManifestoOption(
              add: (title) {
                List<ManifestoOptionView> manisfestoOptions = [
                  ...proposalFormView.manifestoOptions,
                  ManifestoOptionView(title: title)
                ];
                ProposalFormBloc().add(
                    ProposalFormOnManifestoOptionsChange(manisfestoOptions));
              },
            ),
          ],
        );
      },
    );
  }
}
