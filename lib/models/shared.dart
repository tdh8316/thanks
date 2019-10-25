import 'package:shared_preferences/shared_preferences.dart';
import 'package:thanks/models/structure.dart';

class StaticSharedPreferences {
  static SharedPreferences prefs;
}

String getFeelingTranslation(String feeling) {
  if (feeling.runtimeType != String)
    return '';
  else if (Feelings.great.toString() == feeling)
    return "좋아! \uD83D\uDE0A";
  else if (Feelings.notGood.toString() == feeling)
    return "그저 그래 \uD83D\uDE10";
  else if (Feelings.sad.toString() == feeling)
    return "너무 슬프다 \uD83D\uDE25";
  else if (Feelings.angry.toString() == feeling)
    return "정말 화난다 \uD83D\uDE21";
  else
    return '\uD83E\uDD14';
}
