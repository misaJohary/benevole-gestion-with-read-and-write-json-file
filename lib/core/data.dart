import 'package:flutter/material.dart';

class Data {
  static final List<String> day = [
    'Lundi',
    'Mardi',
    'Mercredi',
    'Jeudi',
    'Vendredi',
    'Samedi',
    'Dimanche'
  ];

  static final List<MaterialColor> color = [
    Colors.cyan,
    Colors.purple,
    Colors.orange,
    Colors.lightGreen,
    Colors.pink,
    Colors.brown,
    Colors.amber
  ];

  static List<String> selectedDay = [
    'Lundi',
    'Mardi',
    'Mercredi',
    'Jeudi',
    'Vendredi',
    'Samedi',
    'Dimanche'
  ];

  static bool groupByAvaibility = true;
  static bool showEmpty = false;
}
