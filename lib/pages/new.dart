import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thanks/pages/storyboard/1.select_date.dart';
import 'package:thanks/styles/default.dart';

class NewPost extends StatefulWidget {
  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> with SingleTickerProviderStateMixin {
  AnimationController _animationControllerFab;
  static final PageController _pageController = PageController();

  List<Widget> _storyBoard = [
    StorySelectDate(pageController: _pageController),
    Container(
        child: Center(child: Text("Hello", style: TextStyle(fontSize: 69)))),
    Container(
        child: Center(
            child: Text("Ready to write?", style: TextStyle(fontSize: 32)))),
    Container(
        child: Center(child: Text("Yeah!", style: TextStyle(fontSize: 32)))),
    Container(
        child: Center(child: Text("🤘🏼", style: TextStyle(fontSize: 69)))),
    Container(
        child: Center(child: Text("Done!", style: TextStyle(fontSize: 69)))),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: false,
      floatingActionButton: FloatingActionButton(
        heroTag: "new",
        tooltip: "Click to stop writing this story.",
        elevation: 12,
        onPressed: () async {
          await _animationControllerFab
              .reverse(from: 0.5)
              .timeout(
                Duration(milliseconds: 64),
              )
              .catchError((_) => null);
          Navigator.of(context).pop();
        },
        child: RotationTransition(
          turns: Tween(begin: 0.0, end: .5).animate(_animationControllerFab),
          child: Icon(Icons.add, size: 32),
        ),
        backgroundColor: DefaultStyle.primary3,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: AnimatedBuilder(
        animation: _pageController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  DefaultStyle.primary1.withOpacity(.75),
                  DefaultStyle.primary2,
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
            child: child,
          );
        },
        child: PageView(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          children: _storyBoard,
        ),
      ),
    );
  }
}
