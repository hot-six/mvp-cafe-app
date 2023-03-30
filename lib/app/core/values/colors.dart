import 'package:flutter/material.dart';

class NadoColor {
  NadoColor._();

  static const int _mainColor = 0xFF41CE91;
  static const MaterialColor primary = MaterialColor(_mainColor, <int, Color>{
    100: Color(0xFFD4FFE0),
    200: Color(0xFF6EF0B8),
    300: Color(_mainColor),
    400: Color(0xFF2EB77B),
  });

  static const int _mainGreyColor = 0xFFBEBEBE;
  static const greyColor = MaterialColor(_mainGreyColor, <int, Color>{
    100: Color(0xFFF3F3F3),
    200: Color(0xFFE4E4E4),
    300: Color(_mainGreyColor),
    400: Color(0xFF767676),
    500: Color(0xFF313131),
  });

  static const Color pink = Color(0xFFE55E7E);
  static const Color grapefruit = Color(0xFFFF6A6A);
}
