import 'package:flutter/material.dart';

class TextStyleTheme {
  TextStyleTheme._();

  /*
  const TextTheme({
    this.display4,
    this.display3,
    this.display2,
    this.display1,
    this.headline,
    this.title,
    this.subhead,
    this.body2,
    this.body1,
    this.caption,
    this.button,
    this.subtitle,
    this.overline,
  });
   */
  static const TextTheme textTheme = TextTheme(
    button: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
    headline: TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
    subhead: TextStyle(fontWeight: FontWeight.w500, letterSpacing: -.5),
  );
}
