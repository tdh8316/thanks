import 'package:thanks/models/shared.dart';
import 'package:thanks/models/structure.dart';

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

String getFeelingTranslationE(String feeling) {
  if (feeling.runtimeType != String)
    return '';
  else if (Feelings.great.toString() == feeling)
    return "기분이 정말 좋았고, ";
  else if (Feelings.notGood.toString() == feeling)
    return "그저 그랬다. 그래도 ";
  else if (Feelings.sad.toString() == feeling)
    return "슬픈 하루였지만 ";
  else if (Feelings.angry.toString() == feeling)
    return "화나는 하루였다. 그렇지만 ";
  else
    return '\uD83E\uDD14';
}
