import 'package:flutter/material.dart';
import 'package:thanks/utils/fake.dart';
import 'package:thanks/widgets/page_transformer.dart';

class HomeComponent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 32),
          child: Text(
            "Hello\n Donghyeok",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
          ),
        ),
        SizedBox.fromSize(
          size: Size.fromHeight(MediaQuery.of(context).size.height/1.5),
          child: PageTransformer(
            pageViewBuilder: (BuildContext context, visibilityResolver) {
              return PageView.builder(
                controller: PageController(viewportFraction: .85),
                itemCount: sampleCardItems.length,
                itemBuilder: (BuildContext context, index) {
                  return CardPageItem(
                    item: sampleCardItems[index],
                    pageVisibility:
                    visibilityResolver.resolvePageVisibility(index),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
