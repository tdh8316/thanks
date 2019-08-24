import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thanks/styles/default.dart';

class StorySelectDate extends StatefulWidget {
  final PageController pageController;

  DateTime date = DateTime.now();

  StorySelectDate({
    this.pageController,
  });

  @override
  State<StorySelectDate> createState() => _StorySelectDate();
}

class _StorySelectDate extends State<StorySelectDate> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Status Bar decoration
        /*Container(
            height: MediaQuery.of(context).padding.top,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  DefaultStyle.primary1,
                  DefaultStyle.primary2,
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
          ),*/
        SizedBox(height: MediaQuery.of(context).size.height / 4),
        Text(
          "Create a new story",
          style: Theme.of(context)
              .textTheme
              .display1
              .copyWith(color: DefaultStyle.backgroundedTextColor),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / pi / 2),
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Text(
              "Story Date",
              style: TextStyle(
                color: DefaultStyle.primary4.withOpacity(.25),
                fontSize: 64,
                fontWeight: FontWeight.w600,
              ),
            ),
            Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height / e / pi),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "${DateFormat("MMMM d").format(widget.date)}",
                      style: Theme.of(context).textTheme.headline.copyWith(
                            fontSize: 32,
                            color: DefaultStyle.backgroundedTextColor
                                .withOpacity(.6),
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    IconButton(
                      onPressed: _selectDate,
                      tooltip: "Click to set the date of this story.",
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: DefaultStyle.backgroundedTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
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
              "I love it!".toUpperCase(),
              style: Theme.of(context).textTheme.title.copyWith(
                  color: DefaultStyle.primary1,
                  // fontFamily: "", // TODO: Font
                  fontWeight: FontWeight.w500),
            ),
          ),
          color: DefaultStyle.backgroundedTextColor,
          shape: StadiumBorder(),
        ),
        Spacer(),
      ],
    );
  }

  Future<Null> _selectDate() async {
    DateTime _selectedDate = await showDatePicker(
      context: context,
      initialDate: widget.date,
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now(),
    );
    if (_selectedDate != null) setState(() => widget.date = _selectedDate);
  }
}
