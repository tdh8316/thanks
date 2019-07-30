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
  void initState() {
    super.initState();
  }

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
          padding: EdgeInsets.only(left: 24, top: 32),
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
          padding: EdgeInsets.only(left: 24, top: 64),
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
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(64)),
            child: Material(
              color: Colors.black87,
              child: InkWell(
                child: Container(
                  height: 110,
                  width: 110,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(top: 25, right: 25),
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
            height: MediaQuery.of(context).size.height / 3,
            child: PageTransformer(
              pageViewBuilder: (BuildContext context, visibilityResolver) {
                return PageView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  controller: PageController(viewportFraction: .75),
                  itemCount: 3,
                  itemBuilder: (BuildContext context, index) {
                    return ShowUp(
                      curve: Curves.fastLinearToSlowEaseIn,
                      begin: Offset(.5, .5),
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
          ["Today", "Yesterday", "First journal!"][index],
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      pageVisibility: visibilityResolver.resolvePageVisibility(index),
    );
  }
}
