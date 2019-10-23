import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:thanks/models/hex_color.dart';
import 'package:thanks/models/structure.dart';

class StoryTagPage extends StatefulWidget {
  final DateTime targetDate;
  final Function nextPage;

  final Function(String) setter;

  StoryTagPage({
    @required this.targetDate,
    @required this.setter,
    @required this.nextPage,
  });

  State<StoryTagPage> createState() => _StoryTagPageState();
}

class _StoryTagPageState extends State<StoryTagPage> {
  final DateTime _now = DateTime.now();

  @override
  Widget build(BuildContext context) => Container(
        color: HexColor("#f9f9f9"),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
              child: Text(
                widget.targetDate.isBefore(
                  DateTime(_now.year, _now.month, _now.day),
                )
                    ? "이 날은 어떤 일에 감사했나요?"
                    : "오늘 하루, 어떤 것에 감사한가요?",
                softWrap: true,
                style: TextStyle(
                  fontFamily: "나눔바른펜",
                  fontSize: 24,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                crossAxisCount: 3,
                children: <Widget>[
                  _imageIcon(1),
                  _imageIcon(2),
                  _imageIcon(3),
                  _imageIcon(4),
                  _imageIcon(5),
                  _imageIcon(6),
                  _imageIcon(7),
                  _imageIcon(-1),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _imageIcon(int name) => FlatButton(
        shape: StadiumBorder(),
        onPressed: () {
          if (name > 0) widget.setter(tagList[name - 1]);
          else return;
          widget.nextPage();
        },
        child: FractionallySizedBox(
          widthFactor: 0.5,
          // heightFactor: 0.5,
          child: Column(
            children: <Widget>[
              Spacer(),
              Image.asset(
                "res/assets/tags/$name.png",
                fit: BoxFit.contain,
              ),
              Text(name > 0 ? tagList[name - 1] : "..."),
              Spacer(),
            ],
          ),
        ),
      );
}
