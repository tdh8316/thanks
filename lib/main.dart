import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:thanks/screens/splash.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      supportedLocales: [
        const Locale("en", "US"),
        // const Locale("ko", "KR"),
      ],
      // See issue: https://github.com/flutter/flutter/issues/13452
      // locale: Locale("en", "US"),
      title: "All that Thanks",
      theme: ThemeData(
        fontFamily: "LotteMartDream",
      ),

      home: Splash(),
    );
  }
}
