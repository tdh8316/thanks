import 'package:thanks/models/shared.dart';

void updateLatestWriting(DateTime _dateTime) {
  final List<String> latestDate =
      StaticSharedPreferences.prefs.getStringList("latestDate");

  if (latestDate == null ||
      latestDate.length != 3 ||
      _dateTime.isAfter(
        DateTime(
          int.parse(latestDate[0]), // year
          int.parse(latestDate[1]), // month
          int.parse(latestDate[2]), // day
        ),
      ))
    StaticSharedPreferences.prefs.setStringList(
      "latestDate",
      [
        "${_dateTime.year}",
        "${_dateTime.month}",
        "${_dateTime.day}",
      ],
    );
}
