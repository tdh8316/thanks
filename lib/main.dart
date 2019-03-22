import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "All that Thanks",
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "나눔바른펜"),
      home: Splash(),
      routes: <String, WidgetBuilder>{
        "HomeTab": (BuildContext context) => HomeTab(),
      },
    );
  }
}

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashState();
}

class SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    return Timer(Duration(milliseconds: 2500), navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed("HomeTab");
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
              "Made with 💕 by 2019-DreamHigh",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeTabState();
}

class HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Hello"),
      ),
    );
  }
}
