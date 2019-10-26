import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) => Scaffold(
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
                    this.tag = value;
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
                tag: tag,
              ),
              FinishStoryPage(
                save: _save,
              ),
            ],
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
    saveEntry(
      content: elaborateTextEditingController.text,
      date: widget.dateTime,
      feelings: widget.feeling,
      tag: this.tag,
    );

    updateLatestWriting(widget.dateTime);

    Navigator.of(context).pop();
  }
}
