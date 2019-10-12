import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thanks/components/calendar.dart';
import 'package:thanks/components/hotel.dart';

class CalendarPopupView extends StatefulWidget {
  final DateTime minimumDate;
  final DateTime maximumDate;
  final bool barrierDismissible;
  final Function(DateTime) onApplyClick;
  final Function onCancelClick;

  const CalendarPopupView(
      {Key key,
      this.onApplyClick,
      this.onCancelClick,
      this.barrierDismissible = true,
      this.minimumDate,
      this.maximumDate})
      : super(key: key);

  @override
  _CalendarPopupViewState createState() => _CalendarPopupViewState();
}

class _CalendarPopupViewState extends State<CalendarPopupView>
    with TickerProviderStateMixin {
  AnimationController animationController;
  DateTime date;

  @override
  void initState() {
    animationController = AnimationController(
      duration: Duration(milliseconds: 750),
      vsync: this,
    );
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return AnimatedOpacity(
          duration: Duration(milliseconds: 750),
          opacity: animationController.value,
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: () {
              if (widget.barrierDismissible) Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.only(
                top: 128,
                left: 32,
                right: 32,
              ),
              /*
              decoration: BoxDecoration(
                  color: HotelAppTheme.buildLightTheme().backgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(24.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.25),
                      offset: Offset(4, 4),
                      blurRadius: 8.0,
                    ),
                  ],
                ),
               */
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CustomCalendarView(
                      minimumDate: widget.minimumDate,
                      maximumDate: widget.maximumDate,
                      onDateChange: (DateTime date) {
                        setState(() {
                          this.date = date;
                        });
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 16,
                        top: 32,
                      ),
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: HotelAppTheme.buildLightTheme().primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(24.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              blurRadius: 8,
                              offset: Offset(4, 4),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius:
                                BorderRadius.all(Radius.circular(24.0)),
                            highlightColor: Colors.transparent,
                            onTap: () {
                              try {
                                // animationController.reverse().then((f) {

                                // });
                                widget.onApplyClick(date);
                                // Navigator.pop(context);
                              } catch (e) {}
                            },
                            child: Center(
                              child: Text(
                                "선택",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
