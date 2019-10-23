import 'package:flutter/material.dart';
import 'package:thanks/models/hex_color.dart';

class FinishStoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        color: HexColor("#f9f9f9"),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "호랑이를 왜 만들었냐고 하나님께 투정하지 말고 호랑이에 날개를 달아주지 않은 것에 감사하라.",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
          ),
        ),
      );
}
