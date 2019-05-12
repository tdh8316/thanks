import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatisticTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StatisticTabState();
}

class _StatisticTabState extends State<StatisticTab>
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
      child: Center(child: Text("Statistic", style: TextStyle(fontSize: 64))),
    );
  }
}
