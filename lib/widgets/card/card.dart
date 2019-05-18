// https://github.com/TechieBlossom/cards_lib

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Color purpleColor = Color(0xFF2B1AAF);
Color lightGreyColor = Color(0xFFABB6C9);
Color greyColor = Color(0xFF4F4F51);
Color black = Color(0xFF161515);
Color brown = Color(0xFFA6725F);
Color green = Color(0xFF00BB00);

TextStyle boldBlackLargeTextStyle =
    TextStyle(color: black, fontSize: 16.0, fontWeight: FontWeight.w600);

TextStyle normalGreyTextStyle = TextStyle(
  color: greyColor,
  fontSize: 14.0,
);

TextStyle boldPurpleTextStyle =
    TextStyle(color: purpleColor, fontSize: 16.0, fontWeight: FontWeight.w600);

TextStyle normalBlackSmallTextStyle = TextStyle(
  color: black,
  fontSize: 12.0,
);

TextStyle boldGreenLargeTextStyle = TextStyle(
  color: green,
  fontSize: 16.0,
);
NumberFormat format = NumberFormat.simpleCurrency();

class PaidCard extends StatelessWidget {
  final String time, date, name, typeOfService, duration, noOfProducts;
  final double cost;

  PaidCard(
      {this.time,
      this.date,
      this.name,
      this.typeOfService,
      this.duration,
      this.noOfProducts,
      this.cost});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      color: Colors.white,
      borderRadius: BorderRadius.all(
        Radius.circular(4.0),
      ),
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 16.0, bottom: 0.0, left: 16.0, right: 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          time,
                          style: boldBlackLargeTextStyle,
                        ),
                        Text(
                          date,
                          style: normalGreyTextStyle,
                        ),
                      ],
                    ),
                    Spacer(),
                    // Not useful because currently sns share is not implemented
                    /*ClipOval(
                      child: Image.asset(
                        'assets/profile_pic.jpg',
                        fit: BoxFit.cover,
                        height: 45.0,
                        width: 45.0,
                      ),
                    ),*/
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 0.0, left: 16.0, right: 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          name,
                          style: boldBlackLargeTextStyle,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 32,
                          child: Text(
                            typeOfService,
                            style: normalGreyTextStyle,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 5.0,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.0, vertical: 1.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(1.0),
                                ),
                                border: Border.all(color: greyColor),
                              ),
                              child: Text(
                                duration,
                                style: normalGreyTextStyle,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    /*Text(
                      format.format(cost),
                      style: boldPurpleTextStyle,
                    ),*/
                  ],
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  noOfProducts,
                  style: boldPurpleTextStyle,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Divider(
                color: Colors.black,
                height: 0.0,
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Dreamhigh',
                      style: boldGreenLargeTextStyle,
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
