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
  double _sliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // SizedBox(height: MediaQuery.of(context).size.height / 4),
        SizedBox(height: MediaQuery.of(context).size.height / 5),
        /*Align(
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
        Padding(
          padding:  EdgeInsets.all(32),
          child: Slider.adaptive(
            value: _sliderValue,
            onChanged: (double ptr) {
              setState(() {
                _sliderValue = ptr;
              });
            },
            divisions: 6,
            max: .6,
            activeColor: Colors.white,
            inactiveColor: Colors.white,
          ),
        ),*/
        Text(
          "How was your day today?",
          style: Theme.of(context)
              .textTheme
              .headline
              .copyWith(color: Colors.black87),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 10),
        Text("Icon unavailable"),
        Padding(
          padding: EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 4),
          child: Slider.adaptive(
            value: _sliderValue,
            onChanged: (double ptr) {
              setState(() {
                _sliderValue = ptr;
              });
            },
            max: 1,
            activeColor: DefaultStyle.primary4,
            inactiveColor: DefaultStyle.primary4,
          ),
        ),
        Row(
          children: <Widget>[
            SizedBox(width: 32),
            Material(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Terrible".toUpperCase(),
                  style: Theme.of(context).textTheme.caption.copyWith(
                        color: DefaultStyle.primary3,
                      ),
                ),
              ),
              color: DefaultStyle.primary3.withOpacity(.25),
              shape: StadiumBorder(),
            ),
            Spacer(),
            Material(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Awesome".toUpperCase(),
                  style: Theme.of(context).textTheme.caption.copyWith(
                        color: DefaultStyle.primary3,
                      ),
                ),
              ),
              color: DefaultStyle.primary3.withOpacity(.25),
              shape: StadiumBorder(),
            ),
            SizedBox(width: 32),
          ],
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Unknown",
            style: Theme.of(context).textTheme.headline,
          ),
        ),
        // Text("Description unavailable"),
        Spacer(),
        MaterialButton(
          onPressed: () => widget.pageController.animateToPage(
            1,
            curve: Curves.fastOutSlowIn,
            duration: Duration(seconds: 1),
          ),
          minWidth: MediaQuery.of(context).size.width / 1.5,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "continue".toUpperCase(),
              style: Theme.of(context).textTheme.button.copyWith(
                color: DefaultStyle.primary4,
              )
            ),
          ),
          color: DefaultStyle.backgroundedTextColor,
          shape: StadiumBorder(),
        ),
        Spacer(),
        /*Flexible(
          child: GridView.count(
            crossAxisCount: 5,
            padding: EdgeInsets.all(8),
            children: <Widget>[
              Icon(Icons.sentiment_very_dissatisfied),
              Icon(Icons.sentiment_dissatisfied),
              Icon(Icons.sentiment_neutral),
              Icon(Icons.sentiment_satisfied),
              Icon(Icons.sentiment_very_satisfied),
            ],
          ),
        ),*/
        /*FlatButton.icon(onPressed: (){}, icon: Icon(Icons.sentiment_very_satisfied), label: Text("GOOD")),
        FlatButton.icon(onPressed: (){}, icon: Icon(Icons.sentiment_satisfied), label: Text("GOOD")),
        FlatButton.icon(onPressed: (){}, icon: Icon(Icons.sentiment_neutral), label: Text("GOOD")),
        FlatButton.icon(onPressed: (){}, icon: Icon(Icons.sentiment_dissatisfied), label: Text("GOOD")),*/
      ],
    );
  }
}
