import 'package:flutter/material.dart';
import 'package:thanks/models/hex_color.dart';

enum ColorSchemes {
  default_,
  nightFade,
  deepBlue,
  grape,
  white,
}

ColorSchemes selectedTheme = ColorSchemes.default_;

List<Color> defaultColors() => [HexColor("#FA508C"), HexColor("#FFC86E")];

List<Color> nightFadeColors() => [HexColor("#a18cd1"), HexColor("#fbc2eb")];

List<Color> deepBlueColors() => [HexColor("#e0c3fc"), HexColor("#8ec5fc")];

List<Color> grapeColors() => [HexColor("#c471f5"), HexColor("#fa71cd")];

class _DefaultStyle {
  Color _backgroundedTextColor;
  Color _primary1;
  Color _primary2;
  Color _primary3;
  Color _primary4;

  Color _grey1;
  Color _grey2;
  Color _grey3;

  _DefaultStyle({ColorSchemes theme}) {
    switch (theme) {
      case ColorSchemes.nightFade:
        this._backgroundedTextColor = Colors.white;
        this._primary1 = HexColor("#a18cd1");
        this._primary2 = HexColor("#fbc2eb");
        this._primary3 = HexColor("#82A0FA");
        this._primary4 = HexColor("#7A75C4");

        this._grey1 = HexColor("#666666");
        this._grey2 = HexColor("#999999");
        this._grey3 = HexColor("#C8C8C8");

        break;

      case ColorSchemes.deepBlue:
        this._backgroundedTextColor = Colors.white;
        this._primary1 = HexColor("#e0c3fc");
        this._primary2 = HexColor("#8ec5fc");
        this._primary3 = HexColor("#82A0FA");
        this._primary4 = HexColor("#7A75C4");

        this._grey1 = HexColor("#666666");
        this._grey2 = HexColor("#999999");
        this._grey3 = HexColor("#C8C8C8");

        break;

      case ColorSchemes.grape:
        this._backgroundedTextColor = Colors.white;
        this._primary1 = HexColor("#c471f5");
        this._primary2 = HexColor("#fa71cd");
        this._primary3 = HexColor("#82A0FA");
        this._primary4 = HexColor("#7A75C4");

        this._grey1 = HexColor("#666666");
        this._grey2 = HexColor("#999999");
        this._grey3 = HexColor("#C8C8C8");

        break;

      default:
        this._backgroundedTextColor = Colors.white;
        this._primary1 = HexColor("#FA508C");
        this._primary2 = HexColor("#FFC86E");
        this._primary3 = HexColor("#82A0FA");
        this._primary4 = HexColor("#7A75C4");

        this._grey1 = HexColor("#666666");
        this._grey2 = HexColor("#999999");
        this._grey3 = HexColor("#C8C8C8");
    }
  }
}

class DefaultStyle {
  static Color get backgroundedTextColor =>
      _DefaultStyle(theme: selectedTheme)._backgroundedTextColor;

  static Color get primary1 => _DefaultStyle(theme: selectedTheme)._primary1;

  static Color get primary2 => _DefaultStyle(theme: selectedTheme)._primary2;

  static Color get primary3 => _DefaultStyle(theme: selectedTheme)._primary3;

  static Color get primary4 => _DefaultStyle(theme: selectedTheme)._primary4;

  static Color get grey1 => _DefaultStyle(theme: selectedTheme)._grey1;

  static Color get grey2 => _DefaultStyle(theme: selectedTheme)._grey2;

  static Color get grey3 => _DefaultStyle(theme: selectedTheme)._grey3;
}
