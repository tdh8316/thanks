import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thanks/models/structure.dart';
import 'package:thanks/services/statistic.dart';

List<String> _files = List();
const String fileNameFormat = "yyyy-MM-dd";

Future<String> get _localPath async =>
    (await getApplicationDocumentsDirectory()).path;
List<String> get fileList => _files;

int get itemLength => _files.length;

// This mustn't be called except of FutureBuilder
Future<Null> updateItems() async {
  final List<FileSystemEntity> _entities = [
    ...Directory(await _localPath).listSync().where(
          (a) => a.path.endsWith(".txt"),
        ),
  ];
  _files = <String>[];
  for (int i = 0; i < _entities.length; i++) {
    _files.add(_entities[i].path);
  }
  _files.sort();
  _files = _files.reversed.toList();

  return null;
}

Future<Null> savePlainEntry(
    {String content, Feelings feelings, DateTime date}) async {
  final File file = File(
    "${await _localPath}/${DateFormat(fileNameFormat).format(date)}.txt",
  );
  //file.writeAsString(content);
  final Map<String, String> raw = {
    ItemElements.feeling.toString(): "$feelings",
    ItemElements.body.toString(): content,
  };

  file.writeAsStringSync(jsonEncode(raw));

  // Add this to statistic
  addStatisticData(feelings, date);
}

genFakeData() {
  for (int i = 1; i < 100; i++) {
    savePlainEntry(
      content: "This is an  ${i}st example of the text widget.",
      feelings: Feelings.great,
      date: DateTime.now().subtract(Duration(days: i)),
    );
  }
}

Map<ItemElements, String> loadPlainEntryFromIndex(int i) {
  final File file = File(_files[i]);
  if (!file.existsSync())
    return {
      ItemElements.date:
          file?.path?.split('/')?.last?.split('.')?.first ?? "Unknown date",
      ItemElements.feeling: "",
      ItemElements.body: "Not found",
    };
  final Map<String, dynamic> decoded =
      jsonDecode(file?.readAsStringSync() ?? "") as Map<String, dynamic>;
  return {
    ItemElements.date:
        file?.path?.split('/')?.last?.split('.')?.first ?? "Unknown date",
    ItemElements.feeling: decoded[ItemElements.feeling.toString()] ?? "",
    ItemElements.body:
        decoded[ItemElements.body.toString()] ?? "Unknown format",
  };
}

Future<String> loadPlainEntryFromDate({
  String string,
  DateTime dateTime,
}) async =>
    File(
      "${await _localPath}/${string ?? DateFormat(fileNameFormat).format(dateTime)}.txt",
    ).readAsStringSync();

Future<Null> removeEntryFromDate({
  String string,
  DateTime date,
}) async {
  File file = File(
    "${await _localPath}/${string ?? DateFormat(fileNameFormat).format(date)}.txt",
  );
  addStatisticData(
    jsonDecode(file.readAsStringSync())[ItemElements.feeling.toString()],
    date ?? DateFormat(fileNameFormat).parse(string),
    remove: true,
  );
  file.deleteSync();
}
