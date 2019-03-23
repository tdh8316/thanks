import 'package:flutter/material.dart';
import 'package:thanks/screens/title_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "All that Thanks",
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "나눔바른펜"),
      home: Splash(),
    );
  }
}
