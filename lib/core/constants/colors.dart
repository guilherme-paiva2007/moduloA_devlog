import 'package:flutter/material.dart' show Color, MaterialColor;

abstract final class AppColors {
  static const blue = MaterialColor(0xFF00A0B9, {
    50: Color(0xFFE5FCFF),
    100: Color(0xFFC2F7FF),
    200: Color(0xFF99F1FF),
    300: Color(0xFF66EAFF),
    400: Color(0xFF33E3FF),
    500: Color(0xFF00B0CC),
    600: Color(0xFF00B0CC),
    700: Color(0xFF008499),
    800: Color(0xFF005866),
    900: Color(0xFF00353D),
  });

  static const green = MaterialColor(0xFFD5E87F, {
    50: Color(0xFFF8FBE9),
    100: Color(0xFFEEF6CB),
    200: Color(0xFFE3EFA9),
    300: Color(0xFFD4E87D),
    400: Color(0xFFC6E052),
    500: Color(0xFFB8D827),
    600: Color(0xFF93AD1F),
    700: Color(0xFF6E8217),
    800: Color(0xFF4A5610),
    900: Color(0xFF2C3409),
  });

  static const aquamarine = MaterialColor(0xFF00BA96, {
    50: Color(0xFFE5FFFA),
    100: Color(0xFFC2FFF3),
    200: Color(0xFF99FFEB),
    300: Color(0xFF66FFE1),
    400: Color(0xFF33FFD8),
    500: Color(0xFF00CCA5),
    600: Color(0xFF00CCA5),
    700: Color(0xFF00997B),
    800: Color(0xFF006652),
    900: Color(0xFF003D31),
  });

  static const cyan = MaterialColor(0xFF3EAABA, {
    50: Color(0xFFECF7F9),
    100: Color(0xFFD1ECF0),
    200: Color(0xFFB3DFE6),
    300: Color(0xFF8CCFD9),
    400: Color(0xFF66BFCC),
    500: Color(0xFF3EAABA),
    600: Color(0xFF338C99),
    700: Color(0xFF266973),
    800: Color(0xFF1A464D),
    900: Color(0xFF0F2A2E),
  });

  static const darkBlue = MaterialColor(0xFF0067BA, {
    50: Color(0xFFE5F4FF),
    100: Color(0xFFC2E4FF),
    200: Color(0xFF99D1FF),
    300: Color(0xFF66BBFF),
    400: Color(0xFF33A4FF),
    500: Color(0xFF0071CC),
    600: Color(0xFF0071CC),
    700: Color(0xFF005599),
    800: Color(0xFF003866),
    900: Color(0xFF00223D),
  });

  static const red = MaterialColor(0xFFBD1B02, {
    50: Color(0xFFFFE9E6),
    100: Color(0xFFFECAC2),
    200: Color(0xFFFEA79A),
    300: Color(0xFFFD7C68),
    400: Color(0xFFFD5035),
    500: Color(0xFFCA1D02),
    600: Color(0xFFCA1D02),
    700: Color(0xFF971602),
    800: Color(0xFF650E01),
    900: Color(0xFF3D0901),
  });

  static const yellow = MaterialColor(0xFFBD7902, {
    50: Color(0xFFFFF6E6),
    100: Color(0xFFFEE9C2),
    200: Color(0xFFFEDA9A),
    300: Color(0xFFFDC768),
    400: Color(0xFFFDB435),
    500: Color(0xFFCA8102),
    600: Color(0xFFCA8102),
    700: Color(0xFF976102),
    800: Color(0xFF654101),
    900: Color(0xFF3D2701),
  });

  static const purple = MaterialColor(0xFF7F00BD, {
    50: Color(0xFFF7E5FF),
    100: Color(0xFFEBC2FF),
    200: Color(0xFFDE99FF),
    300: Color(0xFFCD66FF),
    400: Color(0xFFBC33FF),
    500: Color(0xFF8900CC),
    600: Color(0xFF8900CC),
    700: Color(0xFF670099),
    800: Color(0xFF450066),
    900: Color(0xFF29003D),
  });

  static const base = MaterialColor(0xFF121212, {
    50: AppBaseColor.s50,
    100: AppBaseColor.s100,
    200: AppBaseColor.s200,
    300: AppBaseColor.s300,
    400: AppBaseColor.s400,
    500: AppBaseColor.s500,
    600: AppBaseColor.s600,
    700: AppBaseColor.s700,
    800: AppBaseColor.s800,
    900: AppBaseColor.s900,
  });
}

abstract final class AppBaseColor {
    static const s50 = Color(0xFFF2F2F2);
    static const s100 = Color(0xFFE0E0E0);
    static const s200 = Color(0xFFCCCCCC);
    static const s300 = Color(0xFFB3B3B3);
    static const s400 = Color(0xFF999999);
    static const s500 = Color(0xFF8C8C8C);
    static const s600 = Color(0xFF666666);
    static const s700 = Color(0xFF4D4D4D);
    static const s800 = Color(0xFF333333);
    static const s900 = Color(0xFF1F1F1F);
}