import 'package:flutter/material.dart';
import 'package:nima/nima_actor.dart';

class StoryTagPage extends StatefulWidget {

  State<StoryTagPage> createState() => _StoryTagPageState();
}

class _StoryTagPageState extends State<StoryTagPage> {
  @override
  Widget build(BuildContext context) => Container(
    child: FractionallySizedBox(
      widthFactor: .75,
      child: NimaActor(
        "res/assets/Dinosaurs/Dinosaurs.nma",
        animation: "Idle",
        fit: BoxFit.contain,
      ),
    ),
  );
}
