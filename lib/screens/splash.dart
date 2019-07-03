import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:thanks/services/fetch_services.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => fetch(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Center(
              child: Text(
                "All that thanks",
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 8)),
          Center(
            child: Text(
              "Made with 💕 by 2019 DreamHigh",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
