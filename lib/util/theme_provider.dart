import 'package:flutter/material.dart';
import 'package:todoList/hexcolor.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    fontFamily: 'OpenSans',
    bottomAppBarColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.white),
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: ColorScheme.dark(),
  );
  static final lightTheme = ThemeData(
      fontFamily: 'OpenSans',
      bottomAppBarColor: HexColor('FCEDC5'),
      iconTheme: IconThemeData(color: Colors.black),
      scaffoldBackgroundColor: HexColor('EEFCFA'),
      colorScheme: ColorScheme.light());
}
