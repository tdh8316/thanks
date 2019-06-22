import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thanks/view/color_scheme.dart';

class MaterialCardWidget extends StatelessWidget {
  const MaterialCardWidget(
      {@required this.onPressed,
      @required this.child,
      this.shadowColor = Colors.black,
      this.color = Colors.white70});

  final VoidCallback onPressed;
  final Widget child;
  final Color shadowColor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      elevation: 12,
      borderRadius: BorderRadius.circular(12.0),
      shadowColor: shadowColor,
      child: InkWell(
        onTap: onPressed,
        child: child,
      ),
    );
  }
}

Widget iconContainer(Icon icon) {
  return Container(
    width: 58,
    child: Material(
      borderRadius: BorderRadius.circular(24.0),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: icon,
        ),
      ),
      color: theme.primaryColor,
    ),
  );
}
