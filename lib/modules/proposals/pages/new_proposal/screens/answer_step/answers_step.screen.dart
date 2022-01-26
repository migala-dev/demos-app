import 'package:demos_app/core/enums/manifesto_option_type.enum.dart';
import 'package:demos_app/modules/proposals/pages/new_proposal/screens/answer_step/widgets/multiple_option.widget.dart';
import 'package:demos_app/modules/spaces/pages/new_proposal/screens/answer_step/widgets/proposal_answer.widget.dart';
import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:flutter/material.dart';

// TODO: Cambiar esta clase a otro archivo
class DropdownManifestoItem {
  final String label;
  final ManifestoOptionType optionType;
  final Widget Function() getWidget;

  const DropdownManifestoItem(
      {required this.label, required this.optionType, required this.getWidget});
}

// TODO: Agregar la propiedad options y su metodo onChange
class AnswersStepScreen extends StatefulWidget {
  final ManifestoOptionType optionType;
  final void Function(ManifestoOptionType) onOptionTypeChange;
  final VoidCallback createProposal;

  const AnswersStepScreen(
      {Key? key,
      required this.createProposal,
      required this.optionType,
      required this.onOptionTypeChange})
      : super(key: key);

  @override
  _AnswersStepScreenState createState() => _AnswersStepScreenState();
}

class _AnswersStepScreenState extends State<AnswersStepScreen> {
  late final List<Widget> answers;
  List<DropdownManifestoItem> items = [];
  DropdownManifestoItem? optionTypeSelected;

  @override
  void initState() {
    super.initState();
    items = [
      DropdownManifestoItem(
        label: 'Votación A favor/En contra',
        optionType: ManifestoOptionType.inFavorOrOpposing,
        getWidget: getInFavorOrOpposingWidget,
      ),
      DropdownManifestoItem(
        label: 'Opción multiple',
        optionType: ManifestoOptionType.multipleOptions,
        getWidget: getMultipleOptionsWidget,
      )
    ];
    optionTypeSelected =
        items.firstWhere((element) => element.optionType == widget.optionType);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButton<DropdownManifestoItem>(
            items: items.map(buildMenuItem).toList(),
            onChanged: (value) {
              setState(() {
                optionTypeSelected = value;
                widget.onOptionTypeChange(value!.optionType);
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
          onPressed: () => widget.createProposal(),
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
        ProposalAnswerWidget(title: 'A favor'),
        ProposalAnswerWidget(title: 'En contra'),
        //ProposalAnswerWidget(title: 'En contra', editable: false),
      ],
    );
  }

  Widget getMultipleOptionsWidget() {
    return const MultipleOptionWidget();
  }
}
