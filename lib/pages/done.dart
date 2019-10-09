import 'package:flutter/material.dart';

class DoneWritingPage extends StatefulWidget {
  @override
  State<DoneWritingPage> createState() => _DoneWritingPageState();
}

class _DoneWritingPageState extends State<DoneWritingPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Colors.black),
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "오늘의 감사 일기",
              style: TextStyle(color: Colors.black),
            ),
          ),
          elevation: 0,
        ),
        body: Container(
          // color: Colors.white,
          child: Column(
            children: <Widget>[
              Spacer(),
              Center(child: Text("이 공간을 마음대로 꾸며주세요!")),
              Spacer(),
            ],
          ),
        ),
      );
}
