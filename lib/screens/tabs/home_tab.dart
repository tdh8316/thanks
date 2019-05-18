/*
Tab widget - Home
 - Date widget
 */

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thanks/i18n/i18n.dart' show tr;
import 'package:thanks/screens/editor.dart';
import 'package:thanks/screens/index.dart';
import 'package:thanks/widgets/card/card.dart';

class HomeTab extends StatefulWidget {
  final IndexState indexState;

  const HomeTab({Key key, this.indexState}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime nowTime = DateTime.now();
    final dateWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 32, left: 32),
          child: Text(
            "${tr(DateFormat("EEEE").format(nowTime))}",
            style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 2, left: 64),
          child: Text(
            "${DateFormat("d").format(nowTime)} ${DateFormat("MMM").format(nowTime)}",
            style: TextStyle(
              fontSize: 26,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );

    //TODO: Add separators
    var moodWidget = GridView.count(
      childAspectRatio: 1.5,
      crossAxisCount: 3,
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      children: <Widget>[
        MaterialButton(
          child: Column(
            children: <Widget>[
              Icon(
                Icons.sentiment_very_satisfied,
                color: Colors.grey,
                size: 50,
              ),
              Text("Happy"),
            ],
          ),
          onPressed: () {
            pageTransition(context, WritingTab(mood: MoodType.happy));
          },
        ),
        MaterialButton(
          child: Column(
            children: <Widget>[
              Icon(
                Icons.sentiment_neutral,
                color: Colors.grey,
                size: 50,
              ),
              Text("Okay"),
            ],
          ),
          onPressed: () {
            pageTransition(context, WritingTab(mood: MoodType.okay));
          },
        ),
        MaterialButton(
          child: Column(
            children: <Widget>[
              Icon(
                Icons.sentiment_dissatisfied,
                color: Colors.grey,
                size: 50,
              ),
              Text("Sad"),
            ],
          ),
          onPressed: () {
            pageTransition(context, WritingTab(mood: MoodType.sad));
          },
        ),
      ],
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              dateWidget,
              Spacer(),
              Column(
                children: <Widget>[
                  Container(height: 30),
                  RaisedButton(
                    padding: EdgeInsets.all(12),
                    color: Color.fromRGBO(149, 107, 201, 100),
                    child: Text(
                      tr("Button"),
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      widget.indexState
                          .setState(() => widget.indexState.setIndex(1));
                    },
                  ),
                ],
              ),
              Container(width: 32),
            ],
          ),
          Container(padding: EdgeInsets.all(32)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /*SizedBox(
                width: 250.0,
                child: RotateAnimatedTextKit(
                  text: [
                    "     HOW ARE YOU FEELING?",
                    "HOW MANY PEOPLE YOU THANKFUL?",
                    "WRITE TODAY'S THANKS DIARY."
                  ],
                  textStyle: TextStyle(fontSize: 20),
                  textAlign: TextAlign.start,
                  duration: Duration(seconds: 10),
                  alignment: AlignmentDirectional.topStart,
                ),
              ),*/
              TyperAnimatedTextKit(
                text: ["HOW ARE YOU FEELING?"],
                textStyle: TextStyle(fontSize: 20),
                isRepeatingAnimation: false,
                duration: Duration(milliseconds: 2500),
              ),
            ],
          ),
          Container(height: 16),
          moodWidget,
          PaidCard(
            time: "Made with 💕 by 2019 DreamHigh",
            date: '키스의 고유 조건은 입술끼리 만나야 하고\n특별한 기술은 필요치 않다.',
            name: 'Powered by flutter',
            typeOfService: "Lorem ipsum dolor sit amet, "
                "consectetur adipiscing elit, sed do eiusmod tempor incididunt "
                "ut labore et dolore magna aliqua. Ut enim ad minim veniam, "
                "quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea "
                "commodo consequat. Duis aute irure dolor in reprehenderit in "
                "voluptate velit esse cillum dolore eu fugiat nulla pariatur. "
                "Excepteur sint occaecat cupidatat non proident, sunt in culpa "
                "qui officia deserunt mollit anim id est laborum.",
            noOfProducts: '아이폰 앱은 곧 나와요',
            duration: 'Font by NAVER',
          ),
        ],
      ),
    );
  }

  pageTransition(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
