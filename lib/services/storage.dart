import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thanks/models/structure.dart';

List<String> _files = List();

Future<String> get _localPath async =>
    (await getApplicationDocumentsDirectory()).path;

int get itemLength => _files.length;

Future<Null> loadAllItems() async {
  final List<FileSystemEntity> _entities = [
    ...Directory(await _localPath).listSync().where(
          (a) => a.path.endsWith(".txt"),
        ),
  ];
  _files = <String>[];
  for (int i = 0; i < _entities.length; i++) {
    _files.add(_entities[i].path);
  }
}

Future<Null> savePlainEntry({String content, Feelings feelings}) async {
  File file = File(
    "${await _localPath}/${DateFormat("yyyy-MM-dd").format(DateTime.now())}.txt",
  );
  //file.writeAsString(content);
  final Map<String, dynamic> raw = {
    ItemElements.feeling.toString(): "$feelings".split('.')[1],
    ItemElements.body.toString(): content,
  };

  file.writeAsStringSync(jsonEncode(raw));
}

Future<Null> savePlainEntryTest() async {
  File file;
  file = File(
    "${await _localPath}/${DateFormat("yyyy-MM-dd").format(DateTime.now().subtract(Duration(days: 1)))}.txt",
  );
  file.writeAsString("Day 5.");
  file = File(
    "${await _localPath}/${DateFormat("yyyy-MM-dd").format(DateTime.now().subtract(Duration(days: 2)))}.txt",
  );
  file.writeAsString("Day 4.");
  file = File(
    "${await _localPath}/${DateFormat("yyyy-MM-dd").format(DateTime.now().subtract(Duration(days: 3)))}.txt",
  );
  file.writeAsString("Day 3.");
  file = File(
    "${await _localPath}/${DateFormat("yyyy-MM-dd").format(DateTime.now().subtract(Duration(days: 4)))}.txt",
  );
  file.writeAsString("Day 2.");
  file = File(
    "${await _localPath}/${DateFormat("yyyy-MM-dd").format(DateTime.now().subtract(Duration(days: 5)))}.txt",
  );
  file.writeAsString("Day 1.");
  file = File(
    "${await _localPath}/${DateFormat("yyyy-MM-dd").format(DateTime.now().subtract(Duration(days: 6)))}.txt",
  );
  file.writeAsString("A new start.");
}

Map<ItemElements, String> loadPlainEntry(int i) {
  File file = File(_files[i]);
  final Map<String, dynamic> decoded =
      jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  return {
    ItemElements.date: file.path.split('/').last.split('.').first,
    ItemElements.feeling: decoded[ItemElements.feeling.toString()],
    ItemElements.body: decoded[ItemElements.body.toString()],
  };
}
