import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thanks/components/animation/show_up.dart';
import 'package:thanks/generated/i18n.dart';
import 'package:thanks/models/hex_color.dart';
import 'package:thanks/models/structure.dart';
import 'package:thanks/styles/colors.dart';

class ElaborateStoryPage extends StatefulWidget {
  final Function nextPage;
  final TextEditingController textEditingController;
  final Function(bool) elaborateSetter;
  final Function elaborateGetter;
  final DateTime dateTime;
  final String feeling;
  final String tag;

  ElaborateStoryPage({
    @required this.nextPage,
    @required this.textEditingController,
    @required this.elaborateSetter,
    @required this.elaborateGetter,
    @required this.dateTime,
    @required this.feeling,
    @required this.tag,
  });

  @override
  State<ElaborateStoryPage> createState() => _ElaborateStoryPageState();
}

class _ElaborateStoryPageState extends State<ElaborateStoryPage> {
  @override
  Widget build(BuildContext context) => Container(
        color: HexColor("#f9f9f9"),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 32,
                  right: 32,
                  top: 64,
                  bottom: 32,
                ),
                child: Text(
                  "좋습니다! 어떤 일이 있었는지\n알려주시겠어요?",
                  textAlign: TextAlign.left,
                  softWrap: true,
                  style: TextStyle(
                    fontFamily: "나눔바른펜",
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Divider(),
            ),
            SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: ShowUp(
                child: Text(
                  DateFormat(
                    "        yyyy년 M월 dd일 ${() {
                      switch (DateFormat("EEEE").format(widget.dateTime)) {
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
                    }()}",
                  ).format(widget.dateTime),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                animatedOpacity: true,
                begin: Offset.zero,
                duration: Duration(milliseconds: 500),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "        오늘은 ${_getFeelingTranslation(widget.feeling)}"
                  "'${widget.tag}'에 감사한다.\n        왜냐하면...",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Expanded(
              child: widget.elaborateGetter() == null ||
                      widget.elaborateGetter() == false
                  ? _askElaborate(context)
                  : _input(context),
            ),
          ],
        ),
      );

  Widget _input(BuildContext context) => Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: widget.textEditingController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                showCursor: true,
                expands: true,
                cursorColor: DefaultColorTheme.sub,
                decoration: InputDecoration(
                  hintText: "이곳에 오늘의 이야기를 말해주세요.",
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 1.1,
                  fontFamily: "나눔바른펜",
                ),
              ),
            ),
          ),
          FlatButton(
            child: Text("완료"),
            onPressed: () async {
              await widget.nextPage();
              // Close the keyboard
              FocusScope.of(context).requestFocus(FocusNode());
            },
          ),
        ],
      );

  Widget _askElaborate(BuildContext context) => Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height / 6,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 26.0,
                      spreadRadius: 1.0,
                      offset: Offset(8, 8),
                    ),
                  ],
                ),
                child: FlatButton(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 60,
                      right: 60,
                      top: 18,
                      bottom: 18,
                    ),
                    child: Text(
                      "더 작성하기",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      widget.elaborateSetter(true);
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(64),
                  ),
                  color: DefaultColorTheme.main,
                ),
              ),
              SizedBox(height: 8),
              FlatButton(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 60,
                    right: 60,
                    top: 18,
                    bottom: 18,
                  ),
                  child: Text(
                    "싫어",
                    style: TextStyle(
                      color: DefaultColorTheme.main.withOpacity(0.825),
                      fontSize: 18,
                      letterSpacing: 1.01,
                    ),
                  ),
                ),
                onPressed: () {
                  widget.nextPage();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(64),
                ),
              ),
            ],
          ),
        ],
      );

  String _getFeelingTranslation(String feeling) {
    if (feeling.runtimeType != String)
      return '';
    else if (Feelings.great.toString() == feeling)
      return "기분이 정말 좋았고, ";
    else if (Feelings.notGood.toString() == feeling)
      return "그저 그랬다. 그래도 ";
    else if (Feelings.sad.toString() == feeling)
      return "슬픈 하루였지만 ";
    else if (Feelings.angry.toString() == feeling)
      return "화나는 하루였다. 그렇지만 ";
    else
      return '\uD83E\uDD14';
  }
}
