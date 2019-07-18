import 'package:flutter/material.dart';
import 'package:thanks/pages/home.dart';

class Index extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IndexState();
}

class _IndexState extends State<Index> with SingleTickerProviderStateMixin {
  TabController _tabController;
  final List<Widget> tabs = [
    HomePage(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: tabs,
      ),
    );
  }
}
