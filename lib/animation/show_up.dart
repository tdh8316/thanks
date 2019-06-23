import 'dart:async';

import 'package:flutter/widgets.dart';

class ShowUp extends StatefulWidget {
  final Widget child;
  final int delay;
  final Curve curve;

  ShowUp({@required this.child, this.delay, this.curve = Curves.elasticOut});

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
    _animOffset = Tween<Offset>(begin: const Offset(0.0, 1), end: Offset.zero)
        .animate(curve);

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
    return FadeTransition(
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
      opacity: _animController,
    );
  }
}

class FadeInAnimation extends StatefulWidget {
  final Widget child;
  final int delay;
  final Curve curve;

  FadeInAnimation(
      {@required this.child, this.delay=0, this.curve = Curves.decelerate});

  @override
  _FadeInAnimationState createState() => _FadeInAnimationState();
}

class _FadeInAnimationState extends State<FadeInAnimation>
    with TickerProviderStateMixin {
  AnimationController _animController;
  Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _animController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    final curve = CurvedAnimation(curve: widget.curve, parent: _animController);
    _animOffset = Tween<Offset>(begin: const Offset(.0, .25), end: Offset.zero)
        .animate(curve);

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
    return FadeTransition(
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
      opacity: _animController,
    );
  }
}
