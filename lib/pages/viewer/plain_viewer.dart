import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:thanks/generated/i18n.dart';
import 'package:thanks/models/shared.dart';
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
              child: Text("삭제", style: TextStyle(color: Colors.red)),
              onPressed: () async {
                if (!await showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        content: Text("정말 이 추억을 지울거야?"),
                        actions: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: FlatButton(
                              shape: StadiumBorder(),
                              color: Colors.redAccent,
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text(
                                '지울래',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text(
                              '싫어',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ) ??
                    true) return;
                // Delete file located in internal storage
                await removeEntryFromDate(string: widget.date);

                if (listEquals<String>(
                  StaticSharedPreferences.prefs.getStringList("latestDate"),
                  this.widget.date.split('-'),
                )) StaticSharedPreferences.prefs.remove("latestDate");

                Navigator.of(context).pop();
                Flushbar(
                  flushbarPosition: FlushbarPosition.BOTTOM,
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
                  else
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          JsonEncoder.withIndent('\t').convert(
                            jsonDecode(snapshot.data),
                          ),
                        ),
                      ),
                    );
              }
            },
          ),
        ),
      );
}
