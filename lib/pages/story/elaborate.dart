import 'package:flutter/material.dart';
import 'package:thanks/models/hex_color.dart';
import 'package:thanks/styles/colors.dart';

class ElaborateStoryPage extends StatefulWidget {
  final Function nextPage;

  ElaborateStoryPage({@required this.nextPage});

  @override
  State<ElaborateStoryPage> createState() => _ElaborateStoryPageState();
}

class _ElaborateStoryPageState extends State<ElaborateStoryPage> {
  bool elaborate;

  @override
  Widget build(BuildContext context) => Container(
        color: HexColor("#f9f9f9"),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
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
            elaborate == null || elaborate == false
                ? _askElaborate(context)
                : TextField(),
          ],
        ),
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
                      "그래",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      this.elaborate = true;
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
}
