import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thanks/components/question.dart';
import 'package:thanks/models/shared.dart';
import 'package:thanks/models/structure.dart';
import 'package:thanks/pages/viewer/plain.dart';
import 'package:thanks/services/storage.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> journals = <Widget>[];
  ScrollController scrollController = ScrollController();

  bool showQuestion() {
    final DateTime _now = DateTime.now();
    List<String> latestDate =
        StaticSharedPreferences.prefs?.getStringList("latestDate");
    if (latestDate == null || latestDate.length != 3) return true;
    return (latestDate[2] != _now.day.toString()) ||
            (latestDate[1] != _now.month.toString()) ||
            (latestDate[0] != _now.year.toString())
        ? true
        : false;
  }

  @override
  void initState() {
    scrollController.addListener(() {
      // print(scrollController.position.pixels);
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          print("TOP");
        } else {
          print("BOTTOM");
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
        child: SafeArea(
          child: CupertinoScrollbar(
            controller: scrollController,
            child: ListView.builder(
              controller: scrollController,
              itemCount: itemLength + 1,
              itemBuilder: (BuildContext context, int index) => Padding(
                padding: EdgeInsets.only(
                  left: 32,
                  right: 32,
                  top: 8,
                  bottom: 8,
                ),
                child: () {
                  if (index == 0) {
                    if (showQuestion())
                      return Question();
                    else
                      return Text("여기에 무엇이 있으면 좋을까요?");
                  } else {
                    Map data = loadPlainEntryFromIndex(index - 1);
                    return _buildItemWidget(
                      data[ItemElements.date],
                      data[ItemElements.feeling],
                      data[ItemElements.body],
                    );
                  }
                }(),
              ),
            ),
          ),
        ),
      );

  Widget _buildItemWidget(String date, String feeling, String body) {
    List<String> dateList = date.split('-');
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => PlainEntryViewer(date: date),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    "${dateList[0]}년 ${dateList[1]}월 ${dateList[2]}일.",
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  child: Text(
                    "${_getFeelingTranslation(feeling)}",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Text(
                body,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getFeelingTranslation(String feeling) {
    switch (feeling) {
      case "great":
        return "좋아! \uD83D\uDE0A";
      case "notGood":
        return "그저 그래 \uD83D\uDE10";
      case "sad":
        return "너무 슬프다 \uD83D\uDE25";
      case "angry":
        return "정말 화난다 \uD83D\uDE21";
      default:
        return null;
    }
  }
}
