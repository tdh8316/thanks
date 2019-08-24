import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thanks/components/animation/show_up.dart';
import 'package:thanks/components/share/bar.dart';
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
                AppBarWidget(),
                SizedBox(height: 12),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "${DateFormat('dd').format(widget.now)}",
                        style: Theme.of(context).textTheme.display2.copyWith(
                              color: DefaultStyle.backgroundedTextColor
                                  .withOpacity(.75),
                            ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "${DateFormat('EEEE').format(widget.now)}\n"
                        "${DateFormat("MMM y").format(widget.now)}",
                        style: Theme.of(context).textTheme.subhead.copyWith(
                              color: DefaultStyle.backgroundedTextColor
                                  .withOpacity(.75),
                            ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  indent: 16,
                  endIndent: 16,
                  color: DefaultStyle.backgroundedTextColor,
                ),
                Spacer(),
                _buildParagraph(context),
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

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _buildParagraph(BuildContext context) {
    // TODO: Paragraphs
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 12, right: 12, bottom: 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Let's get started\non your",
              style: Theme.of(context).textTheme.display1.copyWith(
                    color: DefaultStyle.backgroundedTextColor.withOpacity(.75),
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Text(
              "first story!",
              style: Theme.of(context).textTheme.display1.copyWith(
                    color: DefaultStyle.primary2,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentPosts(BuildContext context) {
    // TODO: New data structure
    var recentPosts = fakeRecentPosts;
    return SizedBox(
      height: (MediaQuery.of(context).size.height / 5) * 0.9,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: recentPosts.length,
        itemBuilder: (context, i) {
          return ShowUp(
            delay: Duration(milliseconds: i * 200),
            duration: Duration(seconds: 1),
            animatedOpacity: true,
            curve: Curves.elasticOut,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2.5,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            recentPosts[i][DiaryStructure.date]
                                [DateConstants.day],
                            style: Theme.of(context).textTheme.title.copyWith(
                                  color: DefaultStyle.primary3.withOpacity(.75),
                                ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            recentPosts[i][DiaryStructure.date]
                                [DateConstants.dayName],
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: DefaultStyle.grey1.withOpacity(.75),
                                ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          recentPosts[i][DiaryStructure.title],
                          style: Theme.of(context).textTheme.body1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
