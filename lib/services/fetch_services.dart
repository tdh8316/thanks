import 'package:flutter/widgets.dart';

import 'localization.dart';

Future<Null> fetch(BuildContext context) {
  initializeStrings(Localizations.localeOf(context).toString());
  Future.delayed(Duration(seconds: 1))
    ..then(
      (_) {
        Navigator.pushReplacementNamed(context, '/');
      },
    );
  return null;
}
