import 'package:flutter/material.dart';
import 'package:thanks/models/hex_color.dart';

class FinishStoryPage extends StatefulWidget {
  final Function save;

  FinishStoryPage({
    @required this.save,
  });

  @override
  _FinishStoryPageState createState() => _FinishStoryPageState();
}

class _FinishStoryPageState extends State<FinishStoryPage> {
  @override
  Widget build(BuildContext context) => Container(
        color: HexColor("#f9f9f9"),
        child: FlatButton(
          child: Text("SAVE"),
          onPressed: () => widget.save(),
        ),
      );
}
