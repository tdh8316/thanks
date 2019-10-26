import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:thanks/models/structure.dart';
import 'package:thanks/services/storage.dart';

class YAxisFromFeeling {
  /*static const double great = 1;
  static const double notGood = .5;
  static const double sad = .25;
  static const double angry = .25;*/
  static final Random _random = Random.secure();

  static int next(int min, int max) => min + _random.nextInt(max - min);

  static double get great => next(75, 100) / 100;

  static double get notGood => next(35, 50) / 100;

  static double get sad => next(1, 25) / 100;

  static double get angry => next(1, 25) / 100;

  static const double center = .5;
}

Future<List<FlSpot>> getCoordinateFromFeeling(DateTime targetDate) async {
  if (targetDate == null) return [FlSpot(0, 0)];
  final List<FlSpot> data = [];

  List<String> targetFiles = [
    ...fileList.where(
      (e) {
        e = e.split('/').last;
        return e.split('-')[0] == targetDate.year.toString() &&
            e.split('-')[1] == DateFormat("MM").format(targetDate);
      },
    ),
  ];

  targetFiles = targetFiles.reversed.toList();

  for (int i = 0; i < targetFiles.length; i++) {
    Map _ = jsonDecode(File(targetFiles[i]).readAsStringSync());
    data.add(
      FlSpot(
        double.tryParse(
          // numOfDay
          targetFiles[i].split('/').last.split('-')[2].split('.')[0],
        ),
        () {
          String feeling = _[ItemElements.feeling.toString()].toString();
          // print(_);
          if (Feelings.great.toString() == feeling)
            return YAxisFromFeeling.great;
          else if (Feelings.notGood.toString() == feeling)
            return YAxisFromFeeling.notGood;
          else if (Feelings.sad.toString() == feeling)
            return YAxisFromFeeling.sad;
          else if (Feelings.angry.toString() == feeling)
            return YAxisFromFeeling.angry;
          else
            return YAxisFromFeeling.center;
        }(),
      ),
    );
  }

  // data.insert(0, FlSpot(0,0));
  // data.forEach((e) => print("${e.x}, ${e.y}"));
  return data;
}
