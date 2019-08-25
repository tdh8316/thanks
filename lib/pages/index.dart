import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thanks/components/animation/show_up.dart';
import 'package:thanks/pages/calendar.dart';
import 'package:thanks/pages/home.dart';
import 'package:thanks/pages/new.dart';
import 'package:thanks/pages/settings.dart';
import 'package:thanks/styles/default.dart';

class Index extends StatefulWidget {
  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> with SingleTickerProviderStateMixin {
  int _index = 0;
  PageController _pageController;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      floatingActionButton: ShowUp(
        delay: Duration(seconds: 1),
        duration: Duration(milliseconds: 1500),
        curve: Curves.elasticInOut,
        child: Builder(
          builder: (context) => FloatingActionButton(
            heroTag: "new",
            elevation: 12,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NewPost(),
                ),
              );
            },
            child: Icon(Icons.add, size: 32, color: Colors.white),
            backgroundColor: DefaultStyle.primary3,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                  color: DefaultStyle.grey3,
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
                    color: DefaultStyle.grey2,
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Settings()),
                );
              },
            )
          ],
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: <Widget>[
          HomePage(),
          Calendar(),
          Container(
            child: Center(
              child: Text(
                "In development by ☕",
                style: TextStyle(fontSize: 32),
              ),
            ),
          ),
          Container(
            child: Center(
              child: Text(
                "Coming soon",
                style: TextStyle(fontSize: 32),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        elevation: 12,
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 8, left: 16, bottom: 8),
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return RadialGradient(
                    colors: _index == 0
                        ? <Color>[
                            DefaultStyle.primary1,
                            DefaultStyle.primary2,
                          ]
                        : <Color>[
                            DefaultStyle.grey3,
                            DefaultStyle.grey3,
                          ],
                    tileMode: TileMode.mirror,
                  ).createShader(bounds);
                },
                child: IconButton(
                  icon: Icon(
                    Icons.home,
                    size: 28,
                    color: Colors.white,
                  ),
                  onPressed: () => setIndex(0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8, right: 32, bottom: 8),
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return RadialGradient(
                    colors: _index == 1
                        ? <Color>[
                            DefaultStyle.primary1,
                            DefaultStyle.primary2,
                          ]
                        : <Color>[
                            DefaultStyle.grey3,
                            DefaultStyle.grey3,
                          ],
                    tileMode: TileMode.mirror,
                  ).createShader(bounds);
                },
                child: IconButton(
                  icon: Icon(
                    Icons.date_range,
                    size: 28,
                    color: Colors.white,
                  ),
                  onPressed: () => setIndex(1),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8, left: 32, bottom: 8),
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return RadialGradient(
                    colors: _index == 2
                        ? <Color>[
                            DefaultStyle.primary1,
                            DefaultStyle.primary2,
                          ]
                        : <Color>[
                            DefaultStyle.grey3,
                            DefaultStyle.grey3,
                          ],
                    tileMode: TileMode.mirror,
                  ).createShader(bounds);
                },
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                    size: 28,
                    color: Colors.white,
                  ),
                  onPressed: () => setIndex(2),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8, right: 16, bottom: 8),
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return RadialGradient(
                    colors: _index == 3
                        ? <Color>[
                            DefaultStyle.primary1,
                            DefaultStyle.primary2,
                          ]
                        : <Color>[
                            DefaultStyle.grey3,
                            DefaultStyle.grey3,
                          ],
                    tileMode: TileMode.mirror,
                  ).createShader(bounds);
                },
                child: IconButton(
                  icon: Icon(
                    Icons.person,
                    size: 28,
                    color: Colors.white,
                  ),
                  onPressed: () => setIndex(3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  setIndex(int targetIndex) {
    setState(() {
      _index = targetIndex;
    });
    _pageController.jumpToPage(
      targetIndex,
    );
  }
}
