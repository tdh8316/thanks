/*
Application root
 - Generate tab widgets
 */

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thanks/screens/tabs/entries_tab.dart' show EntriesTab;
import 'package:thanks/screens/tabs/home_tab.dart' show HomeTab;
import 'package:thanks/screens/tabs/writing_tab.dart' show WritingTab;

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  static int _index = 0;
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  tabController(index) {
    _index = index;
    _controller.animateTo(_index, curve: Curves.easeOut);
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
    return Scaffold(
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          HomeTab(),
          WritingTab(),
          EntriesTab(),
        ],
      ),
      bottomNavigationBar: navigationBar(),
    );
  }
}
