import 'package:flutter/material.dart';
import 'package:thanks/models/structure.dart';
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
  @override
  Widget build(BuildContext context) => Scaffold(
        body: PageView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            StoryTagPage(),
          ],
        ),
      );
}
