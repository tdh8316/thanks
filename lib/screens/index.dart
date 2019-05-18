/*
Application root
 - Generate tab widgets
 */

import 'package:flip_box_bar/flip_box_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thanks/screens/tabs/entries_tab.dart' show EntriesTab;
import 'package:thanks/screens/tabs/home_tab.dart';
import 'package:thanks/screens/tabs/profile_tab.dart';
import 'package:thanks/screens/tabs/statistic_tab.dart' show StatisticTab;
import 'package:thanks/screens/tabs/writing_tab.dart' show WritingTab;

class Index extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<Index> with SingleTickerProviderStateMixin {
  static int _index = 0;
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  setIndex(int index) {
    _index = index;
    _controller.animateTo(_index, curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    var flipBoxBar = FlipBoxBar(
      navBarHeight: 75.0,
      animationDuration: Duration(milliseconds: 1500),
      selectedIndex: _index,
      onIndexChanged: (index) => setState(() => setIndex(index)),
      items: [
        FlipBarItem(
          icon: Icon(Icons.home, color: Colors.black87),
          text: Text("Home", style: TextStyle(color: Colors.black)),
          frontColor: Colors.white,
          backColor: Colors.deepPurpleAccent[100],
        ),
        FlipBarItem(
          icon: Icon(Icons.calendar_today, color: Colors.black87),
          text: Text("Writing", style: TextStyle(color: Colors.black)),
          frontColor: Colors.white,
          backColor: Colors.indigoAccent[100],
        ),
        FlipBarItem(
          icon: Icon(Icons.pie_chart_outlined, color: Colors.black87),
          text: Text("statistic", style: TextStyle(color: Colors.black)),
          frontColor: Colors.white,
          backColor: Colors.blueAccent[100],
        ),
        FlipBarItem(
          icon: Icon(Icons.chrome_reader_mode, color: Colors.black87),
          text: Text("Entries", style: TextStyle(color: Colors.black)),
          frontColor: Colors.white,
          backColor: Colors.greenAccent[100],
        ),
        FlipBarItem(
          icon: Icon(Icons.tag_faces, color: Colors.black),
          text: Text("Profile", style: TextStyle(color: Colors.black87)),
          frontColor: Colors.white,
          backColor: Colors.orangeAccent[100],
        ),
      ],
    );
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // TODO: Change to an icon
        title: Center(
          child: Text(
            "Thanks",
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
        ),
        elevation: 0,
      ),
      body: TabBarView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          HomeTab(indexState: this),
          WritingTab(),
          StatisticTab(),
          EntriesTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 75.0,
        child: flipBoxBar,
      ),
    );
  }
}
