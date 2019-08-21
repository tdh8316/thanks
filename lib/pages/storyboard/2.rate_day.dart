import 'package:flutter/material.dart';
import 'package:thanks/styles/default.dart';

class StoryRateDay extends StatefulWidget {
  final PageController pageController;

  StoryRateDay({
    this.pageController,
  });

  @override
  State<StoryRateDay> createState() => _StoryRateDay();
}

class _StoryRateDay extends State<StoryRateDay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: MediaQuery.of(context).size.height / 4),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 32),
            child: Text(
              "How was your day today?",
              style: Theme.of(context)
                  .textTheme
                  .headline
                  .copyWith(color: DefaultStyle.backgroundedTextColor),
            ),
          ),
        ),
      ],
    );
  }
}
