import 'dart:async';

import 'package:flutter/material.dart';

class ShowUp extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Curve curve;
  final bool animatedOpacity;
  final Offset begin;
  final Duration duration;
  final Offset end;

  ShowUp({
    @required this.child,
    this.delay,
    this.curve = Curves.linear,
    this.animatedOpacity = false,
    this.begin = const Offset(0, 1),
    this.end = Offset.zero,
    this.duration = const Duration(seconds: 1),
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
        AnimationController(vsync: this, duration: widget.duration);
    final curve = CurvedAnimation(curve: widget.curve, parent: _animController);
    _animOffset =
        Tween<Offset>(begin: widget.begin, end: widget.end).animate(curve);

    if (widget.delay == null) {
      if (this.mounted) _animController.forward();
    } else {
      Timer(widget.delay, () {
        if (this.mounted) _animController.forward();
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
