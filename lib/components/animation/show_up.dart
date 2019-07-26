import 'dart:async';

import 'package:flutter/material.dart';

class ShowUp extends StatefulWidget {
  final Widget child;
  final int delay;
  final Curve curve;
  final bool animatedOpacity;
  final Offset begin;

  ShowUp({
    @required this.child,
    this.delay,
    this.curve = Curves.elasticOut,
    this.animatedOpacity = false,
    this.begin = const Offset(0, .25),
  });

  @override
  _ShowUpState createState() => _ShowUpState();
}

class _ShowUpState extends State<ShowUp> with TickerProviderStateMixin {
  AnimationController _animController;
  Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _animController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 750));
    final curve = CurvedAnimation(curve: widget.curve, parent: _animController);
    _animOffset =
        Tween<Offset>(begin: widget.begin, end: Offset.zero).animate(curve);

    if (widget.delay == null) {
      _animController.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay), () {
        _animController.forward();
      });
    }
  }

  @override
  void dispose() {
    _animController.stop();
    super.dispose();
    _animController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.animatedOpacity
        ? FadeTransition(
            child: SlideTransition(
              position: _animOffset,
              child: widget.child,
            ),
            opacity: _animController,
          )
        : SlideTransition(
            position: _animOffset,
            child: widget.child,
          );
  }
}
