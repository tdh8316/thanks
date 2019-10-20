import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thanks/components/question.dart';
import 'package:thanks/models/shared.dart';
import 'package:thanks/models/structure.dart';
import 'package:thanks/pages/viewer/plain_viewer.dart';
import 'package:thanks/services/storage.dart';

class ListViewPage extends StatefulWidget {
  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  List<Widget> journals = <Widget>[];
  ScrollController scrollController = ScrollController();

  bool showQuestion() {
    final DateTime _now = DateTime.now();
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
    scrollController.addListener(() {
      // print(scrollController.position.pixels);
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          // print("TOP");
        } else {
          // print("BOTTOM");
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<Null>(
        future: updateItems(),
        builder: (BuildContext context, AsyncSnapshot<Null> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Container(
                child: Stack(
                  children: <Widget>[
                    /*Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 48),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Column(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.sort),
                              onPressed: () {},
                            ),
                            SizedBox(height: 8),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),*/
                    /*SafeArea(
                      child: Align(
                        child: InkWell(
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32)),
                            child: Container(
                              height: 100,
                              width: 81,
                              color: DefaultColorTheme.main.withOpacity(.75),
                              child: Icon(Icons.add, size: 32, color: Colors.black54,),
                            ),
                          ),
                        ),
                        alignment: Alignment.topRight,
                      ),
                    ),*/
                    CupertinoScrollbar(
                      controller: scrollController,
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: itemLength + 1,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
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
                                  return Container();
                              } else {
                                Map data = loadPlainEntryFromIndex(index - 1);
                                return _buildItemWidget(
                                  data[ItemElements.date],
                                  data[ItemElements.feeling],
                                  data[ItemElements.body],
                                );
                              }
                            }(),
                          );
                        },
                      ),
                    ),
                  ],
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
            body.length != 0
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: Text(
                      body,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
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
