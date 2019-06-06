/*
I18n
 - Load a prefer language translation file
 - Translation
 */

import 'dart:async' show Future;
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

Map<String, dynamic> trHashMap;

Future<Null> initializeStrings(String locale) async {
  trHashMap = json.decode(
    await rootBundle.loadString(
      "i18n/$locale.json",
    ),
  );
}

String tr(String key) => (trHashMap != null)
    ? (trHashMap.containsKey(key) ? trHashMap[key] : key)
    : (key);
