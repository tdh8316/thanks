import 'package:flutter/material.dart';
import 'package:thanks/components/floating_bar.dart';
import 'package:thanks/generated/i18n.dart';
import 'package:thanks/pages/listview.dart';
import 'package:thanks/pages/sign_up.dart';
import 'package:thanks/styles/user.dart';

class PageBuilder extends StatefulWidget {
  @override
  State<PageBuilder> createState() => _PageBuilderState();
}

class _PageBuilderState extends State<PageBuilder> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _userName;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  // TODO: Establish user management system
  Future<Null> initUser() async {
    String userName = await getUserName();
    setState(() {
      _userName = userName;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: <Widget>[
              /*DrawerHeader(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 16),
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: null,
                    ),
                  ],
                ),
              ),*/
              DrawerHeader(
                child: Container(),
              ),
              ListTile(
                title: Text(
                  S.of(context).whatDoICallYou,
                  style: Theme.of(context).textTheme.subhead,
                ),
                subtitle: Row(
                  children: <Widget>[
                    SizedBox(width: 8),
                    InkWell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          _userName ?? "",
                        ),
                      ),
                      onTap: () {
                        /*Navigator.of(context).pop();
                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text("NOT SUPPORTED YET"),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );*/
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 1,
                  child: Container(
                    color: Colors.grey,
                  ),
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
                    color: Colors.grey,
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
              ),
              ListTile(
                title: Text("Logout"),
                onTap: () {
                  // StaticSharedPreferences.prefs.remove("userName");
                  SignUpManager.facebookLogin.logOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => SignUpManager(),
                    ),
                  );
                },
              ),
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
                  // TODO: Assign AppBar actions
                  IconButton(
                    icon: Icon(Icons.search, color: Colors.black87, size: 24),
                    onPressed: () {
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text("Not supported yet"),
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                  )
                ],
              ),
            ];
          },
          body: HomePage(),
        ),
      );
}
