import 'dart:ui';

import 'package:flutter/material.dart';

ColorSchemeBase theme = PastelPink();

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class ColorSchemes {
  // Color schemes by
  // https://digitalsynopsis.com/design/beautiful-color-gradients-backgrounds/
  static final Map<int, Color> lightPink = <int, Color>{
    100: HexColor("#eee3e7"),
    200: HexColor("#ead5dc"),
    300: HexColor("#eec9d2"),
    400: HexColor("#f4b6c2"),
    500: HexColor("#f6abb6"),
  };

  static final Map<int, Color> lightBlue = <int, Color>{
    100: HexColor("#bfd6f6"),
    200: HexColor("#8dbdff"),
    300: HexColor("#64a1f4"),
    400: HexColor("#4a91f2"),
    500: HexColor("#3b7dd8"),
  };

  static final List<Color> pastel = <Color>[
    HexColor("#ff8c7c"),
    HexColor("#feb2a8"),
    HexColor("#fec8c1"),
    HexColor("#fad9c1"),
    HexColor("#f2b587"),
  ];

  static final List<Color> warmFlame = <Color>[
    HexColor("#ff9a9e"),
    HexColor("#fad0c4"),
  ];

  static final List<Color> ladyLips = <Color>[
    HexColor("#ff9a9e"),
    HexColor("#fecfef"),
  ];

  static final List<Color> plumPlate = <Color>[
    HexColor("#667eea"),
    HexColor("#764ba2"),
  ];
}

class ColorSchemeBase {
  Map<int, Color> colors;

  List<Color> primaryGradient;
  List<Color> secondaryGradient;
  List<Color> titleGradient;

  Color primaryColor;
}

class PastelPink extends ColorSchemeBase {
  final Map<int, Color> colors = ColorSchemes.lightPink;

  final List<Color> primaryGradient = ColorSchemes.pastel;
  final List<Color> secondaryGradient = ColorSchemes.warmFlame;
  final List<Color> titleGradient = <Color>[
    HexColor("#ee9ca7"),
    HexColor("#fe9c8f"),
  ];

  final Color primaryColor = HexColor("#ee9ca7");
}
