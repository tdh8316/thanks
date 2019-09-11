import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thanks/generated/i18n.dart';

class NewJournalPage extends StatelessWidget {
  final DateTime _now = DateTime.now();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              S.of(context).home,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding:  EdgeInsets.all(32),
                  child: Text(
                    DateFormat(
                      S.of(context).titleDateFormat(
                        () {
                          switch (DateFormat("EEEE").format(_now)) {
                            case "Monday":
                              return S.of(context).Monday;
                            case "Tuesday":
                              return S.of(context).Tuesday;
                            case "Wednesday":
                              return S.of(context).Wednesday;
                            case "Thursday":
                              return S.of(context).Thursday;
                            case "Friday":
                              return S.of(context).Friday;
                            case "Saturday":
                              return S.of(context).Saturday;
                            case "Sunday":
                              return S.of(context).Sunday;
                            default:
                              return "Unknown Date";
                          }
                        }(),
                      ),
                    ).format(_now),
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
                Expanded(
                  child: Image.asset(""),
                ),
              ],
            ),
          ),
        ),
      );
}
