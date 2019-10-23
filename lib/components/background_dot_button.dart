import 'package:flutter/material.dart';

class BackDotButton extends StatelessWidget {
  final String str;

  BackDotButton(this.str);

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          Positioned(
            child: Container(
              width: 40.0,
              height: 40.0,
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.3),
                  borderRadius: new BorderRadius.all(Radius.circular(30.0)),
                ),
                height: 35.0,
                width: 35.0,
              ),
            ),
          ),
          Positioned(
            child: Container(
              width: 74.0,
              height: 40.0,
              child: FlatButton(
                child: Text(
                  str,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      );
}
