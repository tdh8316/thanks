import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:thanks/loader.dart';

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
        const Locale("ko", "KR"),
      ],
      title: "All that Thanks",
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "나눔바른펜"),
      home: Splash(),
    );
  }
}
