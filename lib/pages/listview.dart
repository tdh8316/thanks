import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thanks/components/animation/show_up.dart';
import 'package:thanks/generated/i18n.dart';
import 'package:thanks/models/scroll_behavior.dart';
import 'package:thanks/models/shared.dart';
import 'package:thanks/models/structure.dart';
import 'package:thanks/pages/new.dart';
import 'package:thanks/pages/prev_new.dart';
import 'package:thanks/pages/viewer.dart';
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
              return _build();
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

  Widget _build() {
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
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Center(
                            child: FractionallySizedBox(
                              widthFactor: 1,
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              PrevNewPage(),
                                        ),
                                      )
                                      .then(
                                        (value) => setState(() {}),
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
                          ),
                        ),
                        buildQuestion(context),
                      ],
                    ),
                  );
                else
                  return Container(
                    child: Center(
                      child: FractionallySizedBox(
                        widthFactor: 1,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PrevNewPage(),
                                  ),
                                )
                                .then(
                                  (value) => setState(() {}),
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
                    ),
                  );
              } else {
                Map data = loadPlainEntryFromIndex(index - 1);
                return ShowUp(
                  animatedOpacity: true,
                  duration: Duration(milliseconds: 500),
                  begin: Offset(.75, 0),
                  end: Offset(0, 0),
                  curve: Curves.easeOutCubic,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    child: _buildItemWidget(
                      data[ItemElements.date],
                      data[ItemElements.feeling],
                      data[ItemElements.body],
                      data[ItemElements.tag],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildItemWidget(
    String date,
    String feeling,
    String body,
    String tag,
  ) {
    List<String> dateList = date.split('-');
    return Column(
      children: <Widget>[
        Divider(),
        InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            Navigator.of(context)
                .push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        PlainEntryViewer(date: date),
                  ),
                )
                .then(
                  (value) => setState(() {}),
                );
          },
          child: Padding(
            padding: EdgeInsets.only(
              top: 16,
              left: 8,
              right: 8,
              bottom: 8,
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
                        "${getFeelingTranslation(feeling)}",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
                body.length == 0
                    ? (tag == null
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                            child: Text(
                              "오늘은 '$tag'에 감사했다.",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(
                                fontSize: 18,
                                // fontFamily: "나눔손글씨 암스테르담",
                              ),
                            ),
                          ))
                    : Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        child: Text(
                          //tag == null ? body : "${_randomTitle(tag)} $body",
                          body,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(
                            fontSize: 18,
                            // fontFamily: "나눔손글씨 암스테르담",
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildQuestion(BuildContext context) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ShowUp(
              child: InkWell(
                onTap: () => Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => PrevNewPage(),
                      ),
                    )
                    .then(
                      (value) => setState(() {}),
                    ),
                child: Text(
                  DateFormat(
                    S.of(context).titleDateFormat(
                      () {
                        switch (DateFormat("EEEE").format(_now)) {
                          case "Monday":
                            return S.of(context).Monday;
                          case "Tuesday":
                            return S.of(context).Tuesday;
                          case "Wednesday":
                            return S.of(context).Wednesday;
                          case "Thursday":
                            return S.of(context).Thursday;
                          case "Friday":
                            return S.of(context).Friday;
                          case "Saturday":
                            return S.of(context).Saturday;
                          case "Sunday":
                            return S.of(context).Sunday;
                          default:
                            return "Unknown Date";
                        }
                      }(),
                    ),
                  ).format(_now),
                  style: TextStyle(fontSize: 20, fontFamily: "나눔바른펜"),
                ),
              ),
              animatedOpacity: true,
              begin: Offset.zero,
              duration: Duration(milliseconds: 500),
            ),
            SizedBox(height: 8),
            ShowUp(
              animatedOpacity: true,
              child: Text(
                "오늘 하루는 어땠어?",
                style: Theme.of(context).textTheme.headline5.copyWith(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.1,
                      color: Colors.black.withOpacity(0.75),
                    ),
              ),
              begin: Offset(0, .25),
              delay: Duration(milliseconds: 750),
              duration: Duration(milliseconds: 1000),
              curve: Curves.easeOutBack,
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 8),
                ShowUp(
                  child: _buildButton(
                    context,
                    S.of(context).feelingGreat,
                    Feelings.great,
                  ),
                  animatedOpacity: true,
                  delay: Duration(milliseconds: 100),
                  duration: Duration(milliseconds: 250 * 2),
                  begin: Offset(0, .25),
                  curve: Curves.easeOutCirc,
                ),
                SizedBox(height: 8),
                ShowUp(
                  child: _buildButton(
                    context,
                    S.of(context).feelingNotGood,
                    Feelings.notGood,
                  ),
                  animatedOpacity: true,
                  delay: Duration(milliseconds: 200),
                  duration: Duration(milliseconds: 350 * 2),
                  begin: Offset(0, .50),
                  curve: Curves.easeOutCirc,
                ),
                SizedBox(height: 8),
                ShowUp(
                  child: _buildButton(
                    context,
                    S.of(context).feelingSad,
                    Feelings.sad,
                  ),
                  animatedOpacity: true,
                  delay: Duration(milliseconds: 300),
                  duration: Duration(milliseconds: 450 * 2),
                  begin: Offset(0, .75),
                  curve: Curves.easeOutCirc,
                ),
                SizedBox(height: 8),
                ShowUp(
                  child: _buildButton(
                    context,
                    S.of(context).feelingAngry,
                    Feelings.angry,
                  ),
                  animatedOpacity: true,
                  delay: Duration(milliseconds: 400),
                  duration: Duration(milliseconds: 500 * 2),
                  begin: Offset(0, 1),
                  curve: Curves.easeOutCirc,
                ),
                SizedBox(height: 32),
              ],
            ),
          ],
        ),
      );

  Widget _buildButton(BuildContext context, String content, Feelings feeling) =>
      FlatButton(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: <Widget>[
              Spacer(),
              Text(
                content,
                style: TextStyle(
                  color: DefaultColorTheme.main.withOpacity(0.825),
                  fontSize: 16,
                  letterSpacing: 1.01,
                ),
              ),
              SizedBox(width: 8),
              Image.asset(
                "res/assets/${() {
                  switch (feeling) {
                    case Feelings.great:
                      return "smiling";
                    case Feelings.notGood:
                      return "neutral";
                    case Feelings.sad:
                      return "crying";
                    case Feelings.angry:
                      return "angry";
                    default:
                      return '';
                  }
                }()}-100.png",
                height: 28,
              ),
              Spacer(),
            ],
          ),
        ),
        onPressed: () async {
          final updateFunc = () {
            setState(() {});
          };
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (BuildContext context) => NewJournalPage(
                    feeling: feeling,
                    diaryDate: _now,
                    updateFunc: updateFunc,
                  ),
                ),
              )
              .then(
                (value) => setState(() {}),
              );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: DefaultColorTheme.main, width: 0.75),
        ),
      );
}
