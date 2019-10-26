import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thanks/components/animation/animated_transition.dart';
import 'package:thanks/components/animation/show_up.dart';
import 'package:thanks/components/gen_maxim.dart';
import 'package:thanks/models/hex_color.dart';
import 'package:thanks/styles/colors.dart';

class FinishStoryPage extends StatefulWidget {
  final Function save;
  final PageController pageController;
  final int maxim;

  FinishStoryPage({
    @required this.save,
    @required this.pageController,
    @required this.maxim,
  });

  @override
  _FinishStoryPageState createState() => _FinishStoryPageState();
}

class _FinishStoryPageState extends State<FinishStoryPage>
    with TickerProviderStateMixin {
  bool isOpened = false;
  Timer _timer;

  @override
  void initState() {
    _timer = Timer(
      Duration(seconds: 2),
      () => setState(() {
        isOpened = true;
      }),
    );
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Container(
          color: HexColor("#f9f9f9"),
          child: Column(
            children: <Widget>[
              SizedBox(height: 32),
              Text(
                "오늘의 포춘쿠키",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.5,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: AnimatedTransition(
                    vsync: this,
                    child: isOpened
                        ? Image.asset("res/assets/c2.png")
                        : ShowUp(
                            child: Image.asset("res/assets/c1.png"),
                            curve: Curves.bounceIn,
                            delay: Duration(milliseconds: 500),
                            duration: Duration(milliseconds: 1500),
                          ),
                    sizeCurve: Curves.easeOut,
                    fadeDuration: Duration(seconds: 0),
                  ),
                ),
              ),
              _buildMaxim(context),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Divider(),
              ),
              SizedBox(height: 32),
              FlatButton(
                shape: StadiumBorder(),
                color: DefaultColorTheme.main.withOpacity(.975),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 60,
                    right: 60,
                    top: 18,
                    bottom: 18,
                  ),
                  child: Text(
                    "확인",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: () => widget.save(),
              ),
              SizedBox(height: 2),
              FlatButton(
                shape: StadiumBorder(),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 18,
                    bottom: 18,
                  ),
                  child: Text(
                    "잠시만요, 뭔가 잊은 것 같아요.",
                    style: TextStyle(color: DefaultColorTheme.sub),
                  ),
                ),
                onPressed: () => widget.pageController.jumpToPage(1),
              ),
            ],
          ),
        ),
      );

  Widget _buildMaxim(BuildContext context) => ShowUp(
        delay: Duration(seconds: 2),
        animatedOpacity: true,
        curve: Curves.easeOutCirc,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
          child: Padding(
            padding: EdgeInsets.only(bottom: 32),
            child: Text(
              maxims[widget.maxim],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
              softWrap: true,
            ),
          ),
        ),
      );
}
