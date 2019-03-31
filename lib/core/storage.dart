import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> get _localPath async =>
    await getApplicationDocumentsDirectory().then((_) => _.path);

Future<File> writeFile(String fileName, String str, {encrypt}) async {
  // TODO: Encryption
  return File("${await _localPath}/$fileName").writeAsString(str);
}

Future<String> readFile(String fileName, {encrypt}) async {
  // TODO: Decryption
  final file = File("${await _localPath}/$fileName");
  if (await file.exists()) {
    return file.readAsString();
  }
  return null;
}
