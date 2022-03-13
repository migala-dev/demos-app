import 'package:demos_app/core/enums/manifesto_option_type.enum.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form_bloc.events.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/models/proposal_form_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/forms/option_step/models/dropdown_manifesto_option.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/forms/option_step/widgets/manifesto_option.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/forms/option_step/widgets/multiple_option.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OptionsForm extends StatefulWidget {

  const OptionsForm({
    Key? key,
  }) : super(key: key);

  @override
  _OptionsFormState createState() => _OptionsFormState();
}

class _OptionsFormState extends State<OptionsForm> {
  List<DropdownManifestoItem> items = [];

  @override
  void initState() {
    super.initState();
    items = [
      DropdownManifestoItem(
        label: 'A favor/En contra',
        optionType: ManifestoOptionType.inFavorOrOpposing,
        getWidget: getInFavorOrOpposingWidget,
      ),
      DropdownManifestoItem(
        label: 'Opción multiple',
        optionType: ManifestoOptionType.multipleOptions,
        getWidget: getMultipleOptionsWidget,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProposalFormBloc, ProposalFormView>(
      bloc: ProposalFormBloc(),
      builder: (context, proposalFormView) {
        DropdownManifestoItem optionTypeSelected = items.firstWhere(
            (element) => element.optionType == proposalFormView.optionType);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Votaciones de: ', style: TextStyle(color: Colors.grey)),
            DropdownButtonHideUnderline(
              child: DropdownButton<DropdownManifestoItem>(
                items: items.map(buildMenuItem).toList(),
                isExpanded: true,
                onChanged: (value) {
                  ProposalFormBloc()
                      .add(ProposalFormOnOptionTypeChange(value!.optionType));
                },
                value: optionTypeSelected,
              ),
            ),
            const SizedBox(height: 24),
            const Text('Opciones', style: TextStyle(color: Colors.grey)),
            optionTypeSelected.getWidget()
          ],
        );
      },
    );
  }

  DropdownMenuItem<DropdownManifestoItem> buildMenuItem(
          DropdownManifestoItem item) =>
      DropdownMenuItem(
        value: item,
        child: Text(item.label),
      );

  Widget getInFavorOrOpposingWidget() {
    return Column(
      children: const [
        ManifestoOptionWidget(title: 'A favor'),
        ManifestoOptionWidget(title: 'En contra'),
      ],
    );
  }

  Widget getMultipleOptionsWidget() {
    return const MultipleOptionWidget();
  }
}
