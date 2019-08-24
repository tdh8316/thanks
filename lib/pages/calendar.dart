import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, WeekdayFormat;
import 'package:thanks/components/share/bar.dart';
import 'package:thanks/models/fakes.dart';
import 'package:thanks/models/structs.dart';
import 'package:thanks/styles/default.dart';

class Calendar extends StatefulWidget {
  EventList<Event> _getCarouselMarkedDates() {
    return EventList<Event>(
      events: {
        new DateTime(2019, 4, 3): [
          new Event(
            date: new DateTime(2019, 4, 3),
            title: 'Event 1',
          ),
        ],
        new DateTime(2019, 4, 5): [
          new Event(
            date: new DateTime(2019, 4, 5),
            title: 'Event 1',
          ),
        ],
        new DateTime(2019, 4, 22): [
          new Event(
            date: new DateTime(2019, 4, 22),
            title: 'Event 1',
          ),
        ],
        new DateTime(2019, 4, 24): [
          new Event(
            date: new DateTime(2019, 4, 24),
            title: 'Event 1',
          ),
        ],
        new DateTime(2019, 4, 26): [
          new Event(
            date: new DateTime(2019, 4, 26),
            title: 'Event 1',
          ),
        ],
      },
    );
  }

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _dateTime = DateTime.now();

  var recentPosts = fakeRecentPosts;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: (MediaQuery.of(context).size.height / 5) * 3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  DefaultStyle.primary1,
                  DefaultStyle.primary2,
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
            child: Column(
              children: <Widget>[
                AppBarWidget(),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height / 1.275,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 1.1,
            child: Padding(
              padding: EdgeInsets.only(top: 64, left: 12, right: 12),
              child: CalendarCarousel<Event>(
                onDayPressed: (DateTime date, List<Event> events) {
                  setState(() {
                    _dateTime = date;
                  });
                },
                iconColor: DefaultStyle.grey1,
                headerTextStyle: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(color: DefaultStyle.grey1),
                todayBorderColor: Colors.transparent,
                todayButtonColor: Colors.transparent,
                todayTextStyle: TextStyle(color: Colors.black),
                thisMonthDayBorderColor: Colors.transparent,
                selectedDayButtonColor: DefaultStyle.primary3,
                selectedDayBorderColor: DefaultStyle.primary3,
                selectedDayTextStyle: TextStyle(color: Colors.white),
                weekendTextStyle: TextStyle(color: Colors.black),
                daysTextStyle: TextStyle(color: Colors.black),
                nextDaysTextStyle: TextStyle(color: Colors.grey),
                prevDaysTextStyle: TextStyle(color: Colors.grey),
                weekdayTextStyle: TextStyle(color: Colors.grey),
                weekDayFormat: WeekdayFormat.short,
                firstDayOfWeek: null,
                showHeader: true,
                isScrollable: false,
                weekFormat: false,
                height: 600,
                selectedDateTime: _dateTime,
                daysHaveCircularBorder: true,
                customGridViewPhysics: NeverScrollableScrollPhysics(),
                // markedDatesMap: _getCarouselMarkedDates(),
                markedDateWidget: Container(
                  height: 3,
                  width: 9,
                  decoration: new BoxDecoration(
                    color: Color(0xFF30A9B2),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.lerp(
            Alignment.center,
            Alignment.bottomCenter,
            0.425,
          ),
          child: Divider(
            indent: 32,
            endIndent: 32,
            color: DefaultStyle.grey3,
          ),
        ),
        Align(
          alignment: Alignment.lerp(
            Alignment.center,
            Alignment.bottomCenter,
            1,
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: _buildStoryWidget(context, _dateTime),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStoryWidget(BuildContext context, DateTime targetDate) {
    // TODO: New data structure
    var _targetPost = fakeStories[targetDate.toString().split(' ')[0]];
    if (_targetPost == null) return Container();
    return (targetDate.day.toString() ==
                _targetPost[DiaryStructure.date][DateConstants.day]
                    .toString() &&
            targetDate.month.toString() ==
                _targetPost[DiaryStructure.date][DateConstants.month]
                    .toString() &&
            targetDate.year.toString() ==
                _targetPost[DiaryStructure.date][DateConstants.year].toString())
        ? Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Card(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            _targetPost[DiaryStructure.date][DateConstants.day],
                            style: Theme.of(context)
                                .textTheme
                                .display1
                                .copyWith(
                                  color: DefaultStyle.primary3.withOpacity(.75),
                                ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          _targetPost[DiaryStructure.date]
                              [DateConstants.dayName],
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: DefaultStyle.grey1.withOpacity(.75),
                              ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12, bottom: 8, right: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "This is an example of the story.\n"
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                          style: Theme.of(context).textTheme.body1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Container();
  }
}
