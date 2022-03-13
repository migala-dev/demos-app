import 'package:demos_app/core/enums/manifesto_option_type.enum.dart';
import 'package:flutter/material.dart';

class DropdownManifestoItem {
  final String label;
  final ManifestoOptionType optionType;
  final Widget Function() getWidget;

  const DropdownManifestoItem(
      {required this.label, required this.optionType, required this.getWidget});
}
