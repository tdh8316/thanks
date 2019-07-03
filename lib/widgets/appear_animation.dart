import 'dart:async';

import 'package:flutter/widgets.dart';

class AppearWithAnimation extends StatefulWidget {
  final Widget child;
  final int delay;
  final Curve curve;
  final bool animatedOpacity;
  final Offset offsetBegin;
  final Duration duration;

  const AppearWithAnimation({
    @required this.child,
    this.delay = 0,
    this.curve = Curves.ease,
    this.animatedOpacity = false,
    this.offsetBegin = const Offset(0, .5),
    this.duration = const Duration(milliseconds: 750),
  });

  @override
  _AppearAnimationState createState() => _AppearAnimationState();
}

class _AppearAnimationState extends State<AppearWithAnimation> with TickerProviderStateMixin {
  AnimationController _animController;
  Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animOffset = Tween<Offset>(
      begin: widget.offsetBegin,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        curve: widget.curve,
        parent: _animController,
      ),
    );

    Timer(Duration(milliseconds: widget.delay), () {
      _animController.forward();
    });
  }

  @override
  void dispose() {
    _animController.stop();
    _animController.dispose();
    super.dispose();
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
