import 'package:flutter/material.dart';
import 'package:thanks/components/floating_bar.dart';
import 'package:thanks/models/hex_color.dart';
import 'package:thanks/pages/listview.dart';
import 'package:thanks/pages/statistic.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Widget> pages = [
    ListViewPage(),
    StatisticPage(),
    StatisticPage(),
  ];

  int page = 0;

  // String _userName;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  // TODO: Establish user management system
  Future<Null> initUser() async {
    // String userName = await getUserName();
    setState(() {
      // _userName = userName;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        /*drawer: Drawer(
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
                  "도움말...",
                  style: Theme.of(context).textTheme.subhead,
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
                  // SignUpManager.facebookLogin.logOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => SignUpManager(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),*/
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
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.playlist_add,
                      color: Colors.black87,
                      size: 24,
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text("Not supported yet"),
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.filter_list,
                      color: Colors.black87,
                      size: 24,
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text("Not supported yet"),
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                ],
                elevation: 0,
              ),
            ];
          },
          body: pages[page],
        ),
        // body: ListViewPage(),
        bottomNavigationBar: Container(
          height: 64,
          margin: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300],
                blurRadius: 8,
                spreadRadius: 2,
                offset: Offset(0, -4),
              ),
            ],
            borderRadius: new BorderRadius.all(Radius.circular(12)),
            color: HexColor("#f9f9f9"),
          ),
          child: Row(
            children: <Widget>[
              Spacer(),
              FlatButton(
                shape: StadiumBorder(),
                onPressed: () => changePage(0),
                child: Image.asset(
                  "res/assets/hand-with-pen-100.png",
                  scale: 3.5,
                  color: page == 0 ? Colors.black : Colors.grey,
                ),
              ),
              Spacer(),
              FlatButton(
                shape: StadiumBorder(),
                onPressed: () => changePage(1),
                child: Image.asset(
                  "res/assets/statistics-100.png",
                  scale: 3.5,
                  color: page == 1 ? Colors.black : Colors.grey,
                ),
              ),
              Spacer(),
              FlatButton(
                shape: StadiumBorder(),
                onPressed: () => changePage(2),
                child: Image.asset(
                  "res/assets/edit-profile-100.png",
                  color: page == 2 ? Colors.black : Colors.grey,
                  scale: 3.5,
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      );

  void changePage(int page) => setState(() {
        this.page = page;
      });
}
