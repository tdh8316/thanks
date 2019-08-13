import 'package:flutter/material.dart';
import 'package:thanks/components/animation/show_up.dart';
import 'package:thanks/styles/default.dart';

import 'home.dart';

class Index extends StatefulWidget {
  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> with SingleTickerProviderStateMixin {
  int _index = 0;
  PageController _pageController;
  final List<Widget> _children = <Widget>[
    HomePage(),
    Container(child: Center(child: Text("1", style: TextStyle(fontSize: 69)))),
    Container(child: Center(child: Text("2", style: TextStyle(fontSize: 69)))),
    Container(child: Center(child: Text("3", style: TextStyle(fontSize: 69)))),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  setIndex(int targetIndex) {
    setState(() {
      _index = targetIndex;
    });
    _pageController.jumpToPage(targetIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ShowUp(
        delay: Duration(seconds: 1),
        child: Builder(
          builder: (context) => FloatingActionButton(
            elevation: 12,
            onPressed: () {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Not Implemented'),
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 1),
                ),
              );
            },
            child: Icon(Icons.add, size: 32),
            backgroundColor: DefaultStyle.primary3,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body:PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: _children,
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
                    Icons.calendar_today,
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
                    Icons.dashboard,
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
}
