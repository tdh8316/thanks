import 'package:flutter/material.dart';
import 'package:thanks/bloc/home.dart';
import 'package:thanks/components/animation/show_up.dart';
import 'package:thanks/components/card_pages/card.dart';
import 'package:thanks/components/card_pages/card_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _bloc = HomeBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 24, top: 52),
          child: Text(
            "Good evening,",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 24, top: 84),
          child: Text(
            "Donghyeok Tak",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              letterSpacing: -.75,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(48)),
            child: Material(
              color: Colors.black87,
              child: InkWell(
                child: Container(
                  height: 120,
                  width: 110,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(top: 35, right: 25),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 38,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(top: 25, right: 50),
                          child: Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Not Implemented'),
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(milliseconds: 1500),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 196),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: PageTransformer(
              pageViewBuilder: (BuildContext context, visibilityResolver) {
                return PageView.builder(
                  pageSnapping: true,
                  physics: BouncingScrollPhysics(),
                  controller:
                      PageController(viewportFraction: .5, initialPage: 0),
                  itemCount: 3,
                  itemBuilder: (BuildContext context, index) {
                    return ShowUp(
                      curve: Curves.fastLinearToSlowEaseIn,
                      begin: Offset(-.5, -.5),
                      animatedOpacity: true,
                      child: SizedBox(
                        height: 32,
                        width: 32,
                        child: _buildCard(index, visibilityResolver),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
        /*Align(
          alignment: Alignment.bottomRight,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(48),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height / 12 + 12,
              width: MediaQuery.of(context).size.width/1.25,
              color: HexColor("#0E0E0E"),
            ),
          ),
        ),*/
      ],
    );
  }

  Widget _buildCard(index, visibilityResolver) {
    return CardWithChild(
      child: Center(
        child: Text(
          "I love you",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      pageVisibility: visibilityResolver.resolvePageVisibility(index),
      backgroundColor: <Color>[
        Color.fromARGB(255, 143, 85, 157),
        Color(4293617717),
        Color.fromARGB(255, 52, 99, 38),
      ][index],
    );
  }
}
