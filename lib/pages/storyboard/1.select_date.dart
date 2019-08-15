import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class StorySelectDate extends StatefulWidget {
  @override
  State<StorySelectDate> createState() => _StorySelectDate();
}

class _StorySelectDate extends State<StorySelectDate> {
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
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
          SizedBox(height: 128),
          Text(
            "Create a new story",
            style: Theme.of(context).textTheme.display1,
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 2),
          Text(
            "${DateFormat("MMMM d").format(_date)}",
            style: Theme.of(context).textTheme.headline,
          ),
          MaterialButton(
            onPressed: _selectDate,
            child: Text(
              "Not today?",
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ],
      ),
    );
  }

  Future<Null> _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now().subtract(Duration(days: 7)),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    if (picked != null) setState(() => _date = picked);
  }
}
