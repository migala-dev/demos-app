import 'package:flutter/material.dart';

abstract class MenuOption {
  late String name;
  late IconData icon;
  void onTap(BuildContext context) {}
}
