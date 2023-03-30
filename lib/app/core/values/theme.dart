import 'package:flutter/material.dart';
import 'package:nado_client_mvp/app/core/values/colors.dart';

final TextTheme appTextTheme = TextTheme(
  displayLarge: TextStyle(
    fontSize: 48.0,
    fontWeight: FontWeight.normal,
  ),
  displayMedium: TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.normal,
  ),
  displaySmall: TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
  ),
  headlineMedium: TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  ),
  headlineSmall: TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  ),
  titleLarge: TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
  ),
  titleMedium: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  ),
  titleSmall: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  ),
  bodyLarge: TextStyle(
    fontSize: 16,
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
  ),
  bodySmall: TextStyle(
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
  dividerColor: Colors.transparent,
  hintColor: NadoColor.greyColor[400],
  disabledColor: NadoColor.greyColor[400],
  unselectedWidgetColor: NadoColor.greyColor[400],
  fontFamily: 'Pretendard',
  textTheme: greyTextTheme,
  appBarTheme: appBarTheme,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
  ),
);
