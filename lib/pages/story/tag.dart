import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:thanks/components/animation/show_up.dart';
import 'package:thanks/generated/i18n.dart';
import 'package:thanks/models/hex_color.dart';
import 'package:thanks/models/structure.dart';

class StoryTagPage extends StatefulWidget {
  final DateTime targetDate;
  final Function nextPage;
  final String feeling;

  final Function(String) setter;

  StoryTagPage({
    @required this.targetDate,
    @required this.setter,
    @required this.nextPage,
    @required this.feeling,
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
              padding: EdgeInsets.only(
                top: 32,
                left: 32,
              ),
              child: ShowUp(
                child: Text(
                  DateFormat(
                    S.of(context).titleDateFormat(
                      () {
                        switch (DateFormat("EEEE").format(widget.targetDate)) {
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
                  ).format(widget.targetDate),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
                animatedOpacity: true,
                begin: Offset.zero,
                duration: Duration(milliseconds: 500),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
              child: Text(
                widget.targetDate.isBefore(
                  DateTime(_now.year, _now.month, _now.day),
                )
                    ? "${_getFeelingTranslation(widget.feeling)} 이 날,\n어떤 일에 감사했나요?"
                    : "${_getFeelingTranslation(widget.feeling)} 오늘 하루,\n어떤 것에 감사한가요?",
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
          if (name > 0)
            widget.setter(tagList[name - 1]);
          else
            return;
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

  String _getFeelingTranslation(String feeling) {
    if (feeling.runtimeType != String)
      return '';
    else if (Feelings.great.toString() == feeling)
      return "기분이 좋은";
    else if (Feelings.notGood.toString() == feeling)
      return "그저 그런";
    else if (Feelings.sad.toString() == feeling)
      return "슬픈";
    else if (Feelings.angry.toString() == feeling)
      return "화났던";
    else
      return '\uD83E\uDD14';
  }
}
