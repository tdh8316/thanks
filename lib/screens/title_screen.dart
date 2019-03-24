import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thanks/screens/app.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    splash();
  }

  Future<Timer> splash() async =>
      Timer(Duration(milliseconds: 2500), navigationPage);

  void navigationPage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => App()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "All that thanks",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..shader = LinearGradient(
                    end: Alignment.topRight,
                    colors: <Color>[Colors.amber[400], Color(0xff8921aa)],
                  ).createShader(
                    Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                  ),
              ),
            ),
          ),
          Center(
            child: Text(
              "Made with 💕 by 2019 DreamHigh",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
