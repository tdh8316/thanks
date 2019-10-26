import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:thanks/components/animation/show_up.dart';
import 'package:thanks/generated/i18n.dart';
import 'package:thanks/models/shared.dart';
import 'package:thanks/models/structure.dart';
import 'package:thanks/services/storage.dart';

class PlainEntryViewer extends StatefulWidget {
  final String date;

  PlainEntryViewer({
    this.date,
  });

  @override
  State<PlainEntryViewer> createState() => _PlainEntryViewerState();
}

class _PlainEntryViewerState extends State<PlainEntryViewer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  Map<String, dynamic> dataMap;

  @override
  Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
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
          actions: <Widget>[
            FlatButton(
              child: Text(
                "삭제",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
              onPressed: () async {
                bool del = await showDialog(
                      context: context,
                      builder: (context) => ShowUp(
                        curve: Curves.elasticOut,
                        begin: Offset(0, 0.25),
                        child: AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          content: Text("정말 이 추억을 지울거야?"),
                          title: Text("삭제 확인"),
                          actions: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 5,
                              height: 64,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                color: Colors.redAccent,
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
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
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
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
                    false;
                if (!del) return;
                // Delete file located in internal storage
                await removeEntryFromDate(
                    string: widget.date,
                    tag: dataMap[ItemElements.tag.toString()]);

                if (listEquals<String>(
                  StaticSharedPreferences.prefs.getStringList("latestDate"),
                  widget.date.split('-'),
                )) StaticSharedPreferences.prefs.remove("latestDate");

                Navigator.of(context).pop();
                Flushbar(
                  flushbarPosition: FlushbarPosition.TOP,
                  message: "${widget.date} 삭제됨.",
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 3),
                  borderRadius: 8,
                  margin: EdgeInsets.all(8),
                )..show(context);
              },
            ),
          ],
          elevation: 0,
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: FutureBuilder<String>(
            future: loadPlainEntryFromDate(string: widget.date),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: Text("Loading..."),
                  );
                default:
                  if (snapshot.hasError)
                    return ErrorWidget(snapshot.error);
                  else {
                    dataMap = jsonDecode(snapshot.data);
                    return SingleChildScrollView(child: contentViewer(context));
                  }
              }
            },
          ),
        ),
      );

  Widget contentViewer(BuildContext context) {
    List<String> dateList = widget.date.split('-');
    final String body = dataMap[ItemElements.body.toString()];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(32),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "${dateList[0]}년 ${dateList[1]}월 ${dateList[2]}일. 이 날은... "
              "${getFeelingTranslation(dataMap[ItemElements.feeling.toString()])}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Divider(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 48),
          child: dataMap.containsKey(ItemElements.tag.toString())
              ? Text(
                  "오늘은 ${dataMap[ItemElements.tag.toString()].split('.').last}로부터 고마움을 느꼈다."
                  " 왜냐하면...",
                  style: TextStyle(
                    // fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                )
              : Container(),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            child: Text(
              body.length > 0 ? body : "저장된 다른 내용이 없습니다.",
              style: TextStyle(
                fontSize: 18,
                letterSpacing: 1.14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
