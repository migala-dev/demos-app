import 'package:demos_app/config/routes/routes.dart';
import 'package:flutter/material.dart';

class NoRepresentantAlert extends StatelessWidget {
  NoRepresentantAlert({Key? key}) : super(key: key);

  final Color fontColor = Colors.grey.shade600;
  final Color backgroundColor = Colors.orange.shade50;
  final String description =
      'Para poder tener propuestas en un espacio es necesario tener un representante, actualiza el rol de un miembro del espacio para que pueda crear una propuesta.';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: Colors.orange.shade200, width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                      child: Text('Agrega el primero'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.orange.shade300,
                          minimumSize: Size(245, 25)))
                ],
              )
            ],
          ),
          SizedBox(height: 10),
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
