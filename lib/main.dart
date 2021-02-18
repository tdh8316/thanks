import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thanks/generated/i18n.dart';
import 'package:thanks/models/shared.dart';
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
      // TODO: Translation
      locale: Locale("ko", "KR"),
      title: "Thanks",
      theme: ThemeData(
        // 네이버에서 제공한 나눔글꼴이 적용되어 있습니다.
        fontFamily: "나눔바른펜",
        textTheme: TextStyleTheme.textTheme,
        platform: TargetPlatform.iOS,
        primaryColor: DefaultColorTheme.main,
        // primarySwatch: DefaultColorTheme.sub,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }

  static Future<MyApp> getInstance() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Set system overlay style
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    StaticSharedPreferences.prefs = await SharedPreferences.getInstance();

    return MyApp();
  }
}
