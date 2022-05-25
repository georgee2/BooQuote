import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  //appBar color(top color)
  primaryColor: Colors.blueGrey[700],
  //background color(down color)
  backgroundColor: Colors.blueGrey[800],
  iconTheme: const IconThemeData(color: Colors.white),
);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  //appBar color
  primaryColor: Colors.grey.shade300,
  //background color(down color)
  backgroundColor: Colors.white,
  iconTheme: const IconThemeData(color: Colors.black),
);