import 'dart:math';

import 'package:flutter/material.dart';
import 'package:thanks/styles/default.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> with TickerProviderStateMixin {
  PageController pageController;
  int currentPage = 0;
  double page = 0.0;
  double viewPortFraction = .4;

  @override
  void initState() {
    pageController = PageController(viewportFraction: viewPortFraction);

    super.initState();
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
                      return _buildColorsWidgets()[index](max(.7, (1 - (index - page).abs()) + viewPortFraction)*60);
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
              child: Container(
                height: size,
                width: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white),
                  gradient: LinearGradient(
                    colors: defaultColors(),
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  selectedTheme = ColorSchemes.default_;
                });
              },
            ),
        (double size) => FlatButton(
              child: Container(
                height: size,
                width: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white),
                  gradient: LinearGradient(
                    colors: nightFadeColors(),
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  selectedTheme = ColorSchemes.nightFade;
                });
              },
            ),
        (double size) => FlatButton(
              child: Container(
                height: size,
                width: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white),
                  gradient: LinearGradient(
                    colors: deepBlueColors(),
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  selectedTheme = ColorSchemes.deepBlue;
                });
              },
            ),
        (double size) => FlatButton(
              child: Container(
                height: size,
                width: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white),
                  gradient: LinearGradient(
                    colors: grapeColors(),
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  selectedTheme = ColorSchemes.grape;
                });
              },
            ),
      ];
}
