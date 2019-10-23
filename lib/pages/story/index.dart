import 'package:flutter/material.dart';
import 'package:thanks/models/structure.dart';
import 'package:thanks/pages/story/elaborate.dart';
import 'package:thanks/pages/story/tag.dart';

class StoryBoard extends StatefulWidget {
  final Feelings feeling;
  final DateTime dateTime;

  StoryBoard({
    @required this.feeling,
    @required this.dateTime,
  });

  State<StoryBoard> createState() => _StoryBoardState();
}

class _StoryBoardState extends State<StoryBoard> {
  final PageController pageController = PageController();

  String tag;

  void nextPage() => pageController.nextPage(
        duration: Duration(milliseconds: 750),
        curve: Curves.fastOutSlowIn,
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: PageView(
            controller: pageController,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              StoryTagPage(
                targetDate: widget.dateTime,
                setter: (String value) {
                  setState(() {
                    this.tag = value;
                  });
                },
                nextPage: this.nextPage,
              ),
              ElaborateStoryPage(nextPage: this.nextPage),
            ],
          ),
        ),
      );
}
