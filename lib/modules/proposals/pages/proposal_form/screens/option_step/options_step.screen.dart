import 'package:demos_app/core/enums/manifesto_option_type.enum.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form_bloc.events.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/screens/option_step/models/dropdown_manifesto_option.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/screens/option_step/widgets/manifesto_option.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/screens/option_step/widgets/multiple_option.widget.dart';
import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:flutter/material.dart';

class OptionsStepScreen extends StatefulWidget {
  final VoidCallback confirmPublishProposal;

  const OptionsStepScreen({
    Key? key,
    required this.confirmPublishProposal,
  }) : super(key: key);

  @override
  _OptionsStepScreenState createState() => _OptionsStepScreenState();
}

class _OptionsStepScreenState extends State<OptionsStepScreen> {
  List<DropdownManifestoItem> items = [];
  DropdownManifestoItem? optionTypeSelected;

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
    optionTypeSelected = items.firstWhere(
        (element) => element.optionType == ProposalFormBloc().state.optionType);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Votaciones de: ', style: TextStyle(color: Colors.grey)),
        DropdownButtonHideUnderline(
          child: DropdownButton<DropdownManifestoItem>(
            items: items.map(buildMenuItem).toList(),
            isExpanded: true,
            onChanged: (value) {
              setState(() {
                optionTypeSelected = value;
                ProposalFormBloc()
                    .add(ProposalFormOnOptionTypeChange(value!.optionType));
              });
            },
            value: optionTypeSelected,
          ),
        ),
        const SizedBox(height: 24),
        const Text('Opciones', style: TextStyle(color: Colors.grey)),
        Expanded(
            child: optionTypeSelected != null
                ? optionTypeSelected!.getWidget()
                : Container()),
        BigButton(
          text: 'Crear',
          onPressed: () => widget.confirmPublishProposal(),
        )
      ],
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
