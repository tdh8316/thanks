/*
Application root
 - Generate tab widgets
 */

import 'package:flip_box_bar/flip_box_bar.dart';
import 'package:flutter/material.dart';
import 'package:thanks/screens/tabs/calendar_tab.dart' show CalendarTab;
import 'package:thanks/screens/tabs/entries_tab.dart' show EntriesTab;
import 'package:thanks/screens/tabs/profile_tab.dart';
import 'package:thanks/screens/tabs/statistic_tab.dart' show StatisticTab;

class Index extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IndexState();
}

class _IndexState extends State<Index> with SingleTickerProviderStateMixin {
  static int _index = 0;
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  tabController(index) {
    _index = index;
    _controller.animateTo(_index, curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          EntriesTab(),
          CalendarTab(),
          StatisticTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: FlipBoxBar(
        selectedIndex: _index,
        items: [
          FlipBarItem(
              icon: Icon(Icons.chrome_reader_mode, color: Colors.white),
              text: Text("Entries"),
              frontColor: Colors.purple,
              backColor: Colors.purpleAccent),
          FlipBarItem(
              icon: Icon(Icons.calendar_today, color: Colors.white),
              text: Text("Calendar"),
              frontColor: Colors.blue,
              backColor: Colors.blueAccent),
          FlipBarItem(
              icon: Icon(Icons.pie_chart_outlined, color: Colors.white),
              text: Text("statistic"),
              frontColor: Colors.deepOrange,
              backColor: Colors.deepOrangeAccent),
          FlipBarItem(
              icon: Icon(Icons.tag_faces, color: Colors.white),
              text: Text("Profile"),
              frontColor: Colors.pink,
              backColor: Colors.pinkAccent),
        ],
        onIndexChanged: (index) => setState(() => tabController(index)),
      ),
    );
  }
}
