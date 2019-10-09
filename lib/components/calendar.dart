import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thanks/components/hotel.dart';
import 'package:thanks/styles/colors.dart';

class CustomCalendarView extends StatefulWidget {
  final DateTime minimumDate;
  final DateTime maximumDate;
  final DateTime initialStartDate;
  final DateTime initialEndDate;
  final Function(DateTime) onDateChange;

  const CustomCalendarView(
      {Key key,
      this.initialStartDate,
      this.initialEndDate,
      this.onDateChange,
      this.minimumDate,
      this.maximumDate})
      : super(key: key);

  @override
  _CustomCalendarViewState createState() => _CustomCalendarViewState();
}

class _CustomCalendarViewState extends State<CustomCalendarView> {
  List<DateTime> dateList = List<DateTime>();
  var currentMonthDate = DateTime.now();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    setListOfDate(currentMonthDate);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setListOfDate(DateTime monthDate) {
    dateList.clear();
    var newDate = DateTime(monthDate.year, monthDate.month, 0);
    int previousMonthDay = 0;
    if (newDate.weekday < 7) {
      previousMonthDay = newDate.weekday;
      for (var i = 1; i <= previousMonthDay; i++) {
        dateList.add(newDate.subtract(Duration(days: previousMonthDay - i)));
      }
    }
    for (var i = 0; i < (42 - previousMonthDay); i++) {
      dateList.add(newDate.add(Duration(days: i + 1)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 4, bottom: 4),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    height: 38,
                    width: 38,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                      border: Border.all(
                        color: HotelAppTheme.buildLightTheme().dividerColor,
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(24.0)),
                        onTap: () {
                          setState(() {
                            currentMonthDate = DateTime(
                              currentMonthDate.year,
                              currentMonthDate.month,
                              0,
                            );
                            setListOfDate(currentMonthDate);
                          });
                        },
                        child: Icon(
                          Icons.keyboard_arrow_left,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      DateFormat("MMMM, yyyy").format(currentMonthDate),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    height: 38,
                    width: 38,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                      border: Border.all(
                        color: HotelAppTheme.buildLightTheme().dividerColor,
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(24.0)),
                        onTap: () {
                          setState(() {
                            currentMonthDate = DateTime(
                              currentMonthDate.year,
                              currentMonthDate.month + 2,
                              0,
                            );
                            setListOfDate(currentMonthDate);
                          });
                        },
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8, left: 8, bottom: 8),
            child: Row(
              children: getDaysNameUI(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8, left: 8),
            child: Column(
              children: getDaysNoUI(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getDaysNameUI() {
    List<Widget> listUI = List<Widget>();
    for (var i = 0; i < 7; i++) {
      listUI.add(
        Expanded(
          child: Center(
            child: Text(
              DateFormat("EEE").format(dateList[i]),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: HotelAppTheme.buildLightTheme().primaryColor,
              ),
            ),
          ),
        ),
      );
    }
    return listUI;
  }

  List<Widget> getDaysNoUI() {
    final List<Widget> noList = List<Widget>();
    int count = 0;
    for (var i = 0; i < dateList.length / 7; i++) {
      final List<Widget> listUI = List<Widget>();
      for (var i = 0; i < 7; i++) {
        final date = dateList[count];
        listUI.add(
          Expanded(
            child: AspectRatio(
              aspectRatio: 1.1,
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          height: 32,
                          width: 32,
                          color: this.selectedDate.day == date.day &&
                                  this.selectedDate.month == date.month &&
                                  this.selectedDate.year == date.year
                              ? DefaultColorTheme.sub
                              : Colors.transparent,
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        onTap: () {
                          onDateClick(date);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(2),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                              border: Border.all(
                                color: Colors.transparent,
                                width: 2,
                              ),
                              boxShadow: null,
                            ),
                            child: Center(
                              child: Text(
                                "${date.day}",
                                style: TextStyle(
                                  color: currentMonthDate.month == date.month
                                      ? Colors.black
                                      : Colors.grey.withOpacity(0.6),
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 0,
                      left: 0,
                      child: Container(
                        height: 4,
                        width: 4,
                        decoration: BoxDecoration(
                          color: DateTime.now().day == date.day &&
                                  DateTime.now().month == date.month
                              ? HotelAppTheme.buildLightTheme().primaryColor
                              : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        count += 1;
      }
      noList.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: listUI,
        ),
      );
    }
    return noList;
  }

  void onDateClick(DateTime selectedDate) {
    /*if (startDate == null) {
      startDate = date;
    } else if (startDate != date && endDate == null) {
      endDate = date;
    } else if (startDate.day == date.day && startDate.month == date.month) {
      startDate = null;
    } else if (endDate.day == date.day && endDate.month == date.month) {
      endDate = null;
    }
    if (startDate == null && endDate != null) {
      startDate = endDate;
      endDate = null;
    }
    if (startDate != null && endDate != null) {
      if (!endDate.isAfter(startDate)) {
        var d = startDate;
        startDate = endDate;
        endDate = d;
      }
      if (date.isBefore(startDate)) {
        startDate = date;
      }
      if (date.isAfter(endDate)) {
        endDate = date;
      }
    }*/

    setState(() {
      try {
        // widget.startEndDateChange(startDate, endDate);
        widget.onDateChange(selectedDate);
        this.selectedDate = selectedDate;
      } catch (e) {}
    });
  }
}
