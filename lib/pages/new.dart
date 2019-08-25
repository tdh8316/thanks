import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thanks/models/structs.dart';
import 'package:thanks/pages/storyboard/1.select_date.dart';
import 'package:thanks/pages/storyboard/2.rate_day.dart';
import 'package:thanks/styles/default.dart';

class NewPost extends StatefulWidget {
  @override
  State<NewPost> createState() => NewPostState();
}

class NewPostState extends State<NewPost> with SingleTickerProviderStateMixin {
  PageController _pageController;
  AnimationController _animationControllerFab;
  double _primary1opacity = 0.75;
  double _primary2opacity = 1.0;

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
    _pageController = PageController()
      ..addListener(
        () {
          _primary2opacity =
              _pageController.page <= 1.0 ? 1 - _pageController.page : 0.0;
          _primary1opacity =
              _primary2opacity >= 0.25 ? _primary2opacity - 0.25 : 0.0;

          if (_primary1opacity <= 0.5 && _primary2opacity <= 0.5)
            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
              ),
            );
          else
            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.light,
              ),
            );
        },
      );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> exitRequest() async {
    if (_pageController.page == 0.0
        ? false
        : !await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Are you sure?'.toUpperCase()),
                content: Text(
                    "This story will not be saved and you cannot undone this action!"),
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
            false) return false;
    await _animationControllerFab
        .reverse(from: 0.5)
        .timeout(Duration(milliseconds: 64))
        .catchError((_) => null);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: exitRequest,
      child: Scaffold(
        primary: false,
        floatingActionButton: FloatingActionButton(
          heroTag: "new",
          tooltip: "Click to stop writing this story.",
          elevation: 12,
          onPressed: () async =>
              await exitRequest() ? Navigator.of(context).pop() : null,
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
                    DefaultStyle.primary1.withOpacity(_primary1opacity),
                    DefaultStyle.primary2.withOpacity(_primary2opacity),
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
            onPageChanged: (int page) {},
          ),
        ),
      ),
    );
  }
}
