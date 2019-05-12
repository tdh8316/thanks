import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalendarTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(child: Text("Calendar", style: TextStyle(fontSize: 64))),
    );
  }
}
