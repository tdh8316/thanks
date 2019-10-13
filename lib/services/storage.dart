import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thanks/models/structure.dart';

List<String> _files = List();
const String fileNameFormat = "yyyy-MM-dd";

Future<String> get _localPath async =>
    (await getApplicationDocumentsDirectory()).path;

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
    {String content, Feelings feelings, DateTime time}) async {
  final File file = File(
    "${await _localPath}/${DateFormat(fileNameFormat).format(time)}.txt",
  );
  //file.writeAsString(content);
  final Map<String, dynamic> raw = {
    ItemElements.feeling.toString(): "$feelings".split('.')[1],
    ItemElements.body.toString(): content,
  };

  file.writeAsStringSync(jsonEncode(raw));
}

genFakeData() {
  for (int i = 1; i < 100; i++) {
    savePlainEntry(
      content: "This is an  ${i}st example of the text widget.",
      feelings: Feelings.great,
      time: DateTime.now().subtract(Duration(days: i)),
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
  DateTime dateTime,
}) async =>
    File(
      "${await _localPath}/${string ?? DateFormat(fileNameFormat).format(dateTime)}.txt",
    ).deleteSync();
