import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thanks/animation/show_up.dart';
import 'package:thanks/core/i18n.dart';
import 'package:thanks/view/color_scheme.dart';
import 'package:thanks/widgets/charts/line_chart_gradient.dart';
import 'package:thanks/widgets/rounded_button.dart';

class Index extends StatefulWidget {
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
              color: Colors.white70,
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
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<Index> with SingleTickerProviderStateMixin {
  double _appbarHeight = .0;
  double _bodyHeight = .0;

  @override
  void initState() {
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
                            colors: theme.primaryGradient,
                          ),
                        ),
                        child: ListView(
                          padding: EdgeInsets.only(top: 32),
                          children: <Widget>[
                            widget.dateWidget(),
                            SizedBox(height: 16),
                            _bodyHeight >
                                    MediaQuery.of(context).size.height / 1.5
                                ? ShowUp(
                                    child: Container(
                                      child: lineChartWithGradient(),
                                    ),
                                    delay: 0,
                                  )
                                : SizedBox(),
                            _bodyHeight >
                                    MediaQuery.of(context).size.height / 1.5
                                ? ShowUp(
                                    child: SimpleRoundIconButton(
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
                                    ),
                                    delay: 0,
                                  )
                                : FadeInAnimation(
                                    child: SimpleRoundIconButton(
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
                                    ),
                                    delay: 0,
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

  SliverAppBar sliverAppBar(
      {bool innerBoxIsScrolled, List<Widget> actions, BuildContext context}) {
    return SliverAppBar(
      elevation: 0,
      forceElevated: innerBoxIsScrolled,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.white),
      expandedHeight: MediaQuery.of(context).size.height / 2 - 32,
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
