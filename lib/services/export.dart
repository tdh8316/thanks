import 'dart:convert';
import 'dart:io';

import 'package:flutter_archive/flutter_archive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thanks/models/shared.dart';
import 'package:thanks/models/structure.dart';

List<String> _files = List();

Future<String> get _localPath async =>
    (await getApplicationDocumentsDirectory()).path;

Future<String> exportAsFile() async {
  final List<FileSystemEntity> _entities = [
    ...Directory(await _localPath).listSync().where(
          (a) => a.path.endsWith(".txt"),
        ),
  ];
  List<File> _files = <File>[];
  for (int i = 0; i < _entities.length; i++) {
    _files.add(File(_entities[i].path));
  }

  final sourceDir = Directory(await _localPath);
  final files = _files;
  final zipFile = File("${await _localPath}/thanks.zip");
  try {
    await ZipFile.createFromFiles(
      sourceDir: sourceDir,
      files: files,
      zipFile: zipFile,
    );
  } catch (e) {
    print("ERROR!");
    print(e);
  }

  return zipFile.path;
}

Future<String> exportAll() async {
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

  String fullContent = "";

  String file;
  for (file in _files) {
    var fileRead = File(
      file,
    ).readAsStringSync();
    var dataMap = jsonDecode(fileRead);
    List<String> dateList = file.split("/").last.split(".").first.split("-");
    String content = "- ${dateList[0]}년 ${dateList[1]}월 ${dateList[2]}일. "
        "${getFeelingTranslation(dataMap[ItemElements.feeling.toString()])}\n";
    if (dataMap.containsKey(ItemElements.tag.toString())) {
      content +=
          "오늘은 '${dataMap[ItemElements.tag.toString()].split('.').last}'에 감사했다.";
    }
    String body = dataMap[ItemElements.body.toString()];
    content += body.length > 0 ? " 왜냐하면... " + body : "저장된 다른 내용이 없습니다.";

    fullContent += content + "\n\n";
  }

  return (fullContent);
}
