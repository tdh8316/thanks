import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerActivity extends StatefulWidget {
  final format = DateFormat("yyyy-MM-dd");
  final now = DateTime.now();

  @override
  State<StatefulWidget> createState() => _DatePickerActivityState();
}

class _DatePickerActivityState extends State<DatePickerActivity> {
  DateTime date;

  @override
  void initState() {
    super.initState();
    date = widget.now;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 128),
          Center(
            child: Text(
              "Ready to write\na new story?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 32,
                letterSpacing: .5,
              ),
            ),
          ),
          SizedBox(height: 128),
          Text(
            getTargetDate(),
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 32,
              letterSpacing: .5,
            ),
          ),
          MaterialButton(
            child: Icon(Icons.keyboard_arrow_down),
            onPressed: () async {
              final value = await showDatePicker(
                context: context,
                firstDate: DateTime(1970),
                initialDate: widget.now,
                lastDate: widget.now,
              );
              if (value != null) {
                setState(() {
                  date = value;
                });
              }
            },
          )
        ],
      ),
    );
  }

  String getTargetDate() => widget.format.format(date);
}
