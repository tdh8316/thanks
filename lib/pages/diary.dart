import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:thanks/components/calendar.dart';
import 'package:thanks/generated/i18n.dart';
import 'package:thanks/models/shared.dart';
import 'package:thanks/models/structure.dart';
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
        onWillPop: () async =>
            await showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                content: Text("이 일기는 사라지는데 그래도 나갈래?"),
                actions: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: FlatButton(
                      shape: StadiumBorder(),
                      color: Colors.redAccent,
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('그래', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text('싫어', style: TextStyle(color: Colors.blue)),
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
        final DateTime now = DateTime.now();
        return FractionallySizedBox(
          heightFactor: 1.125,
          widthFactor: 1.05,
          child: DatePickerWidget(
            barrierDismissible: false,
            maximumDate: DateTime.now(),
            onApplyClick: (DateTime selectedDate) async {
              if (DateTime(
                selectedDate.year,
                selectedDate.month,
                selectedDate.day,
              ).isAfter(DateTime(now.year, now.month, now.day)))
                await showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                    content: Text("미래의 일기는 쓸 수 없어요!"),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('확인'),
                      ),
                    ],
                  ),
                );
              else {
                setState(() {
                  _dateTime = selectedDate;
                });
                panelController.close();
              }
            },
          ),
        );
      case EditorAction.location:
        return Center(child: Text("Location"));
      case EditorAction.image:
        return Center(child: Text("Image"));
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

    final List<String> latestDate =
        StaticSharedPreferences.prefs.getStringList("latestDate");

    if (latestDate == null ||
        latestDate.length != 3 ||
        _dateTime.isAfter(
          DateTime(
            int.parse(latestDate[0]), // year
            int.parse(latestDate[1]), // month
            int.parse(latestDate[2]), // day
          ),
        ))
      StaticSharedPreferences.prefs.setStringList(
        "latestDate",
        [
          "${_dateTime.year}",
          "${_dateTime.month}",
          "${_dateTime.day}",
        ],
      );

    Navigator.of(context).pop();
  }
}
