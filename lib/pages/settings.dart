import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thanks/styles/default.dart';

class Settings extends StatefulWidget {
  Settings() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> with TickerProviderStateMixin {
  PageController pageController;
  int currentPage = 0;
  double page = 0.0;
  double viewPortFraction = .4;
  SharedPreferences prefs;

  @override
  void initState() {
    (() async {
      prefs = await SharedPreferences.getInstance();
    })();

    pageController = PageController(viewportFraction: viewPortFraction);

    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Spacer(),
          Padding(
            padding: EdgeInsets.all(32),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      DefaultStyle.primary1,
                      DefaultStyle.primary2,
                    ],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                ),
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification notification) {
                    setState(() {
                      page = pageController.page;
                    });
                    return true;
                  },
                  child: PageView.builder(
                    controller: pageController,
                    onPageChanged: (pos) {
                      setState(() {
                        currentPage = pos;
                      });
                    },
                    itemCount: 4,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      // print(max(.7, (1 - (index - page).abs()) + viewPortFraction)*60);
                      return _buildColorsWidgets()[index](
                        max(
                              0.7,
                              (1 - (index - page).abs()) + viewPortFraction,
                            ) *
                            pow(2, 6),
                      );
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Function> _buildColorsWidgets() => <Function>[
        (double size) => FlatButton(
              shape: CircleBorder(),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Container(
                height: size,
                width: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  gradient: LinearGradient(
                    colors: defaultColors(),
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                ),
              ),
              onPressed: () async {
                setState(() {
                  selectedTheme = ColorSchemes.default_;
                });
                prefs.setString("theme", ColorSchemes.default_.toString());
              },
            ),
        (double size) => FlatButton(
              shape: CircleBorder(),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Container(
                height: size,
                width: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  gradient: LinearGradient(
                    colors: nightFadeColors(),
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                ),
              ),
              onPressed: () async {
                setState(() {
                  selectedTheme = ColorSchemes.nightFade;
                });
                prefs.setString("theme", ColorSchemes.nightFade.toString());
              },
            ),
        (double size) => FlatButton(
              shape: CircleBorder(),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Container(
                height: size,
                width: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  gradient: LinearGradient(
                    colors: deepBlueColors(),
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                ),
              ),
              onPressed: () async {
                setState(() {
                  selectedTheme = ColorSchemes.deepBlue;
                });
                prefs.setString("theme", ColorSchemes.deepBlue.toString());
              },
            ),
        (double size) => FlatButton(
              shape: CircleBorder(),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Container(
                height: size,
                width: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  gradient: LinearGradient(
                    colors: grapeColors(),
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                ),
              ),
              onPressed: () async {
                setState(() {
                  selectedTheme = ColorSchemes.grape;
                });
                prefs.setString("theme", ColorSchemes.grape.toString());
              },
            ),
      ];
}
