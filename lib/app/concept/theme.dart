import 'package:flutter/material.dart';
import 'package:nado_client_mvp/app/concept/colors.dart';

final TextTheme appTextTheme = TextTheme(
  headline1: TextStyle(
    fontSize: 48.0,
    fontWeight: FontWeight.normal,
  ),
  headline2: TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.normal,
  ),
  headline3: TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
  ),
  headline4: TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  ),
  headline5: TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  ),
  headline6: TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
  ),
  subtitle1: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  ),
  subtitle2: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  ),
  bodyText1: TextStyle(
    fontSize: 16,
  ),
  bodyText2: TextStyle(
    fontSize: 14,
  ),
  caption: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  ),
);

final greyTextTheme = appTextTheme.apply(
  bodyColor: NadoColor.greyColor[500],
  displayColor: NadoColor.greyColor[500],
);

AppBarTheme appBarTheme = AppBarTheme(
  centerTitle: true,
  backgroundColor: Colors.white,
  foregroundColor: NadoColor.greyColor[500],
  shadowColor: Colors.transparent,
  actionsIconTheme: IconThemeData(color: NadoColor.greyColor, size: 29.0),
  titleTextStyle: TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
);

ColorScheme appColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: NadoColor.primary,
  secondary: NadoColor.primary,
  error: Colors.red,
  background: Colors.white,
  surface: Colors.white,
  onSecondary: NadoColor.greyColor,
  onBackground: NadoColor.greyColor,
  onError: NadoColor.greyColor,
  onPrimary: NadoColor.greyColor,
  onSurface: NadoColor.greyColor,
);

final ThemeData appThemeData = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primaryColor: NadoColor.primary,
  colorScheme: appColorScheme,
  dividerColor: NadoColor.greyColor[400],
  hintColor: NadoColor.greyColor[400],
  disabledColor: NadoColor.greyColor[400],
  unselectedWidgetColor: NadoColor.greyColor[400],
  // fontFamily:
  textTheme: greyTextTheme,
  appBarTheme: appBarTheme,
);
