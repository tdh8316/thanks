import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:thanks/components/animation/show_up.dart';
import 'package:thanks/generated/i18n.dart';
import 'package:thanks/models/hex_color.dart';
import 'package:thanks/models/structure.dart';
import 'package:thanks/styles/colors.dart';

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
  final TextEditingController otherTagTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Container(
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
                          switch (
                              DateFormat("EEEE").format(widget.targetDate)) {
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
                      : "${_getQuestion(widget.feeling)}",
                  softWrap: true,
                  style: TextStyle(
                    fontFamily: "나눔바른펜",
                    fontSize: 24,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Divider(),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 4,
                  children: <Widget>[
                    _imageIcon(1),
                    _imageIcon(2),
                    _imageIcon(3),
                    _imageIcon(4),
                    _imageIcon(5),
                    _imageIcon(6),
                    _imageIcon(7),
                    _imageIcon(8),
                    _imageIcon(9),
                    _imageIcon(10),
                    _imageIcon(-1),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget _imageIcon(int name) => FlatButton(
        shape: StadiumBorder(),
        onPressed: () async {
          if (name > 0)
            widget.setter(tagList[name - 1]);
          else {
            String customTag = await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('어떤 것에 감사한가요?'),
                  content: TextField(
                    controller: otherTagTextEditingController,
                    decoration: InputDecoration(
                      hintText: "직접 입력하세요!",
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        "확인",
                        style: TextStyle(color: DefaultColorTheme.main),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(
                          otherTagTextEditingController.text,
                        );
                      },
                    ),
                  ],
                );
              },
            );
            if (customTag == null || customTag == '') return;
            if (customTag.contains('.')) {
              Flushbar(
                flushbarPosition: FlushbarPosition.BOTTOM,
                message: "사용자 정의 태그에는 마침표(.)를 포함할 수 없습니다.",
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
                borderRadius: 8,
                margin: EdgeInsets.all(8),
              )..show(context);
              return;
            }
            widget.setter(customTag);
            await Future.delayed(Duration(milliseconds: 750));
          }
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
              Text(name > 0 ? tagList[name - 1] : "기타"),
              Spacer(),
            ],
          ),
        ),
      );

  String _getFeelingTranslation(String feeling) {
    if (feeling.runtimeType != String)
      return '';
    else if (Feelings.great.toString() == feeling)
      return "기분이 좋았던";
    else if (Feelings.notGood.toString() == feeling)
      return "그저 그랬던";
    else if (Feelings.sad.toString() == feeling)
      return "슬펐던";
    else if (Feelings.angry.toString() == feeling)
      return "화났던";
    else
      return '\uD83E\uDD14';
  }

  String _getQuestion(String feeling) {
    if (feeling.runtimeType != String)
      return '';
    else if (Feelings.great.toString() == feeling)
      return "기분이 좋았던 오늘!\n어떤 것에 감사한가요?";
    else if (Feelings.notGood.toString() == feeling)
      return "그저 그런 하루였지만,\n그럼에도 감사한 것은 있었겠죠?";
    else if (Feelings.sad.toString() == feeling)
      return "괜찮을 거예요. 슬퍼하고만 있지 말아요. 감사한 일을 생각해 볼까요?";
    else if (Feelings.angry.toString() == feeling)
      return "화났던 오늘 하루, 그래도...\n감사한 일을 생각해보아요.";
    else
      return '\uD83E\uDD14';
  }
}
