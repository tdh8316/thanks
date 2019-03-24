import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  static int _index = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  tabController(index) {
    _index = index;
  }

  BottomNavyBar navigationBar() => BottomNavyBar(
        currentIndex: _index,
        onItemSelected: (index) => setState(() => tabController(index)),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text("Home"),
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.event_note),
            title: Text("Writing"),
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.book),
            title: Text("Entries"),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    DateTime nowTime = DateTime.now();
    var dateWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 32, left: 56),
          child: Text(
            "${DateFormat("EEEE").format(nowTime)}",
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
    return Scaffold(
      body: SafeArea(
        child: dateWidget,
      ),
      bottomNavigationBar: navigationBar(),
    );
  }
}
