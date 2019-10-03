import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thanks/components/question.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences prefs;

  bool showQuestion() {
    final DateTime _now = DateTime.now();
    List<String> latestDate = prefs?.getStringList("latestDate");
    if (latestDate == null) return true;
    return (latestDate[1] != _now.day.toString()) |
            (latestDate[0] != _now.year.toString())
        ? true
        : false;
  }

  @override
  void initState() {
    initSharedPreferences();
    super.initState();
  }

  Future<Null> initSharedPreferences() async {
    var _prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs = _prefs;
    });
  }

  @override
  Widget build(BuildContext context) => Container(
        child: SafeArea(
          child: Scrollbar(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int i) {
                return Padding(
                  padding: EdgeInsets.all(32),
                  child: () {
                    switch (i) {
                      case 0:
                        if (showQuestion()) return Question();
                        continue _;
                      _:
                      default:
                        return Text(i.toString());
                    }
                    return null;
                  }(),
                );
              },
            ),
          ),
        ),
      );
}
