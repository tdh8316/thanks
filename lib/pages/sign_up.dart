import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:thanks/components/animation/show_up.dart';
import 'package:thanks/generated/i18n.dart';
import 'package:thanks/models/shared.dart';
import 'package:thanks/pages/builder.dart';
import 'package:thanks/styles/colors.dart';

class SignUpManager extends StatelessWidget {
  static final FacebookLogin facebookLogin = FacebookLogin()
    ..loginBehavior = FacebookLoginBehavior.webViewOnly;

  static Future<Null> loginToFacebook(BuildContext context) async {
    final FacebookLoginResult result =
        await facebookLogin.logInWithReadPermissions(["public_profile"]);

    switch (result.status) {
      case FacebookLoginStatus.error:
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("An unknown error is occurred."),
            action: SnackBarAction(
              label: "Detail",
              onPressed: () {
                // TODO: ERROR TRACE
              },
            ),
          ),
        );
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.loggedIn:
        // TODO: Firebase auth
        /*FirebaseAuth.instance.signInWithCredential(
          FacebookAuthProvider.getCredential(
            accessToken: result.accessToken.token,
          ),
        );*/
        /*StaticSharedPreferences.prefs.setString(
          "userName",
          json.decode(
            (await http.get(
              "https://graph.facebook.com/v2.12/me?"
              "fields=name&access_token=${result.accessToken.token}",
            ))
                .body,
          )["name"],
        );*/
        StaticSharedPreferences.prefs.setString(
          "facebookToken",
          result.accessToken.token,
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => PageBuilder(),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(8),
          child: AnimationLimiter(
            child: Column(
              children: AnimationConfiguration.toStaggeredList(
                duration: Duration(milliseconds: 500),
                childAnimationBuilder: (widget) => SlideAnimation(
                  horizontalOffset: MediaQuery.of(context).size.width / 2,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height / 8),
                  Center(
                    child: Text(
                      "All that Thanks - ${S.of(context).introShort}",
                      style: Theme.of(context).textTheme.headline,
                    ),
                  ),
                  SizedBox(height: 64),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * (3 / 4),
                    child: Image.asset("res/assets/humans/4.png"),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Text(
                      S.of(context).welcome,
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  SizedBox(height: 32),
                  ShowUp(
                    animatedOpacity: true,
                    delay: Duration(milliseconds: 500),
                    begin: Offset.zero,
                    child: FlatButton(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 60,
                          right: 60,
                          top: 20,
                          bottom: 20,
                        ),
                        child: Text(
                          S.of(context).withFacebook,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      // onPressed: () => loginToFacebook(context),
                      onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) => PageBuilder(),
                        ),
                      ),
                      shape: StadiumBorder(),
                      color: DefaultColorTheme.main,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
