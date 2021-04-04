import 'package:flutter/material.dart';
import 'package:todoList/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class ThemeProvider extends ChangeNotifier {
//   ThemeMode themeMode = ThemeMode.light;
//   bool get isDarkMode => themeMode == ThemeMode.dark;

//   void toggleTheme(bool isOn) {
//     themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
//     notifyListeners();
//   }
// }

ThemeData light = ThemeData(
    fontFamily: 'OpenSans',
    dividerColor: Colors.black54,
    cardColor: HexColor('F4E6CD'),
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

ThemeData dark = ThemeData(
  fontFamily: 'OpenSans',
  dividerColor: Colors.white60,
  cardColor: Colors.black,
  appBarTheme: AppBarTheme(color: Colors.black),
  bottomAppBarColor: Colors.black,
  iconTheme: IconThemeData(color: Colors.white),
  scaffoldBackgroundColor: Colors.grey.shade900,
  colorScheme: ColorScheme.dark(),
);

class ThemeNotifier extends ChangeNotifier {
  final String key = 'theme';
  SharedPreferences _prefs;
  bool _darkTheme;

  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = true;
    _loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = _prefs.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _prefs.setBool(key, _darkTheme);
  }
}
