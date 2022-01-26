import 'package:demos_app/utils/ui/modals/open_update_string_field_modal.dart';
import 'package:flutter/material.dart';

class ProposalAnswerWidget extends StatefulWidget {
  final String? title;
  final void Function(String)? onEdit;

  // Cambiar nombre ManifestoOptionWidget
  const ProposalAnswerWidget({Key? key, this.title, this.onEdit})
      : super(key: key);

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
                widget.onEdit != null
                    ? SizedBox(
                        width: 36,
                        child: IconButton(
                            icon: const Icon(Icons.edit),
                            color: Colors.blue,
                            onPressed: () async {
                              String? title = await getProposalTitle(context);
                              if (title != null &&
                                  title.isNotEmpty &&
                                  widget.onEdit != null) {
                                widget.onEdit!(title);
                              }
                            }),
                      )
                    : Container(),
                SizedBox(
                  width: 36,
                  child: IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.grey,
                    onPressed: () {},
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

  Future<String?> getProposalTitle(BuildContext context) async {
    return await openUpdateStringFieldModal(
      context,
      title: 'Título de la respuesta',
      hintText: 'Escribe el título de tu respuesta aquí.',
      initialValue: widget.title,
    );
  }
}
