import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thanks/models/fakes.dart';
import 'package:thanks/models/structs.dart';
import 'package:thanks/styles/default.dart';

class HomePage extends StatefulWidget {
  final DateTime now = DateTime.now();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            height: (MediaQuery.of(context).size.height / 5) * 3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  DefaultStyle.primary1,
                  DefaultStyle.primary2,
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: SafeArea(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                        Spacer(),
                        Text(
                          "Thanks",
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .copyWith(color: Colors.white),
                        ),
                        Spacer(),
                        Icon(
                          Icons.notifications,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "${DateFormat('dd').format(widget.now)}",
                        style: Theme.of(context).textTheme.display2.copyWith(
                              color: Colors.white70,
                            ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "${DateFormat('EEEE').format(widget.now)}\n"
                        "${DateFormat("MMM y").format(widget.now)}",
                        style: Theme.of(context).textTheme.subhead.copyWith(
                              color: Colors.white70,
                            ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  indent: 16,
                  endIndent: 16,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.only(left: 12, top: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Recent Posts",
                style: Theme.of(context).textTheme.title.copyWith(
                    fontSize: Theme.of(context).textTheme.title.fontSize - 2),
              ),
            ),
          ),
          _buildRecentPosts(context),
        ],
      ),
    );
  }

  Widget _buildRecentPosts(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.of(context).size.height / 5) * 0.9,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: fakeRecentPosts.length,
        itemBuilder: (context, i) {
          return SizedBox(
            width: MediaQuery.of(context).size.width / 2.5,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          fakeRecentPosts[i][DiaryStructure.date]
                              [DateConstants.day],
                          style: Theme.of(context).textTheme.title.copyWith(
                                color: DefaultStyle.primary3.withOpacity(.75),
                              ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          fakeRecentPosts[i][DiaryStructure.date]
                              [DateConstants.dayName],
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: DefaultStyle.grey1.withOpacity(.75),
                              ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        fakeRecentPosts[i][DiaryStructure.title],
                        style: Theme.of(context).textTheme.body1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
