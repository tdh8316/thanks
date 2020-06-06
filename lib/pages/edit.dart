import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:thanks/models/structure.dart';
import 'package:thanks/services/storage.dart';
import 'package:thanks/styles/colors.dart';

class ContentEditor extends StatefulWidget {
  final String date;
  final String body;
  final String feeling;
  final String tag;

  ContentEditor({
    this.date,
    this.body,
    this.feeling,
    this.tag,
  });

  @override
  State<ContentEditor> createState() => _ContentEditorState();
}

class _ContentEditorState extends State<ContentEditor> {
  final TextEditingController editingController = TextEditingController();
  Map<String, dynamic> dataMap;

  @override
  void initState() {
    editingController.text = widget.body;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(child: contentViewer(context)),
      );

  Widget contentViewer(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 32,
        ),
        Text(
          "${widget.date}, ${widget.feeling}",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller: editingController,
              keyboardType: TextInputType.multiline,
              autofocus: true,
              maxLines: null,
              showCursor: true,
              expands: true,
              cursorColor: DefaultColorTheme.sub,
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 1.1,
                fontFamily: "나눔바른펜",
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: FractionallySizedBox(
            widthFactor: 0.5,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text("완료"),
              ),
              color: Colors.grey.withOpacity(.25),
              onPressed: () async {
                await _save();
                // Close the keyboard
                FocusScope.of(context).requestFocus(FocusNode());
              },
            ),
          ),
        ),
      ],
    );
  }

  _save() async {
    dataMap = jsonDecode(await loadPlainEntryFromDate(string: widget.date));
    dataMap[ItemElements.body.toString()] = editingController.text;
    var f = dataMap[ItemElements.feeling.toString()].toString();
    Feelings fe = Feelings.values.firstWhere((e) => e.toString() == f);
    // Save contents to a separated file
    if (widget.tag == null) {
      await savePlainEntry(
        feelings: fe,
        content: editingController.text,
        date: DateTime.parse(widget.date),
      );
    } else {
      await saveEntry(
        content: editingController.text,
        date: DateTime.parse(widget.date),
        feelings: fe,
        tag: widget.tag,
      );
    }
    Navigator.of(context).pop();
  }
}
