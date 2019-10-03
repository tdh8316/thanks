import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:thanks/generated/i18n.dart';
import 'package:thanks/models/structure.dart';
import 'package:thanks/styles/colors.dart';

class DiaryPage extends StatefulWidget {
  final Feelings feeling;
  final DateTime dateTime;

  DiaryPage({
    @required this.feeling,
    @required this.dateTime,
  });

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  final PanelController panelController = PanelController();

  @override
  void initState() {
    super.initState();
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) =>
          visible ? panelController.hide() : panelController.show(),
    );
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () =>
            showDialog(
              context: context,
              builder: (context) => new AlertDialog(
                title: new Text('Are you sure?'),
                content:
                    new Text('Are you sure you want to close this activity?'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text('No'),
                  ),
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: new Text('Yes'),
                  ),
                ],
              ),
            ) ??
            false,
        child: Scaffold(
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
            actions: <Widget>[
              FlatButton(
                child: Text(
                  S.of(context).save,
                  style: TextStyle(color: DefaultColorTheme.main),
                ),
                onPressed: _save,
                shape: StadiumBorder(),
              ),
              SizedBox(width: 8),
            ],
          ),
          body: Container(
            color: Colors.white,
            child: SlidingUpPanel(
              controller: panelController,
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        showCursor: true,
                        expands: true,
                        cursorColor: DefaultColorTheme.sub,
                        onTap: () => panelController.hide(),
                        decoration: InputDecoration(
                          hintText: "Input your story here...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              panel: Center(
                child: Text("panel"),
              ),
              collapsed: Center(
                child: Text("collapsed"),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0),
              ),
            ),
          ),
        ),
      );

  Future<bool> _save() async {
    return false;
  }
}
