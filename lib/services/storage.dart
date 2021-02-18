import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
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
  print("Update called!!!!");
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

  await Future.delayed(Duration(milliseconds: 100));

  return null;
}

Future<Null> savePlainEntry({
  @required String content,
  @required Feelings feelings,
  @required DateTime date,
}) async {
  // Add this to statistic
  await addStatisticData(feelings, date);
  final File file = File(
    "${await _localPath}/${DateFormat(fileNameFormat).format(date)}.txt",
  );
  //file.writeAsString(content);
  final Map<String, String> raw = {
    ItemElements.feeling.toString(): "$feelings",
    ItemElements.body.toString(): content,
  };

  await file.writeAsString(jsonEncode(raw));
  await updateItems();
  await Future.delayed(Duration(milliseconds: 100));
}

Future<Null> saveEntry({
  @required String content,
  @required String tag,
  @required Feelings feelings,
  @required DateTime date,
}) async {
  // Add this to statistic
  await addStatisticData(feelings, date, tag: tag);
  final File file = File(
    "${await _localPath}/${DateFormat(fileNameFormat).format(date)}.txt",
  );
  //file.writeAsString(content);
  final Map<String, String> raw = {
    ItemElements.feeling.toString(): "$feelings",
    ItemElements.body.toString(): content,
    ItemElements.tag.toString(): tag.split('.').last,
  };

  await file.writeAsString(jsonEncode(raw));
  await updateItems();
  await Future.delayed(Duration(milliseconds: 100));
}

genFakeData() async {
  for (int i = 1; i < 100; i++) {
    await savePlainEntry(
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
    ItemElements.tag: decoded.containsKey(ItemElements.tag.toString())
        ? decoded[ItemElements.tag.toString()]
        : null,
  };
}

Future<String> loadPlainEntryFromDate({
  String string,
  DateTime dateTime,
}) async =>
    await (File(
      "${await _localPath}/${string ?? DateFormat(fileNameFormat).format(dateTime)}.txt",
    )).readAsString();

Future<Null> removeEntryFromDate({
  String string,
  DateTime date,
  String tag,
}) async {
  File file = File(
    "${await _localPath}/${string ?? DateFormat(fileNameFormat).format(date)}.txt",
  );
  await addStatisticData(
    jsonDecode(file.readAsStringSync())[ItemElements.feeling.toString()],
    date ?? DateFormat(fileNameFormat).parse(string),
    tag: tag,
    remove: true,
  );
  await file.delete();
}
