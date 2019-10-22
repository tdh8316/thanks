import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thanks/services/storage.dart';

Future<Null> addStatisticData(dynamic feeling, DateTime targetDate,
    {bool remove = false}) async {
  final File statisticFile = File(
    "${(await getApplicationDocumentsDirectory()).path}"
    "/statictic-${DateFormat("yyyy-MM").format(targetDate)}.json",
  );
  // If file doesn't exist, create one and write basic JSON structure.
  if (!statisticFile.existsSync()) {
    statisticFile.createSync(recursive: true);
    statisticFile.writeAsStringSync('{}');
  }
  Map<String, dynamic> statisticJson = jsonDecode(
    statisticFile.readAsStringSync(),
  );

  if (!statisticJson.containsKey(feeling.toString())) {
    statisticJson[feeling.toString()] = 0;
  }
  statisticJson[feeling.toString()] =
      (statisticJson[feeling.toString()] ?? 0) + (remove ? -1 : 1);

  final bool isFileAlreadyExists = fileList.contains(
    "${(await getApplicationDocumentsDirectory()).path}/"
    "${DateFormat(fileNameFormat).format(targetDate)}.txt",
  );

  statisticJson["total"] = (statisticJson["total"] ?? 0) +
      (remove ? -1 : (isFileAlreadyExists ? 0 : 1));

  statisticFile.writeAsStringSync(jsonEncode(statisticJson));

  return null;
}

Future<Map<String, dynamic>> getStatisticData({
  @required DateTime targetDate,
}) async {
  final File dataFile = File(
    "${(await getApplicationDocumentsDirectory()).path}"
    "/statictic-${DateFormat("yyyy-MM").format(targetDate)}.json",
  );

  if (!dataFile.existsSync()) return null;

  return jsonDecode(dataFile.readAsStringSync());
}
