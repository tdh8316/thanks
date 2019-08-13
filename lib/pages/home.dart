import 'package:flutter/material.dart';
import 'package:thanks/styles/default.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return Stack(
      children: <Widget>[
        Container(
          height: (MediaQuery.of(context).size.height / 5) * 3,
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
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: SafeArea(
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                Spacer(),
                Text(
                  "Thanks",
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Colors.white),
                ),
                Spacer(),
                Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
