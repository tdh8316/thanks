import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thanks/components/animation/show_up.dart';
import 'package:thanks/generated/i18n.dart';
import 'package:thanks/styles/colors.dart';

class Question extends StatelessWidget {
  final DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              DateFormat(
                S.of(context).titleDateFormat(
                  () {
                    switch (DateFormat("EEEE").format(now)) {
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
              ).format(now),
              style: Theme.of(context).textTheme.subhead,
            ),
            SizedBox(height: 16),
            Text(
              S.of(context).howWasYourDay,
              style: Theme.of(context).textTheme.headline,
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 8),
                ShowUp(
                  child: _buildButton(context, "좋아! 😊"),
                  animatedOpacity: true,
                  duration: Duration(milliseconds: 500),
                  begin: Offset(0, .1),
                ),
                SizedBox(height: 8),
                ShowUp(
                  child: _buildButton(context, "그저 그래 😐"),
                  animatedOpacity: true,
                  delay: Duration(milliseconds: 100),
                  duration: Duration(milliseconds: 250),
                  begin: Offset(0, .125),
                ),
                SizedBox(height: 8),
                ShowUp(
                  child: _buildButton(context, "너무 슬프다 😥"),
                  animatedOpacity: true,
                  delay: Duration(milliseconds: 200),
                  duration: Duration(milliseconds: 250),
                  begin: Offset(0, .25),
                ),
                SizedBox(height: 8),
                ShowUp(
                  child: _buildButton(context, "정말 화난다 😡"),
                  animatedOpacity: true,
                  delay: Duration(milliseconds: 300),
                  duration: Duration(milliseconds: 500),
                  begin: Offset(0, .5),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _buildButton(BuildContext context, String content) => FlatButton(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            content,
            style: Theme.of(context).textTheme.button.copyWith(
                  color: DefaultColorTheme.main,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: DefaultColorTheme.main, width: 0.75),
        ),
      );
}
