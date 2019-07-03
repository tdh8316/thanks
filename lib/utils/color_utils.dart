import 'dart:ui';

enum ColorScheme {
  accent,
  primary,
}

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

class ColorSchemeBase {
  Map<ColorScheme, Color> colors = {
    ColorScheme.accent: null,
    ColorScheme.primary: null,
  };
}
