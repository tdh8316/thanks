import 'package:flutter/material.dart';
import 'package:thanks/styles/default.dart';

class AppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: SafeArea(
        child: Row(
          children: <Widget>[
            SizedBox(width: 4),
            IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: Icon(Icons.menu, color: DefaultStyle.backgroundedTextColor),
            ),
            Spacer(),
            Text(
              "Thanks",
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(color: DefaultStyle.backgroundedTextColor),
            ),
            Spacer(),
            IconButton(
              onPressed: () => Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Not Implemented'),
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 1),
                ),
              ),
              icon: Icon(Icons.notifications,
                  color: DefaultStyle.backgroundedTextColor),
            ),
            SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}
