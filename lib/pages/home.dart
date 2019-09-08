import 'package:flutter/material.dart';
import 'package:thanks/components/question.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => Container(
        child: SafeArea(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int position) {
              return Padding(
                padding: EdgeInsets.all(32),
                child: () {
                  switch (position) {
                    case 0:
                      return Question();
                    default:
                      return Text(position.toString());
                  }
                }(),
              );
            },
          ),
        ),
      );
}
