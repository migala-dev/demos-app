import 'package:demos_app/utils/ui/modals/open_update_string_field_modal.dart';
import 'package:flutter/material.dart';

class ProposalAnswerWidget extends StatefulWidget {
  ProposalAnswerWidget({Key? key, this.title, required this.isVisible})
      : super(key: key);
  String? title;
  late bool isVisible;

  @override
  State<ProposalAnswerWidget> createState() => _ProposalAnswerWidgetState();
}

class _ProposalAnswerWidgetState extends State<ProposalAnswerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Expanded(child: SizedBox()),
            Expanded(
              flex: 3,
              child: Text(
                widget.title ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 36,
                  child: Visibility(
                    visible: widget.isVisible,
                    child: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Colors.grey,
                      onPressed: () {},
                    ),
                  ),
                ),
                SizedBox(
                  width: 36,
                  child: IconButton(
                    icon: const Icon(Icons.edit),
                    color: Colors.blue,
                    onPressed: () => changeVisibility(),
                  ),
                ),
              ],
            )
          ],
        ),
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  void changeVisibility() {
    return setState(() {
      widget.isVisible = !widget.isVisible;
    });
  }

  void getProposalTitle(BuildContext context) async {
    String? title = await openUpdateStringFieldModal(
      context,
      title: 'title',
      hintText: 'hintText',
      initialValue: widget.title,
    );

    setState(
      () {
        if (title != null) {
          if (title.isNotEmpty) {
            widget.title = title;
          }
        }
      },
    );
  }
}
