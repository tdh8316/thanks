import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thanks/components/question.dart';
import 'package:thanks/models/structure.dart';
import 'package:thanks/services/storage.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences prefs;
  List<Widget> journals = <Widget>[];
  ScrollController scrollController = ScrollController();

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
    loadAllItems();
    super.initState();
    scrollController.addListener(() {
      print(scrollController.position.pixels);
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          print("TOP");
        } else {
          print("BOTTOM");
        }
      }
    });
  }

  Future<Null> initSharedPreferences() async {
    var _prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs = _prefs;
    });
  }

  Future<Null> loadData(i) async {
    setState(() {
      //journals.add(Text(loadPlainEntry(i)));
    });
  }

  @override
  Widget build(BuildContext context) => Container(
        child: SafeArea(
          child: ListView.builder(
            controller: scrollController,
            itemCount: itemLength + 1,
            itemBuilder: (BuildContext context, int index) => Padding(
              padding: EdgeInsets.all(32),
              child: () {
                if (index == 0) {
                  if (showQuestion())
                    return Question();
                  else
                    return Text("Blank");
                } else {
                  Map data = loadPlainEntry(index - 1);
                  return item(
                    data[ItemElements.date],
                    data[ItemElements.feeling],
                    data[ItemElements.body],
                  );
                }
              }(),
            ),
          ),
        ),
      );

  Widget item(String date, String feeling, String body) => InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Not supported yet"),
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 1),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "$date. ${_getFeelingTranslation(feeling)}",
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Text(body),
              ),
            ],
          ),
        ),
      );

  String _getFeelingTranslation(String feeling) {
    switch (feeling) {
      case "great":
        return "좋아! \uD83D\uDE0A";
      case "notGood":
        return "그저 그래 \uD83D\uDE10";
      case "sad":
        return "너무 슬프다 \uD83D\uDE25";
      case "angry":
        return "정말 화난다 \uD83D\uDE21";
    }
  }
}
