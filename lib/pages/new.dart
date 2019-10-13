import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thanks/components/animation/show_up.dart';
import 'package:thanks/generated/i18n.dart';
import 'package:thanks/models/structure.dart';
import 'package:thanks/pages/diary.dart';
import 'package:thanks/pages/story/index.dart';
import 'package:thanks/styles/colors.dart';

class NewJournalPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Feelings feeling;

  NewJournalPage({
    @required this.feeling,
  });

  final DateTime _now = DateTime.now();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Colors.black),
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              S.of(context).home,
              style: TextStyle(color: Colors.black),
            ),
          ),
          elevation: 0,
        ),
        body: PrimaryScrollController(
          controller: _scrollController,
          child: CupertinoScrollbar(
            controller: _scrollController,
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              controller: _scrollController,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 32, left: 24, bottom: 32),
                      child: Align(
                        alignment: Alignment.topLeft,
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
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    SizedBox(height: 28),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * (3 / 4),
                      child: Image.asset("res/assets/humans/${() {
                        switch (feeling) {
                          case Feelings.great:
                            return 1;
                          case Feelings.notGood:
                            return 2;
                          case Feelings.sad:
                            return 3;
                          case Feelings.angry:
                            return 4;
                          default:
                            return 1;
                        }
                      }()}.png"),
                    ),
                    SizedBox(height: 32),
                    ShowUp(
                      animatedOpacity: true,
                      delay: Duration(milliseconds: 250),
                      curve: Curves.elasticOut,
                      child: Text(
                        () {
                          switch (feeling) {
                            case Feelings.great:
                              return S.of(context).feelingGreatMessage;
                            case Feelings.notGood:
                              return S.of(context).feelingNotGoodMessage;
                            case Feelings.sad:
                              return S.of(context).feelingSadMessage;
                            case Feelings.angry:
                              return S.of(context).feelingAngryMessage;
                            default:
                              return "";
                          }
                        }(),
                      ),
                    ),
                    SizedBox(height: 48),
                    ShowUp(
                      animatedOpacity: true,
                      delay: Duration(milliseconds: 500),
                      curve: Curves.linearToEaseOut,
                      child: FlatButton(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 60,
                            right: 60,
                            top: 18,
                            bottom: 18,
                          ),
                          child: Text(
                            S.of(context).startTalking,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => StoryBoard(
                              dateTime: _now,
                              feeling: feeling,
                            ),
                          ),
                        ),
                        shape: StadiumBorder(),
                        color: DefaultColorTheme.main,
                      ),
                    ),
                    SizedBox(height: 8),
                    ShowUp(
                      animatedOpacity: true,
                      delay: Duration(milliseconds: 750),
                      curve: Curves.linearToEaseOut,
                      child: FlatButton(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 60,
                            right: 60,
                            top: 20,
                            bottom: 20,
                          ),
                          child: Text(
                            S.of(context).startWriting,
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => DiaryPage(
                              dateTime: _now,
                              feeling: feeling,
                            ),
                          ),
                        ),
                        shape: StadiumBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
