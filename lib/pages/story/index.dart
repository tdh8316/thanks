import 'dart:math';

import 'package:flutter/material.dart';
import 'package:thanks/components/animation/show_up.dart';
import 'package:thanks/components/gen_maxim.dart';
import 'package:thanks/models/internal.dart';
import 'package:thanks/models/structure.dart';
import 'package:thanks/pages/story/elaborate.dart';
import 'package:thanks/pages/story/finish.dart';
import 'package:thanks/pages/story/tag.dart';
import 'package:thanks/services/storage.dart';

class StoryBoard extends StatefulWidget {
  final Feelings feeling;
  final DateTime dateTime;

  StoryBoard({
    @required this.feeling,
    @required this.dateTime,
  });

  State<StoryBoard> createState() => _StoryBoardState();
}

class _StoryBoardState extends State<StoryBoard> {
  PageController pageController;

  // These values is used to control data among the widgets
  String tag;

  bool elaborate;
  final TextEditingController elaborateTextEditingController =
      TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final int _maxim = Random.secure().nextInt(maxims.length);

  void nextPage() => pageController.nextPage(
        duration: Duration(milliseconds: 750),
        curve: Curves.fastOutSlowIn,
      );

  @override
  void initState() {
    pageController = PageController()
        /*..addListener(
        () {
          if (pageController.position.atEdge) {
            if (pageController.position.pixels == 0) {
               print("top");
            } 
            else {
              print("bottom");
            }
          }
        },
      )*/
        ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async =>
            await showDialog(
              context: context,
              builder: (context) => ShowUp(
                curve: Curves.elasticOut,
                begin: Offset(0, 0.25),
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  content: Text("이 일기는 사라지는데 그래도 나가시겠어요?"),
                  actions: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      height: 64,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        color: Colors.redAccent,
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '나갈래',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 5 * 2,
                      height: 64,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '싫어',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ) ??
            false,
        child: Scaffold(
          key: scaffoldKey,
          body: SafeArea(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              scrollDirection: Axis.vertical,
              children: <Widget>[
                StoryTagPage(
                  targetDate: widget.dateTime,
                  setter: (String value) {
                    setState(() {
                      this.tag = "tag.$value";
                    });
                  },
                  nextPage: this.nextPage,
                  feeling: widget.feeling.toString(),
                ),
                ElaborateStoryPage(
                  nextPage: this.nextPage,
                  textEditingController: elaborateTextEditingController,
                  elaborateSetter: (bool value) {
                    this.elaborate = value;
                  },
                  elaborateGetter: () => this.elaborate,
                  dateTime: widget.dateTime,
                  feeling: widget.feeling.toString(),
                  tag: tag?.split('.')?.last,
                ),
                FinishStoryPage(
                  save: _save,
                  pageController: pageController,
                  maxim: _maxim,
                ),
              ],
            ),
          ),
        ),
      );

  Future<Null> _save() async {
    if (tag == null) {
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("실패: 유효하지 않은 값을 저장하려고 했습니다."),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }
    // Save contents to a separated file
    await saveEntry(
      content: elaborateTextEditingController.text,
      date: widget.dateTime,
      feelings: widget.feeling,
      tag: this.tag,
    );

    updateLatestWriting(widget.dateTime);

    Navigator.of(context).pop();
  }
}
