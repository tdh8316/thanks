import 'package:flutter/material.dart';
import 'package:thanks/bloc/home.dart';
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
          padding: EdgeInsets.only(left: 16, top: 52),
          child: Text(
            "Good evening,",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 18, top: 84),
          child: Text(
            "Donghyeok Tak",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(48)),
            child: Material(
              color: Colors.black,
              child: InkWell(
                onTap: () {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Not Implemented'),
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(milliseconds: 1500),
                    ),
                  );
                },
                child: Container(height: 120, width: 110),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(top: 35, right: 25),
            child: Icon(Icons.edit, color: Colors.white, size: 42),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(top: 25, right: 50),
            child: Icon(Icons.add, color: Colors.white),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 1.75,
            width: MediaQuery.of(context).size.width,
            child: PageTransformer(
              pageViewBuilder: (BuildContext context, visibilityResolver) {
                return PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: PageController(viewportFraction: .75),
                  itemCount: sampleCardItems.length,
                  itemBuilder: (BuildContext context, index) {
                    CardItem element = CardItem(
                      item: sampleCardItems[index],
                      pageVisibility:
                          visibilityResolver.resolvePageVisibility(index),
                    );
                    return element;
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  final List<CardItemData> sampleCardItems = <CardItemData>[
    CardItemData(
        title: "First diary !", description: "This is my first diary :D"),
    CardItemData(title: "Awesome app !", description: "Wow"),
    CardItemData(title: "Your title", description: "The brain named itself!"),
  ];
}
