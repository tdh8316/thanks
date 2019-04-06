/*
I18n
 - Load a prefer language translation file
 - Translation
 */

import 'dart:async' show Future;

import 'package:flutter/services.dart' show rootBundle;

Future<String> loadJsonAsString(String language) async {
  return await rootBundle.loadString('i18n/' + language + '.json');
}

Map<String, dynamic> trHashMap;

String tr(String key) => (trHashMap != null)
    ? (trHashMap.containsKey(key) ? trHashMap[key] : key)
    : (key);
