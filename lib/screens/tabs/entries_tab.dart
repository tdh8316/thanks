import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EntriesTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EntriesTabState();
}

class _EntriesTabState extends State<EntriesTab>
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
    return Scaffold(
      body: SafeArea(
        child: Center(child: Text("ENTRIES", style: TextStyle(fontSize: 64))),
      ),
    );
  }
}
