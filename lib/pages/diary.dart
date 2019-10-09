import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:thanks/components/popup_calendar.dart';
import 'package:thanks/generated/i18n.dart';
import 'package:thanks/models/shared.dart';
import 'package:thanks/models/structure.dart';
import 'package:thanks/pages/done.dart';
import 'package:thanks/services/storage.dart';
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
  final TextEditingController editingController = TextEditingController();
  DateTime _dateTime;
  ScrollController scrollController = ScrollController();
  EditorAction panelAction;

  @override
  void initState() {
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) =>
          visible ? panelController.hide() : panelController.show(),
    );
    _dateTime = widget.dateTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () =>
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Are you sure?'),
                content: Text('Are you sure you want to close this activity?'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text('No'),
                  ),
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text('Yes'),
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
                        controller: editingController,
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
              panel: _buildPanel(),
              collapsed: Row(
                children: <Widget>[
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colors.grey,
                      size: 28,
                    ),
                    onPressed: () {
                      panelController.open();
                      setState(() {
                        panelAction = EditorAction.date;
                      });
                    },
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.add_location,
                      color: Colors.grey,
                      size: 28,
                    ),
                    onPressed: () {
                      panelController.open();
                      setState(() {
                        panelAction = EditorAction.location;
                      });
                    },
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.image,
                      color: Colors.grey,
                      size: 28,
                    ),
                    onPressed: () {
                      panelController.open();
                      setState(() {
                        panelAction = EditorAction.image;
                      });
                    },
                  ),
                  Spacer(),
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0),
              ),
            ),
          ),
        ),
      );

  Widget _buildPanel() {
    switch (panelAction) {
      case EditorAction.date:
        return FractionallySizedBox(
          heightFactor: 1.125,
          widthFactor: 1.05,
          child: CalendarPopupView(
            barrierDismissible: true,
            maximumDate: DateTime.now(),
            onApplyClick: (DateTime selectedDate) {
              setState(() {
                _dateTime = selectedDate;
              });
            },
          ),
        );
      case EditorAction.location:
        return Text("Location");
      case EditorAction.image:
        return Text("Image");
      default:
        return Container();
    }
  }

  Future<Null> _save() async {
    savePlainEntry(
      feelings: widget.feeling,
      content: editingController.text,
      time: _dateTime,
    );

    StaticSharedPreferences.prefs.setStringList(
      "latestDate",
      [
        "${_dateTime.year}",
        "${_dateTime.day}",
      ],
    );
    // genFakeData();
    updateItems();
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => DoneWritingPage(),
      ),
    );
  }
}
