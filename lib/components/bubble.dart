import 'package:flutter/material.dart';

class Bubble extends StatelessWidget {
  Bubble({this.message, this.time});

  final String message, time;

  @override
  Widget build(BuildContext context) {
    final bg = Colors.white;
    final align = CrossAxisAlignment.start;
    final radius = BorderRadius.only(
      topRight: Radius.circular(5.0),
      bottomLeft: Radius.circular(10.0),
      bottomRight: Radius.circular(5.0),
    );
    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(3.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: .5,
                spreadRadius: 1.0,
                color: Colors.black.withOpacity(.12),
              ),
            ],
            color: bg,
            borderRadius: radius,
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 48.0),
                child: Text(message),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Row(
                  children: <Widget>[
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 10.0,
                      ),
                    ),
                    SizedBox(width: 3.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SingleChildBubble extends StatelessWidget {
  SingleChildBubble({this.child, this.time});

  final String time;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bg = Colors.white;
    final align = CrossAxisAlignment.start;
    final radius = BorderRadius.only(
      topRight: Radius.circular(5.0),
      bottomLeft: Radius.circular(10.0),
      bottomRight: Radius.circular(5.0),
    );
    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(3.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: .5,
                spreadRadius: 1.0,
                color: Colors.black.withOpacity(.12),
              ),
            ],
            color: bg,
            borderRadius: radius,
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 48.0),
                child: child,
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Row(
                  children: <Widget>[
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 10.0,
                      ),
                    ),
                    SizedBox(width: 3.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
