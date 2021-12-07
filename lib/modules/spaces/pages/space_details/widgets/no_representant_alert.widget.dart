import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/core/models/member.model.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/modules/spaces/services/member.service.dart';
import 'package:flutter/material.dart';

class NoRepresentantAlert extends StatefulWidget {
  final Space? space;

  const NoRepresentantAlert({Key? key, required this.space}) : super(key: key);

  @override
  State<NoRepresentantAlert> createState() => _NoRepresentantAlertState();
}

class _NoRepresentantAlertState extends State<NoRepresentantAlert> {
  bool showAlert = false;

  final Color fontColor = Colors.grey.shade600;

  final Color backgroundColor = Colors.orange.shade50;

  final String description =
      'Para poder tener propuestas en un espacio es necesario tener un representante, actualiza el rol de un miembro del espacio para que pueda crear una propuesta.';

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    if (widget.space != null) {

      final List<Member> representatives =
          await MemberService().getRepresentatives(widget.space!.spaceId!);

      if (representatives.isEmpty) {
        setState(() {
          showAlert = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!showAlert) {
      return Container();
    }
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: Colors.orange.shade200, width: 1.5),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.warning,
                size: 55,
                color: fontColor,
              ),
              Column(
                children: [
                  Text('Aun no tienes ningun representante',
                      style: TextStyle(color: fontColor)),
                  ElevatedButton(
                      onPressed: () => goToMembers(context),
                      child: const Text('Agrega el primero'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.orange.shade300,
                          minimumSize: const Size(245, 25)))
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(color: fontColor),
          )
        ],
      ),
    );
  }

  void goToMembers(BuildContext context) =>
      Navigator.pushNamed(context, Routes.spaceMembers);
}
