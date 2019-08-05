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
          child: SizedBox(
            height: 100,
            width: 100,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: new OutlineButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Not Implemented'),
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(milliseconds: 1500),
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
                borderSide: BorderSide(
                    color: Colors.black, style: BorderStyle.solid, width: 1),
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
