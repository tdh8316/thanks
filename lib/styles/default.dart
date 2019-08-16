import 'package:thanks/models/hex_color.dart';

enum ColorSchemes {
  default_,
  white,
}

ColorSchemes selectedTheme = ColorSchemes.default_;

class _DefaultStyle {
  HexColor _primary1 = HexColor("#FA508C");
  HexColor _primary2 = HexColor("#FFC86E");
  HexColor _primary3 = HexColor("#82A0FA");

  HexColor _grey1 = HexColor("#666666");
  HexColor _grey2 = HexColor("#999999");
  HexColor _grey3 = HexColor("#C8C8C8");

  _DefaultStyle({ColorSchemes theme}) {
    if (theme == ColorSchemes.default_) {
      this._primary1 = HexColor("#FA508C");
      this._primary2 = HexColor("#FFC86E");
      this._primary3 = HexColor("#82A0FA");

      this._grey1 = HexColor("#666666");
      this._grey2 = HexColor("#999999");
      this._grey3 = HexColor("#C8C8C8");
    }
  }
}

class DefaultStyle extends _DefaultStyle {
  DefaultStyle() : super(theme: selectedTheme);

  static get primary1 => _DefaultStyle(theme: selectedTheme)._primary1;

  static get primary2 => _DefaultStyle(theme: selectedTheme)._primary2;

  static get primary3 => _DefaultStyle(theme: selectedTheme)._primary3;

  static get grey1 => _DefaultStyle(theme: selectedTheme)._grey1;

  static get grey2 => _DefaultStyle(theme: selectedTheme)._grey2;

  static get grey3 => _DefaultStyle(theme: selectedTheme)._grey3;
}
