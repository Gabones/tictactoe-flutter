import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {

  final _colorArray = [
    Colors.deepPurple,
    Colors.orange,
    Colors.amber,
    Colors.blueGrey,
    Colors.green,
    Colors.pink,
    Colors.lightBlueAccent
  ];

  Color _selectedPrimaryColor = Colors.deepPurple;

  List get getColorOptions => _colorArray;

  Color get selectedPrimaryColor => _selectedPrimaryColor;

  void setPrimaryColor(int index) {
    _selectedPrimaryColor = _colorArray[index];
    notifyListeners();
  }
}
