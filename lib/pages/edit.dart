import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:thanks/components/animation/show_up.dart';
import 'package:thanks/models/hex_color.dart';
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
  Widget build(BuildContext context) => WillPopScope(
        child: Scaffold(
          body: SafeArea(child: contentViewer(context)),
        ),
        onWillPop: () async {
          return await showDialog(
                context: context,
                builder: (context) => ShowUp(
                  curve: Curves.elasticOut,
                  begin: Offset(0, 0.25),
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    content: Text("수정한 내용이 사라지는데 그래도 나가시겠어요?"),
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
              false;
        },
      );

  Widget contentViewer(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 16,
        ),
        Row(
          children: <Widget>[
            Spacer(),
            Text(
              "${widget.date}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 8),
            Text(
              "기분: ${widget.feeling}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: Divider(),
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
                fontSize: 18,
                letterSpacing: 1.1,
                fontFamily: "나눔바른펜",
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: FractionallySizedBox(
            widthFactor: 0.4,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: FlatButton(
                shape: StadiumBorder(),
                child: Padding(
                  padding: EdgeInsets.all(14),
                  child: Text(
                    "완료",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                color: HexColor("#FFAF7D"),
                onPressed: () async {
                  await _save();
                  // Close the keyboard
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              ),
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
