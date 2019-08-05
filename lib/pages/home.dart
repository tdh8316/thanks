import 'package:flutter/material.dart';
import 'package:thanks/bloc/home.dart';
import 'package:thanks/components/bubble.dart';
import 'package:thanks/components/timeline/timeline.dart';
import 'package:thanks/components/timeline/timeline_model.dart';
import 'package:thanks/models/hex_color.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _bloc = HomeBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  List<TimelineModel> items = [
    TimelineModel(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildBubble(
          child: Column(
            children: <Widget>[
              Icon(Icons.done),
              Text(
                "Hi, I'm all that thanks!\n"
                "I'm the greatest gratitude journaling application!",
              ),
            ],
          ),
          time: '방금 전',
        ),
      ),
      icon: Icon(Icons.people_outline),
      isFirst: true,
    ),
    TimelineModel(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Bubble(
          message:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
          time: '오늘',
        ),
      ),
    ),
    TimelineModel(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Bubble(
          message:
              "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
          time: '100년 전',
        ),
      ),
    ),
    TimelineModel(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Bubble(
          message:
              "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
          time: '6974년 전',
        ),
      ),
    ),
    TimelineModel(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Bubble(
          message: "All that Thanks - Gratitude journaling application",
          time: '120억년 전',
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 24, top: 32),
          child: Text(
            "Good evening,",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 24, top: 64),
          child: Text(
            "Donghyeok Tak",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              letterSpacing: -.75,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: SizedBox(
            height: 100,
            width: 100,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: new OutlineButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Not Implemented'),
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(milliseconds: 1500),
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                borderSide: BorderSide(
                  color: Colors.black,
                  style: BorderStyle.solid,
                  width: 1,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 144, bottom: 64),
          child: SizedBox(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(64),
                bottomRight: Radius.circular(64),
              ),
              child: Timeline(
                physics: BouncingScrollPhysics(),
                children: items,
                position: TimelinePosition.Left,
                primary: true,
                lineColor: Colors.blueAccent,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Material(
              shape: StadiumBorder(),
              elevation: 12,
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
                child: Container(
                  color: HexColor("#EEEFEA"),
                  height: MediaQuery.of(context).size.height / 12 + 12,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
