import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thanks/components/question.dart';
import 'package:thanks/generated/i18n.dart';
import 'package:thanks/styles/colors.dart';

class PrevNewPage extends StatefulWidget {
  final DateTime initialDate;

  PrevNewPage({this.initialDate});

  @override
  State<PrevNewPage> createState() => _PrevNewPageState();
}

class _PrevNewPageState extends State<PrevNewPage> {
  DateTime targetDate;

  @override
  void initState() {
    targetDate = widget.initialDate ?? DateTime.now().subtract(Duration(days: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Colors.black),
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              S.of(context).home,
              style: TextStyle(color: Colors.black),
            ),
          ),
          elevation: 0,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 32),
                Padding(
                  padding: EdgeInsets.only(
                    left: 32,
                    right: 32,
                    top: 8,
                    bottom: 8,
                  ),
                  child: Question(
                    date: targetDate,
                    navigatorAction: Navigator.of(context).pushReplacement,
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Text(
                      "Story Date",
                      style: TextStyle(
                        color: DefaultColorTheme.main.withOpacity(.25),
                        fontSize: 64,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height / e / pi,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "${DateFormat("MMMM d").format(targetDate)}",
                              style:
                                  Theme.of(context).textTheme.headline.copyWith(
                                        fontSize: 32,
                                        // color: DefaultStyle.backgroundedTextColor.withOpacity(.6),
                                        fontWeight: FontWeight.w700,
                                      ),
                            ),
                            IconButton(
                              onPressed: _setDate,
                              tooltip: "이 이야기의 날짜를 선택하세요.",
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                //color: DefaultStyle.backgroundedTextColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 64),
              ],
            ),
          ),
        ),
      );

  Future<Null> _setDate() async {
    /*final DateTime now = DateTime.now();
    await showDialog<Null>(
        context: context,
        builder: (BuildContext context) => FractionallySizedBox(
          widthFactor: 0.9,
          heightFactor: 0.75,
          child: Scaffold(
                body: DatePickerWidget(
                  barrierDismissible: false,
                  maximumDate: DateTime.now(),
                  onApplyClick: (DateTime selectedDate) async {
                    if (DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                    ).isAfter(DateTime(now.year, now.month, now.day)))
                      await showCupertinoDialog(
                        context: context,
                        builder: (BuildContext context) => CupertinoAlertDialog(
                          content: Text("미래의 일기는 쓸 수 없어요!"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('확인'),
                            ),
                          ],
                        ),
                      );
                    else {
                      setState(() {
                        this.targetDate = selectedDate;
                      });
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
        ));
  }*/
    DateTime _targetDate = await showDatePicker(
          context: context,
          initialDate: targetDate,
          firstDate: DateTime(1970),
          lastDate: DateTime.now(),
        ) ??
        targetDate;

    setState(() {
      this.targetDate = _targetDate;
    });
  }
}
