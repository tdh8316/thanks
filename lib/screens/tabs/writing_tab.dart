import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zefyr/zefyr.dart';

class WritingTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WritingTabState();
}

class _WritingTabState extends State<WritingTab>
    with SingleTickerProviderStateMixin {
  int _thxCount = 1;
  ZefyrController _controller = ZefyrController(NotusDocument());
  final FocusNode _focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildEditor() {
    final theme = new ZefyrThemeData(
      toolbarTheme: ZefyrToolbarTheme.fallback(context).copyWith(
        color: Colors.grey.shade800,
        toggleColor: Colors.grey.shade900,
        iconColor: Colors.white,
        disabledIconColor: Colors.grey.shade500,
      ),
    );

    return ZefyrTheme(
      data: theme,
      child: ZefyrField(
        height: 200.0,
        decoration: InputDecoration(labelText: '감사일기 쓰던가말던가'),
        controller: _controller,
        focusNode: _focusNode,
        autofocus: true,
        physics: BouncingScrollPhysics(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 16, left: 8),
            child: Text(
              "What are you thankful for today?",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16, left: 16),
            child: SizedBox(
              width: 250,
              child: TextField(
                decoration: InputDecoration(
                  labelText: "$_thxCount.",
                ),
              ),
            ),
          ),
          Text("TODO"),
          Expanded(
            child: ZefyrScaffold(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildEditor(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
