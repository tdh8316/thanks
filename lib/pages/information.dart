import 'package:flutter/material.dart';
import 'package:thanks/styles/colors.dart';

class InformationPage extends StatefulWidget {
  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 32),
              Text(
                "All that Thanks",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  "의식적으로 일상에 감사하는 마음을 가지고\n감사의 마음 넓히기",
                  textAlign: TextAlign.center,
                ),
              ),
              // personal mental health mentor, cross-platform gratitude journal application built with flutter and 🤘🏼.
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                child: Card(
                  elevation: 16,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: DefaultColorTheme.main,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(32),
                        child: Text(
                          "모든 기능을 사용하기 위해 All that Thanks 를 구매하세요!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
  );
}
