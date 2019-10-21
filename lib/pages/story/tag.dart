import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const textStyle = TextStyle(
  fontFamily: "나눔바른펜",
  fontSize: 28,
);

class StoryTagPage extends StatefulWidget {
  State<StoryTagPage> createState() => _StoryTagPageState();
}

class _StoryTagPageState extends State<StoryTagPage> {
  @override
  Widget build(BuildContext context) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
              // child: Text("뭐가", style: textStyle),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                crossAxisCount: 3,
                children: <Widget>[
                  Icon(Icons.crop_square),
                  Icon(Icons.crop_square),
                  Icon(Icons.crop_square),
                  Icon(Icons.crop_square),
                  Icon(Icons.crop_square),
                  Icon(Icons.crop_square),
                  Icon(Icons.crop_square),
                  Icon(Icons.crop_square),
                  Icon(Icons.crop_square),
                ],
              ),
            )
          ],
        ),
      );
}
