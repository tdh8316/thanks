/*
Tab widget - Home
 - Date widget
 - TODO: Graph widget
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:intl/intl.dart';
import 'package:thanks/i18n/i18n.dart' show tr;

class HomeTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
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
    DateTime nowTime = DateTime.now();
    var dateWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 32, left: 56),
          child: Text(
            "${tr(DateFormat("EEEE").format(nowTime))}",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 2, left: 64),
          child: Text(
            "${DateFormat("d").format(nowTime)} ${DateFormat("MMM").format(nowTime)}",
            style: TextStyle(
              fontSize: 26,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );

    List<double> data = [3, 2, 4, 3, 1, 2, 4];

    Sparkline graph = Sparkline(
      data: data,
    );

    var graphWidget = Container(child: graph);

    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            dateWidget,
            Padding(padding: EdgeInsets.all(64)),
            // graphWidget,
          ],
        ),
      ),
    );
  }
}
