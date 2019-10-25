import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thanks/models/structure.dart';
import 'package:thanks/services/storage.dart';

Future<Null> addStatisticData(
  dynamic feeling,
  DateTime targetDate, {
  bool remove = false,
  String tag,
}) async {
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

  // Set feeling to default-0 if the statistic file doesn't contain it.
  if (!statisticJson.containsKey(feeling.toString())) {
    statisticJson[feeling.toString()] = 0;
  }

  // Do not increase count if the file already exists.
  final bool isFileAlreadyExists = fileList.contains(
    "${(await getApplicationDocumentsDirectory()).path}/"
    "${DateFormat(fileNameFormat).format(targetDate)}.txt",
  );
  statisticJson["total"] = (statisticJson["total"] ?? 0) +
      (remove ? -1 : (isFileAlreadyExists ? 0 : 1));

  // Decrease existing count if the file is overridden.
  if (isFileAlreadyExists && !remove) {
    // Load existing feeling

    final File file = File(
      "${(await getApplicationDocumentsDirectory()).path}/"
      "${DateFormat(fileNameFormat).format(targetDate)}.txt",
    );
    final Map<String, dynamic> decoded =
        jsonDecode(file?.readAsStringSync() ?? "") as Map<String, dynamic>;
    String _existingFeeling = decoded[ItemElements.feeling.toString()];
    print("EXISTING FEEELING:REMOVING: $_existingFeeling");
    statisticJson[_existingFeeling] -= 1;
    statisticJson[feeling.toString()] =
        (statisticJson[feeling.toString()] ?? 0) + 1;
  } else {
    // Calculate feeling count
    statisticJson[feeling.toString()] = // -1 if remove is true.
        (statisticJson[feeling.toString()] ?? 0) + (remove ? -1 : 1);
  }

  // Tag
  if (tag != null) {
    if (isFileAlreadyExists && !remove) {
      // Load existing tag

      final File file = File(
        "${(await getApplicationDocumentsDirectory()).path}/"
        "${DateFormat(fileNameFormat).format(targetDate)}.txt",
      );
      final Map<String, dynamic> decoded =
          jsonDecode(file?.readAsStringSync() ?? "") as Map<String, dynamic>;
      String _existingTag = decoded[ItemElements.tag.toString()];
      print("EXISTING TAG:REMOVING: $_existingTag");
      statisticJson[_existingTag] -= 1;
      statisticJson[tag] = (statisticJson[tag] ?? 0) + 1;
    } else {
      // Calculate tag count
      statisticJson[tag] = // -1 if remove is true.
          (statisticJson[tag] ?? 0) + (remove ? -1 : 1);
    }
  }

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
