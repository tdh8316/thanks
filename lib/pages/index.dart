import 'package:flutter/material.dart';
import 'package:thanks/pages/home.dart';
import 'package:thanks/styles/default.dart';

class Index extends StatefulWidget {
  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> with SingleTickerProviderStateMixin {
  int _index = 0;
  final List<Widget> _children = <Widget>[
    HomePage(),
    Container(child: Text("1")),
    Container(child: Text("2")),
    Container(child: Text("3")),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 12,
        onPressed: () {
          print("tabbed fab");
        },
        child: Icon(Icons.add, size: 32),
        backgroundColor: DefaultStyle.primary3,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _children[_index],
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
              child: _index != 0
                  ? IconButton(
                      icon: Icon(
                        Icons.home,
                        size: 28,
                      ),
                      onPressed: () {
                        setState(() {
                          _index = 0;
                        });
                      },
                    )
                  : ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return RadialGradient(
                          colors: <Color>[
                            DefaultStyle.primary1,
                            DefaultStyle.primary2,
                          ],
                          tileMode: TileMode.mirror,
                        ).createShader(bounds);
                      },
                      child: IconButton(icon: Icon(
                        Icons.home,
                        size: 28,
                        color: Colors.white,
                      ), onPressed: null),
                    ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8, right: 32, bottom: 8),
              child: IconButton(
                icon: Icon(
                  Icons.calendar_today,
                  size: 28,
                  color:
                      _index != 1 ? DefaultStyle.grey3 : DefaultStyle.primary1,
                ),
                onPressed: () {
                  setState(() {
                    _index = 1;
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8, left: 32, bottom: 8),
              child: IconButton(
                icon: Icon(
                  Icons.dashboard,
                  size: 28,
                  color:
                      _index != 2 ? DefaultStyle.grey3 : DefaultStyle.primary1,
                ),
                onPressed: () {
                  setState(() {
                    _index = 2;
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8, right: 16, bottom: 8),
              child: IconButton(
                icon: Icon(
                  Icons.person,
                  size: 28,
                  color:
                      _index != 3 ? DefaultStyle.grey3 : DefaultStyle.primary1,
                ),
                onPressed: () {
                  setState(() {
                    _index = 3;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
