import 'dart:async';
import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:thanks/i18n/i18n.dart' show trHashMap, loadJsonAsString;
import 'package:thanks/screens/index.dart' show Index;

Future<Null> initI18n(BuildContext context) async {
  // Assign translations to hash-map if the hash-map is null
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
    () async {
      await initI18n(context);
    }();
    Future.delayed(Duration(seconds: 2)).then(
      (_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Index(),
          ),
        );
      },
    );
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
            child: ColorizeAnimatedTextKit(
              text: ["All that Thanks"],
              textStyle: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
              ),
              colors: [
                Colors.purple,
                Colors.blue,
                Colors.yellow,
                Colors.red,
              ],
              textAlign: TextAlign.start,
              alignment: Alignment.topLeft, // or Alignment.topLeft
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 8)),
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
