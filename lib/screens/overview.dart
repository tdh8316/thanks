import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:thanks/animation/show_up.dart';
import 'package:thanks/screens/index.dart';

class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    slides
      ..add(
        new Slide(
          title: "Thanks diary",
          description:
              "By creating a new account or signing in with Facebook,\n"
              "you are agreeing to our Terms of Service and Privacy Policy.",
          styleDescription: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
          centerWidget: FadeInAnimation(
            child: Column(
              children: <Widget>[
                Text(
                  "How people keep a diary.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.white54,
                  ),
                ),
                SizedBox(height: 8),
                Icon(Icons.sentiment_satisfied, color: Colors.white, size: 64),
                SizedBox(height: 64),
                CupertinoButton(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Colors.white,
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(fontFamily: "Krabuler"),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          backgroundColor: Color(0xfffe9c8f),
        ),
      );
  }

  void onDonePress() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Index(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
    );
  }
}

class IntroScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IntroScreenState();
}
