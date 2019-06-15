import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thanks/core/i18n.dart';

class Index extends StatefulWidget {
  Widget dateWidget() {
    DateTime date = DateTime.now();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 32, left: 32),
          child: Text(
            "${tr(DateFormat("EEEE").format(date))}",
            style: TextStyle(
              fontSize: 38,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 4, left: 64),
          child: Text(
            "${DateFormat("d").format(date)} ${DateFormat("MMM").format(date)}",
            style: TextStyle(
              fontSize: 28,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

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
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color.fromARGB(255, 36, 39, 52),
      /*appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 36, 39, 52),
        // TODO: Change to an icon
        title: Center(
          child: Text(
            "Thanks",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Potra",
            ),
          ),
        ),
        elevation: 0,
      ),*/
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Color.fromARGB(255, 36, 39, 52),
              expandedHeight: 200,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  "Thanks",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Potra",
                  ),
                ),
              ),
            ),
          ];
        },
        body: Column(
          children: <Widget>[
            Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 32),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: <Color>[
                        Color.fromARGB(255, 115, 75, 245),
                        Color.fromARGB(255, 185, 90, 250),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      widget.dateWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
