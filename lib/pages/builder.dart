import 'package:flutter/material.dart';
import 'package:thanks/components/floating_bar.dart';
import 'package:thanks/pages/home.dart';

class PageBuilder extends StatefulWidget {
  @override
  State<PageBuilder> createState() => _PageBuilderState();
}

class _PageBuilderState extends State<PageBuilder> {
  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: <Widget>[
                Text("Unknown User"),
                Spacer(),
                CircleAvatar(
                  radius: 32,
                  backgroundImage: NetworkImage(
                    "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              "What do I call you?",
              style: Theme.of(context).textTheme.subhead,
            ),
            subtitle: Text(
              "Your nickname",
            ),
          ),
          ListTile(
            title: Text(
              "Coming soon...",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            title: Text("Unlock premium features"),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              height: 1,
              child: Container(
              ),
            ),
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                Text("Settings"),
                Spacer(),
                Icon(
                  Icons.settings,
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    ),
        body: NestedScrollView(
          headerSliverBuilder: (context, isInnerBoxScroll) {
            return <Widget>[
              RoundedFloatingAppBar(
                floating: true,
                snap: true,
                actions: <Widget>[
                  Icon(Icons.search, color: Colors.black87,size: 24)
                ],
              ),
            ];
          },
          body: HomePage(),
        ),
      );
}
