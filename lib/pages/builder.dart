import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:thanks/components/floating_bar.dart';
import 'package:thanks/generated/i18n.dart';
import 'package:thanks/pages/home.dart';
import 'package:thanks/services/account.dart';

class PageBuilder extends StatefulWidget {
  @override
  State<PageBuilder> createState() => _PageBuilderState();
}

class _PageBuilderState extends State<PageBuilder> {
  bool isLoggedIn = false;
  final FacebookLogin facebookLogin = FacebookLogin()
    ..loginBehavior = FacebookLoginBehavior.webViewOnly;

  void onLoginStatusChanged(bool isLoggedIn) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
    });
  }

  void initiateFacebookLogin() async {
    var facebookLoginResult = await facebookLogin.logInWithReadPermissions(
      [
        'email',
      ],
    );
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        var graphResponse = await http.get('https://graph.facebook.com'
            '/v2.12/me?fields='
            'name,first_name,last_name,email,'
            'picture.height(200)'
            '&access_token=${facebookLoginResult.accessToken.token}');
        AccountInstance.profileData = json.decode(graphResponse.body);
        onLoginStatusChanged(true);
        break;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoggedIn)
      return Scaffold(
        body: SafeArea(
          child: FlatButton(
            child: Text("LOGIN"),
            onPressed: () {
              initiateFacebookLogin();
            },
          ),
        ),
      );
    return _buildScreen();
  }

  Widget _buildScreen() => Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 16),
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: NetworkImage(
                        AccountInstance.profileData['picture']['data']['url'],
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  S.of(context).whatDoICallYou,
                  style: Theme.of(context).textTheme.subhead,
                ),
                subtitle: Text(
                  AccountInstance.profileData['name'],
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
                  child: Container(),
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
                  // TODO: Define AppBar actions
                  IconButton(
                    icon: Icon(Icons.search, color: Colors.black87, size: 24),
                    onPressed: () {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Not Implemented"),
                          behavior: SnackBarBehavior.floating,
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
