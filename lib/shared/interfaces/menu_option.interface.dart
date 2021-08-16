import 'package:flutter/material.dart';

abstract class MenuOption {
  late String name;
  late IconData icon;
  late void Function(BuildContext) open;
}
