import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/screens/option_step/models/manifesto_option_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/screens/option_step/widgets/add_manifesto_option.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/screens/option_step/widgets/manifesto_option.widget.dart';
import 'package:flutter/material.dart';

class MultipleOptionWidget extends StatefulWidget {
  const MultipleOptionWidget({Key? key}) : super(key: key);

  @override
  State<MultipleOptionWidget> createState() => _MultipleOptionWidgetState();
}

class _MultipleOptionWidgetState extends State<MultipleOptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...ProposalFormBloc()
            .state
            .manifestoOptions
            .map((option) => ManifestoOptionWidget(
                  title: option.title,
                  onEdit: (title) {
                    setState(() {
                      option.title = title;
                    });
                  },
                  onRemove: () {
                    setState(() {
                      ProposalFormBloc().state.manifestoOptions =
                          ProposalFormBloc()
                              .state
                              .manifestoOptions
                              .where((element) => element != option)
                              .toList();
                    });
                  },
                ))
            .toList(),
        AddManifestoOption(add: (title) {
          setState(() {
            ProposalFormBloc()
                .state
                .manifestoOptions
                .add(ManifestoOptionView(title: title));
          });
        }),
      ],
    );
  }
}
