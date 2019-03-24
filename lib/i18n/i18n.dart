import 'dart:async' show Future;

import 'package:flutter/services.dart' show rootBundle;

Future<String> loadJsonAsString(String language) async {
  return await rootBundle.loadString('i18n/' + language + '.json');
}

Map<String, dynamic> trDict;

String tr(String key) => trDict.containsKey(key) ? trDict[key] : key;
