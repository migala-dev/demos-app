import 'package:flutter/material.dart';

// TODO: define color palette and fonts
final ligthTheme = ThemeData.light().copyWith(
    tabBarTheme:
        ThemeData.light().tabBarTheme.copyWith(labelColor: Colors.black),
    appBarTheme: ThemeData.light().appBarTheme.copyWith(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.3,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20.0),
        textTheme: TextTheme(
            caption: TextStyle(color: Colors.black, fontSize: 20.0),
            headline6: TextStyle(color: Colors.black, fontSize: 20.0))));
