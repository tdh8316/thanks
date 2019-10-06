import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:thanks/generated/i18n.dart';
import 'package:thanks/pages/builder.dart';
import 'package:thanks/styles/colors.dart';
import 'package:thanks/theme.dart';

void main() async => runApp(await MyApp.getInstance());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      localeResolutionCallback: S.delegate.resolution(
        fallback: Locale("en", ""),
      ),
      // TODO: Translation is required
      locale: Locale("ko", "KR"),
      title: "Thanks",
      theme: ThemeData(
        fontFamily: "Nixgon",
        textTheme: TextStyleTheme.textTheme,
        platform: TargetPlatform.iOS,
        primaryColor: DefaultColorTheme.main,
        // primarySwatch: DefaultColorTheme.sub,
      ),
      debugShowCheckedModeBanner: false,
      home: PageBuilder(),
    );
  }

  static Future<MyApp> getInstance() async {
    // Set system overlay style
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    //StaticSharedPreferences.prefs = await SharedPreferences.getInstance();
    return MyApp();
  }
}
