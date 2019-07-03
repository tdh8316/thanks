import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Skeleton extends StatelessWidget {
  final Widget child;

  const Skeleton({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: child,
      ),
    );
  }
}
