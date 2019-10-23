import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thanks/components/question.dart';
import 'package:thanks/models/scroll_behavior.dart';
import 'package:thanks/models/shared.dart';
import 'package:thanks/models/structure.dart';
import 'package:thanks/pages/prev_new.dart';
import 'package:thanks/pages/viewer/plain_viewer.dart';
import 'package:thanks/services/storage.dart';
import 'package:thanks/styles/colors.dart';

class ListViewPage extends StatefulWidget {
  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  final DateTime _now = DateTime.now();

  bool showQuestion() {
    final List<String> latestDate =
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<Null>(
        future: updateItems(),
        builder: (BuildContext context, AsyncSnapshot<Null> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return SafeArea(
                child: Scrollbar(
                  child: ScrollConfiguration(
                    behavior: NoBounceBehavior(),
                    child: ListView.builder(
                      itemCount: itemLength + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          if (showQuestion())
                            return Padding(
                              padding: EdgeInsets.only(
                                left: 32,
                                right: 32,
                                top: 8,
                                bottom: 8,
                              ),
                              child: Question(
                                date: _now,
                              ),
                            );
                          else
                            return Container(
                              child: Center(
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            PrevNewPage(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "다른 날의 일기 쓰기",
                                    style: TextStyle(
                                      color: DefaultColorTheme.main.withOpacity(
                                        .75,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                        } else {
                          Map data = loadPlainEntryFromIndex(index - 1);
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            child: _buildItemWidget(
                              data[ItemElements.date],
                              data[ItemElements.feeling],
                              data[ItemElements.body],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              );
            default:
              if (snapshot.hasError)
                return Container(
                  child: SafeArea(
                    child: Center(
                      child: Text(
                        "Exception: ${snapshot.error}",
                        style: TextStyle(fontFamily: "Roboto"),
                      ),
                    ),
                  ),
                );
              return Container();
          }
        },
      );

  Widget _buildItemWidget(String date, String feeling, String body) {
    List<String> dateList = date.split('-');
    return Column(
      children: <Widget>[
        Divider(),
        InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => PlainEntryViewer(date: date),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.only(
              top: 16,
              left: 8,
              right: 8,
              bottom: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        "${dateList[0]}년 ${dateList[1]}월 ${dateList[2]}일.",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: "나눔바른펜",
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "${_getFeelingTranslation(feeling)}",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
                body.length != 0
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        child: Text(
                          body,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(
                            fontSize: 18,
                            // fontFamily: "나눔손글씨 암스테르담",
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getFeelingTranslation(String feeling) {
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
}
