import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thanks/pages/storyboard/1.select_date.dart';
import 'package:thanks/pages/storyboard/2.rate_day.dart';
import 'package:thanks/styles/default.dart';

class NewPost extends StatefulWidget {
  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> with SingleTickerProviderStateMixin {
  static final PageController _pageController = PageController();
  AnimationController _animationControllerFab;

  static final StorySelectDate _storySelectDate = StorySelectDate(
    pageController: _pageController,
  );
  static final StoryRateDay _storyRateDay = StoryRateDay(
    pageController: _pageController,
  );

  final List<Widget> _storyBoard = [
    _storySelectDate,
    _storyRateDay,
    Container(
      child: Center(
        child: ErrorWidget(
          "NotImplemented",
        ),
      ),
    ),
  ];

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
              .catchError(
                (_) => null,
              );
          Navigator.of(context).pop();
        },
        child: RotationTransition(
          turns: Tween(begin: 0.0, end: .5).animate(_animationControllerFab),
          child: Icon(Icons.add, size: 32, color: Colors.white),
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
}
