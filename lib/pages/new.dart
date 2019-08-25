import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thanks/models/structs.dart';
import 'package:thanks/pages/storyboard/1.select_date.dart';
import 'package:thanks/pages/storyboard/2.rate_day.dart';
import 'package:thanks/styles/default.dart';

class NewPost extends StatefulWidget {
  @override
  State<NewPost> createState() => NewPostState();
}

class NewPostState extends State<NewPost> with SingleTickerProviderStateMixin {
  static final PageController _pageController = PageController();
  AnimationController _animationControllerFab;

  final Journal _journal = Journal(
    date: DateTime.now(),
  );

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
  void dispose() {
    super.dispose();
  }

  Future<bool> _confirmExit() =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you want to exit an App'),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No'),
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Yes'),
            ),
          ],
        ),
      ) ??
      false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _confirmExit,
      child: Scaffold(
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
            if (await _confirmExit()) Navigator.of(context).pop();
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
            children: <Widget>[
              StorySelectDate(
                pageController: _pageController,
                dateGetter: () => _journal.date,
                dateSetter: (date) {
                  setState(() {
                    _journal.date = date;
                  });
                },
              ),
              StoryRateDay(
                pageController: _pageController,
              ),
              Container(
                child: Center(
                  child: ErrorWidget(
                    "NotImplemented",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
