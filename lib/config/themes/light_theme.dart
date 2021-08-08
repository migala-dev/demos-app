import 'package:flutter/material.dart';

// TODO: define color palette and fonts
final ligthTheme = ThemeData.light().copyWith(
    appBarTheme: ThemeData.light().appBarTheme.copyWith(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.3,
        textTheme: TextTheme(
            headline6: TextStyle(color: Colors.black, fontSize: 20.0))));
