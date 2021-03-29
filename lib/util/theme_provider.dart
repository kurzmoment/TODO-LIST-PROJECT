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

// ZBYVA DODELAT URCITE BARVY, NA TO SE ZITRA VRHNU
class MyThemes {
  static final darkTheme = ThemeData(
    fontFamily: 'OpenSans',
    dividerColor: Colors.white60,
    cardColor: Colors.black,
    appBarTheme: AppBarTheme(color: Colors.black),
    bottomAppBarColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.white),
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: ColorScheme.dark(),
  );
  static final lightTheme = ThemeData(
      fontFamily: 'OpenSans',
      dividerColor: Colors.black54,
      cardColor: HexColor('#dfcdaa'),
      buttonColor: Colors.black,
      appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          color: HexColor('A1E7F7'),
          actionsIconTheme: IconThemeData(color: Colors.black),
          foregroundColor: Colors.black),
      bottomAppBarColor: HexColor('FCEDC5'),
      iconTheme: IconThemeData(color: Colors.black),
      scaffoldBackgroundColor: HexColor('EEFCFA'),
      colorScheme: ColorScheme.light());
}
