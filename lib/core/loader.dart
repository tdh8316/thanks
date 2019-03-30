/*
Application core loader
 - Initialize i18n
 - TODO: Load Thanks Diaries
 */

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thanks/i18n/i18n.dart' show trHashMap, loadJsonAsString;
import 'package:thanks/screens/app.dart' show App;

Future<Null> initI18n(BuildContext context) async {
  trHashMap ??= json.decode(
    await loadJsonAsString(Localizations.localeOf(context).toString()),
  );
}

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    // Await 2500 milliseconds and navigate to App
    () async {
      Timer(
        Duration(milliseconds: 2500),
        () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => App(),
            ),
          );
        },
      );
    }();
  }

  @override
  Widget build(BuildContext context) {
    initI18n(context);
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

                // Foreground gradient of the text.
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
