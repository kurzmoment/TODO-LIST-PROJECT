import 'package:flutter/material.dart';
import 'package:todoList/util/colors.dart';

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: kContentColorLightTheme,
    //appBarTheme:
    iconTheme: IconThemeData(color: kContentColorDarkTheme),
    colorScheme: ColorScheme.dark().copyWith(
        primary: kPrimaryColor, secondary: kSecondaryColor, error: kErrorColor),
  );
}
