/*
Tab widget - Home
 - Date widget
 */

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thanks/i18n/i18n.dart' show tr;

class HomeTab extends StatefulWidget {
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
      crossAxisCount: 3,
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
          onPressed: null,
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
          onPressed: null,
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
          onPressed: null,
        ),
      ],
    );

    return SafeArea(
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
                      tr("심심한 버튼"),
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {},
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
              ),
            ],
          ),
          Container(height: 8),
          Expanded(
            child: moodWidget,
          ),
        ],
      ),
    );
  }
}
