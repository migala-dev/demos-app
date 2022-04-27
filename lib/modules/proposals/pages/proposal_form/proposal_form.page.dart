/*
  DEMOS
  Copyright (C) 2022 Julian Alejandro Ortega Zepeda, Erik Ivanov Domínguez Rivera, Luis Ángel Meza Acosta
  This file is part of DEMOS.

  DEMOS is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  DEMOS is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/interfaces/proposal_form_config.interface.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/models/proposal_form_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/proposal_form_config/get_proposal_form_config.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/forms/content_step/content.form.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/forms/option_step/options.form.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/utils/is_valid_number_of_options.dart';
import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProposalFormScreen extends StatefulWidget {
  const ProposalFormScreen({Key? key}) : super(key: key);

  @override
  _ProposalFormScreenState createState() => _ProposalFormScreenState();
}

class _ProposalFormScreenState extends State<ProposalFormScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProposalFormBloc, ProposalFormView>(
      bloc: ProposalFormBloc(),
      builder: (context, state) {
        final formConfig = getProposalFormConfigFromType(state.type);

        return WillPopScope(
          onWillPop: () => onWillPop(formConfig),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(title: Text(formConfig.formTitle)),
            body: LayoutBuilder(
              builder: (context, constraints) => ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 12.0),
                      child: Column(
                        children: [
                          Expanded(
                              child: SingleChildScrollView(
                                  child: Column(
                            children: const [
                              ContentForm(),
                              SizedBox(height: 24),
                              OptionsForm()
                            ],
                          ))),
                          SafeWidgetValidator(
                              child: getFormButtons(formConfig))
                        ],
                      )),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> onWillPop(ProposalFormConfig proposalFormConfig) async {
    ProposalFormView proposalFormView = ProposalFormBloc().state;
    if (proposalFormView.change) {
      return await proposalFormConfig.openOnWillPopDialog(context);
    }
    return true;
  }

  Widget getFormButtons(ProposalFormConfig formConfig) {
    return Column(
      children: [
        BigButton(
            text: formConfig.primaryButtonLabel,
            onPressed: () async {
              await formConfig.primaryAction();
              Navigator.pop(context);
            },
            disabled: isPrimaryButtonDisabled()),
        const SizedBox(height: 8),
        Row(
          children: [
            formConfig.showSaveDraftButton
                ? Expanded(
                    child: BigButton(
                        backgroundColor: Colors.white,
                        textColor: Colors.blue,
                        text: formConfig.saveDraftLabel,
                        onPressed: () async {
                          await formConfig.saveDraft();
                          Navigator.pop(context);
                        }),
                  )
                : Container(),
            formConfig.showSaveDraftButton
                ? const SizedBox(width: 8)
                : Container(),
            formConfig.showRemoveButton
                ? Expanded(
                    child: BigButton(
                        backgroundColor: Colors.white,
                        textColor: Colors.red.shade500,
                        text: 'Eliminar',
                        onPressed: () {
                          formConfig.remove(context);
                        }))
                : Container(),
          ],
        )
      ],
    );
  }

  bool isPrimaryButtonDisabled() {
    final bool isTitleEmpty = ProposalFormBloc().state.title.isEmpty;

    return isTitleEmpty || !isValidNumberOfOptions();
  }
}
