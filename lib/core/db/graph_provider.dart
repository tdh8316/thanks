import 'package:thanks/core/storage.dart';

Future<List<int>> graphProvider() async {
  String stringData = await readFile(".json");

  return <int>[];
}
