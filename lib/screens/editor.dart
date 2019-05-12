import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zefyr/zefyr.dart';

class WritingTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WritingTabState();
}

class _WritingTabState extends State<WritingTab>
    with SingleTickerProviderStateMixin {
  final ZefyrController _controller = ZefyrController(NotusDocument());
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
        decoration: InputDecoration(labelText: 'Description'),
        controller: _controller,
        focusNode: _focusNode,
        autofocus: true,
        physics: ClampingScrollPhysics(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: ZefyrScaffold(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: buildEditor(),
        ),
      ),
    );
  }
}
