import 'dart:convert';
import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:thanks/models/structure.dart';
import 'package:thanks/services/storage.dart';

List<FlSpot> getCoordinateFromFeeling(DateTime targetDate) {
  if (targetDate == null) return [FlSpot(0, 0)];
  final List<FlSpot> data = [];

  List<String> targetFiles = [
    ...fileList.where(
      (e) {
        e = e.split('/').last;
        return e.split('-')[0] == targetDate.year.toString() &&
            e.split('-')[1] == targetDate.month.toString();
      },
    ),
  ];

  targetFiles = targetFiles.reversed.toList();

  for (int i = 0; i < targetFiles.length; i++) {
    Map _ = jsonDecode(File(targetFiles[i]).readAsStringSync());
    data.add(
      FlSpot(
        double.tryParse(
          targetFiles[i].split('/').last.split('-')[2].split('.')[0],
        ),
        () {
          String feeling = _[ItemElements.feeling.toString()].toString();
          // print(_);
          if (Feelings.great.toString() == feeling)
            return 3.0;
          else if (Feelings.notGood.toString() == feeling)
            return 1.75;
          else if (Feelings.sad.toString() == feeling)
            return 1.0;
          else if (Feelings.angry.toString() == feeling)
            return 1.0;
          else
            return 0.0;
        }(),
      ),
    );
  }

  // data.insert(0, FlSpot(0,0));
  // data.forEach((e) => print("${e.x}, ${e.y}"));
  return data == [] ? [FlSpot(0, 0)] : data;
}
