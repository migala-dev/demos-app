import 'dart:math';
import 'package:demos_app/core/models/user.model.dart';
import 'package:flutter/material.dart';

const List<MaterialColor> primaries = <MaterialColor>[
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.deepOrange,
  Colors.brown,
  Colors.blueGrey,
];

class InvitationContact extends User {
  Color _color = primaries[Random().nextInt(primaries.length)];

  InvitationContact.withPhoneNumber(String phoneNumber)
      : super.withPhoneNumber(phoneNumber);

  Color get color => this._color;

  InvitationContact.fromUser(User user) : super.fromUserObject(user);
}
