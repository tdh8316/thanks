import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thanks/pages/index.dart';

class Application extends StatelessWidget {
  Application() {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
      ],
    );
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Ubuntu",
      ),
      title: "All that Thanks",
      home: Index(),
    );
  }
}

void main() => runApp(Application());
