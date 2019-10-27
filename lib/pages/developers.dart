import 'package:flutter/material.dart';
import 'package:thanks/models/scroll_behavior.dart';

class DevelopersPage extends StatefulWidget {
  @override
  _DevelopersPageState createState() => _DevelopersPageState();
}

class _DevelopersPageState extends State<DevelopersPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Scrollbar(
          child: ScrollConfiguration(
            behavior: NoBounceBehavior(),
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 64),
                    Text(
                      "All that Thanks",
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Divider(),
                    ),
                    Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            child: Text(
                              "개발",
                              style: TextStyle(
                                fontSize: 28,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 128),
                            child: Text(
                              "탁동혁",
                              style: TextStyle(
                                fontSize: 28,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            child: Text(
                              "기획",
                              style: TextStyle(
                                fontSize: 28,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 32),
                            child: Text(
                              "2019 강원고등학교 드림하이",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 64),
                            child: Text(
                              "- 조영대, 이승섭, 이건희, 정환",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      child: Divider(),
                    ),
                    Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            child: Stack(
                              children: <Widget>[
                                Text(
                                  "그래픽 아티스트",
                                  style: TextStyle(
                                    fontSize: 32,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 8),
                                      SizedBox(
                                        child: Image.asset(
                                          "res/assets/humans/1.png",
                                        ),
                                        width: 196,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 64),
                            child: Text(
                              "Han Lee",
                              style: TextStyle(
                                fontSize: 28,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      child: Divider(),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          "이 애플리케이션에는 네이버에서 제공한 나눔글꼴이 포함되어 있습니다.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      child: Divider(),
                    ),
                    Column(
                      children: <Widget>[
                        FlutterLogo(
                          style: FlutterLogoStyle.horizontal,
                          size: 128,
                        ),
                        Text("This app takes filght with flutter."),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      child: Divider(),
                    ),
                    Padding(
                      padding:  EdgeInsets.all(16),
                      child: Text(
                        "All that Thanks 는 2019년 강원고등학교 동아리, '드림하이'의 동아리활동 프로젝트로 개발된 애플리케이션입니다.",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
