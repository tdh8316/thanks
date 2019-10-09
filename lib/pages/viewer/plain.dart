import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thanks/generated/i18n.dart';
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
          elevation: 0,
        ),
        body: FutureBuilder<String>(
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
                      padding:  EdgeInsets.all(8),
                      child: Text(
                        JsonEncoder.withIndent('\t').convert(jsonDecode(snapshot.data)),
                      ),
                    ),
                  );
            }
          },
        ),
      );
}
