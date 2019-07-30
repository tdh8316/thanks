import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thanks/pages/index.dart';

class Application extends StatelessWidget {
  Application() {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Thanks",
      theme: ThemeData(fontFamily: "Comfortaa"),
      home: SafeArea(
        child: Index(),
      ),
    );
  }
}

void main() => WidgetsFlutterBinding.ensureInitialized()
  ..attachRootWidget(Application())
  ..scheduleWarmUpFrame();
