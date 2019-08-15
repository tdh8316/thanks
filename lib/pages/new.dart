import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thanks/pages/storyboard/1.select_date.dart';
import 'package:thanks/styles/default.dart';

class NewPost extends StatefulWidget {
  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> with SingleTickerProviderStateMixin {
  AnimationController _animationControllerFab;

  List<Widget> _storyBoard = [
    StorySelectDate(),
    Container(child: Center(child: Text("1", style: TextStyle(fontSize: 69)))),
    Container(child: Center(child: Text("2", style: TextStyle(fontSize: 69)))),
    Container(child: Center(child: Text("3", style: TextStyle(fontSize: 69)))),
  ];

  @override
  void initState() {
    super.initState();
    _animationControllerFab = AnimationController(
      duration: Duration(milliseconds: 100),
      upperBound: 0.25,
      vsync: this,
    );
    Timer(
      Duration(milliseconds: 100),
      () {
        setState(() {
          _animationControllerFab.forward(from: 0.0);
        });
      },
    );
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "new",
        elevation: 12,
        onPressed: () async {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
          );
          await _animationControllerFab.reverse(from: 0.5);
          Navigator.of(context).pop();
        },
        child: RotationTransition(
          turns: Tween(begin: 0.0, end: .5).animate(_animationControllerFab),
          child: Icon(Icons.add, size: 32),
        ),
        backgroundColor: DefaultStyle.primary3,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: PageView(
        scrollDirection: Axis.vertical,
        children: _storyBoard,
      ),
    );
  }
}
