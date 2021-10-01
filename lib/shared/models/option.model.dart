
import 'package:flutter/material.dart';

class Option {
  String? id;
  String label;
  VoidCallback accept;

  Option(this.label, this.accept);
}