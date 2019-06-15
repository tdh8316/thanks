import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:thanks/screens/splash.dart';

void main() => runApp(App());

class _ScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: _ScrollBehavior(),
          child: child,
        );
      },
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
      /*
      Fix #2 by fixing following package: https://github.com/memspace/zefyr
       - Pull request: https://github.com/memspace/zefyr/pull/106
       - Fork: https://github.com/tdh8316/zefyr/tree/fix-cupertino-i18n
     */
      title: "All that Thanks",
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: "나눔바른펜",
      ),

      // Display the splash screen
      home: Splash(),
    );
  }
}
