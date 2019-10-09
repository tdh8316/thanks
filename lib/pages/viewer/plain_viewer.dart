import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
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
                // Delete
                await removeEntryFromDate(string: widget.date);
                StaticSharedPreferences.prefs.remove("latestDate");
                await updateItems();
                Navigator.pop(context);
                Flushbar(
                  flushbarPosition: FlushbarPosition.BOTTOM,
                  message: "${widget.date} 삭제됨.",
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 5),
                  borderRadius: 8,
                  margin: EdgeInsets.all(8),
                )..show(context);
              },
            )
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
                          JsonEncoder.withIndent('\t')
                              .convert(jsonDecode(snapshot.data)),
                        ),
                      ),
                    );
              }
            },
          ),
        ),
      );
}
