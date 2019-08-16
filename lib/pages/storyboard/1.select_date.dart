import 'package:flutter/material.dart';
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
          SizedBox(height: MediaQuery.of(context).size.height / 2.5),
          Text(
            "${DateFormat("MMMM d").format(_date)}",
            style: TextStyle(fontSize: 32),
          ),
          IconButton(
            onPressed: _selectDate,
            icon: Icon(Icons.keyboard_arrow_down),
          ),
        ],
      ),
    );
  }

  Future<Null> _selectDate() async {
    DateTime _selectedDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now(),
    );
    if (_selectedDate != null) setState(() => _date = _selectedDate);
  }
}
