import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

Future<Null> addStatisticData(dynamic feeling, DateTime targetDate,
    {bool remove = false}) async {
  final File statisticFile = File(
    "${(await getApplicationDocumentsDirectory()).path}/statictic-${targetDate.year}-${targetDate.month}.json",
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
  statisticJson["total"] = (statisticJson["total"] ?? 0) + (remove ? -1 : 1);

  statisticFile.writeAsStringSync(jsonEncode(statisticJson));
}

Future<Map<String, dynamic>> getStatisticData({
  @required DateTime targetDate,
}) async =>
    jsonDecode(
      File(
            "${(await getApplicationDocumentsDirectory()).path}"
            "/statictic-${targetDate.year}-${targetDate.month}.json",
          ).readAsStringSync() ??
          "{}",
    );
