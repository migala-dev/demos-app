import 'package:demos_app/shared/models/option.model.dart';
import 'package:flutter/material.dart';

class SelectOptionListWidget extends StatefulWidget {
  final List<Option> options;
  final void Function(Option)? onChange;

  const SelectOptionListWidget({Key? key, this.onChange, required this.options})
      : super(key: key);

  @override
  _SelectOptionListWidgetState createState() => _SelectOptionListWidgetState();
}

class _SelectOptionListWidgetState extends State<SelectOptionListWidget> {
  Option? optionSelected;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 15),
        physics: const BouncingScrollPhysics(),
        itemCount: widget.options.length,
        itemBuilder: (BuildContext context, int position) {
          final Option option = widget.options[position];
          final bool isSelected = optionSelected?.label == option.label;
          final Color backgroundColor =
              isSelected ? Colors.blue.shade100 : Colors.white;
          return Container(
              margin: const EdgeInsets.only(bottom: 12.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(backgroundColor)),
                  onPressed: () {
                    if (widget.onChange != null) {
                      widget.onChange!(option);
                    }
                    select(option);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 8.0),
                    child: Row(
                      children: [
                        isSelected
                            ? const Icon(
                                Icons.check,
                                color: Colors.black,
                              )
                            : Container(
                                width: 18.0,
                              ),
                        Expanded(
                            child: Center(
                                child: Container(
                          margin: const EdgeInsets.only(right: 12.0),
                          child: Text(
                            option.label,
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )))
                      ],
                    ),
                  )));
        });
  }

  void select(Option option) {
    setState(() {
      optionSelected = option;
    });
  }
}
