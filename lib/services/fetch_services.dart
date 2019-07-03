import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:thanks/screens/index.dart';

import 'localization.dart';

Future<Null> fetch(BuildContext context) async {
  await initializeStrings(
    Localizations.localeOf(context).toString(),
  );
  Future.delayed(Duration(seconds: 1))
    ..then(
      (_) {
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
            builder: (context) => Index(),
          ),
        );
      },
    );
  return null;
}
