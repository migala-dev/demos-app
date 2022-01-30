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
  List<ManifestoOptionView> options = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...options
            .map((option) => ManifestoOptionWidget(
                  title: option.title,
                  onEdit: (title) {
                    setState(() {
                      option.title = title;
                      //onOptionsChange(options);
                    });
                  },
                  onRemove: () {
                    setState(() {
                      options = options
                          .where((element) => element != option)
                          .toList();
                    });
                  },
                ))
            .toList(),
        AddManifestoOption(add: (title) {
          setState(() {
            options.add(ManifestoOptionView(title: title));
          });
        }),
      ],
    );
  }
}
