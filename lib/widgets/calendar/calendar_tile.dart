import 'package:date_utils/date_utils.dart';
import 'package:flutter/material.dart';

class CalendarTile extends StatelessWidget {
  final VoidCallback onDateSelected;
  final DateTime date;
  final String dayOfWeek;
  final bool isDayOfWeek;
  final bool isSelected;
  final TextStyle dayOfWeekStyles;
  final TextStyle dateStyles;
  final Widget child;

  CalendarTile({
    this.onDateSelected,
    this.date,
    this.child,
    this.dateStyles,
    this.dayOfWeek,
    this.dayOfWeekStyles,
    this.isDayOfWeek: false,
    this.isSelected: false,
  });

  Widget renderDateOrDayOfWeek(BuildContext context) {
    if (isDayOfWeek) {
      return InkWell(
        child: Container(
          alignment: Alignment.center,
          child: Text(
            dayOfWeek,
            style: dayOfWeekStyles,
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: onDateSelected,
        child: Container(
          decoration: isSelected
              ? BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                )
              : BoxDecoration(),
          alignment: Alignment.center,
          child: Text(
            Utils.formatDay(date).toString(),
            style: isSelected ? TextStyle(color: Colors.white) : dateStyles,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (child != null) {
      return InkWell(
        child: child,
        onTap: onDateSelected,
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: renderDateOrDayOfWeek(context),
    );
  }
}
