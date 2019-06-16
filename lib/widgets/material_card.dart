import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MaterialCardWidget extends StatelessWidget {
  const MaterialCardWidget({
    @required this.onPressed,
    this.titleText,
    this.valueText,
    this.icon,
    this.shadowColor = const Color(0x802196F3),
    this.iconBackgroundColor = Colors.red,
  });

  final VoidCallback onPressed;
  final Text titleText;
  final Text valueText;
  final Icon icon;
  final Color shadowColor;
  final Color iconBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 14.0,
      borderRadius: BorderRadius.circular(12.0),
      shadowColor: shadowColor,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  titleText,
                  valueText,
                ],
              ),
              Material(
                color: iconBackgroundColor,
                borderRadius: BorderRadius.circular(24.0),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: icon,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
