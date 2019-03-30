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

// Return the translated if it is in the map or the original if it is not.
String tr(String key) => trHashMap.containsKey(key) ? trHashMap[key] : key;
