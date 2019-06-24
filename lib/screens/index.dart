import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thanks/animation/show_up.dart';
import 'package:thanks/core/i18n.dart';
import 'package:thanks/view/color_scheme.dart';
import 'package:thanks/widgets/material_card.dart';

class Index extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<Index> with SingleTickerProviderStateMixin {
  double _appbarHeight = .0;
  double _bodyHeight = .0;

  double bodyOpacity = 1;

  var colors = theme.primaryGradient;

  static ScrollController _controller;

  double _lastScrollPosition = 0;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.offset <= 144 && _lastScrollPosition < _controller.offset) {
        _controller.position.animateTo(
          _controller.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.decelerate,
        );
      } else if (_controller.offset > 144 && _lastScrollPosition > _controller.offset) {
        _controller.position.animateTo(
          _controller.position.minScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.decelerate,
        );
      }
      _lastScrollPosition = _controller.offset;
      setState(() {
        bodyOpacity =
            1 - (_controller.offset / _controller.position.maxScrollExtent);
      });
      colors = [];
      for (var color in theme.primaryGradient) {
        colors.add(color.withOpacity(bodyOpacity));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: NestedScrollView(
          controller: _controller,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: SliverSafeArea(
                  sliver: sliverAppBar(
                    innerBoxIsScrolled: innerBoxIsScrolled,
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Color.fromARGB(255, 36, 39, 52),
                        ),
                        onPressed: () {},
                      ),
                    ],
                    context: context,
                  ),
                ),
              ),
            ];
          },
          body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              _bodyHeight = constraints.biggest.height;
              return ConstrainedBox(
                constraints: BoxConstraints(),
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(69),
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(bottom: 32, left: 8, right: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: colors,
                          ),
                        ),
                        child: ListView(
                          padding: EdgeInsets.only(top: 32),
                          children: <Widget>[
                            dateWidget(),
                            SizedBox(height: 16),
                            /*_bodyHeight >
                                    MediaQuery.of(context).size.height / 1.75
                                ? ShowUp(
                                    child: Container(
                                      child: lineChartWithGradient(),
                                    ),
                                    delay: 0,
                                  )
                                : SizedBox(),*/
                            _bodyHeight >
                                    MediaQuery.of(context).size.height / 1.5
                                ? ShowUp(
                                    child: storyForToday(),
                                    delay: 0,
                                    curve: Curves.decelerate,
                                    animatedOpacity: false,
                                  )
                                : FadeInAnimation(
                                    child: storyForToday(),
                                    delay: 0,
                                    curve: Curves.bounceOut,
                                    animatedOpacity: false,
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget dateWidget() {
    DateTime date = DateTime.now();
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 4, left: 32),
          child: Text(
            "${DateFormat("d").format(date)} ${DateFormat("MMM").format(date)}",
            style: TextStyle(
              fontSize: 32,
              color: bodyOpacity > .825
                  ? Colors.white70
                  : Colors.black87.withOpacity(1 - bodyOpacity),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 32, left: 64),
          child: Text(
            "${tr(DateFormat("EEEE").format(date))}",
            style: TextStyle(
              fontSize: 46,
              color: bodyOpacity > .825
                  ? Colors.white
                  : Colors.black.withOpacity(1 - bodyOpacity),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget storyForToday() {
    /*return SimpleRoundIconButton(
      onPressed: () {},
      icon: Icon(Icons.edit),
      buttonText: Text(
        "Add today's story".toUpperCase(),
        style: TextStyle(
          fontSize: 18,
          color: Colors.white70,
          fontFamily: "Krabuler",
        ),
      ),
      backgroundColor: theme.primaryColor,
      iconAlignment: Alignment.centerRight,
    );*/
    return MaterialCardWidget(
      child: Container(
        height: MediaQuery.of(context).size.height / 4 + 32,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              width: 68,
              child: Material(
                elevation: 4,
                shadowColor: theme.secondaryGradient[0],
                color: theme.primaryGradient.last.withOpacity(.75),
                borderRadius: BorderRadius.circular(28),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(Icons.edit, color: Colors.white54, size: 34),
                  ),
                ),
              ),
            ),
            Text(
              "Add today's story".toUpperCase(),
              style: TextStyle(
                fontSize: 26,
                fontFamily: "Krabuler",
                color: theme.primaryGradient[0],
              ),
            ),
          ],
        ),
      ),
      onPressed: () {},
    );
  }

  SliverAppBar sliverAppBar(
      {bool innerBoxIsScrolled, List<Widget> actions, BuildContext context}) {
    return SliverAppBar(
      elevation: 0,
      forceElevated: innerBoxIsScrolled,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.white),
      expandedHeight: MediaQuery.of(context).size.height / 3,
      floating: true,
      pinned: true,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          _appbarHeight = constraints.biggest.height;
          return (_appbarHeight <= 144)
              ? Opacity(
                  opacity: 1 - _appbarHeight / 144,
                  child: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    centerTitle: true,
                    title: Text(
                      "Thanks",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontFamily: "Krabuler",
                      ),
                    ),
                  ),
                )
              : Opacity(
                  opacity: _appbarHeight < 196 ? 1 - 144 / _appbarHeight : 1,
                  child: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    centerTitle: true,
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: _appbarHeight / 2 - 16),
                        Text(
                          "Good evening,",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 16, top: 8, right: 32),
                          child: Text(
                            "Donghyeok Tak",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w900,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
      actions: actions,
    );
  }
}
