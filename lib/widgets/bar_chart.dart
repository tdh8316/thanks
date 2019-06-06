import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartSample1 {

  final Color barColor = Colors.pink[100];
  final Color barBackgroundColor = Color(0xff72d8bf);
  final double width = 22;

  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.25,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: Colors.pink[200],
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                "Lorem ipsum",
                style: TextStyle(
                    color: Colors.purple[400], fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "Lorem ipsum dolor sit amet",
                style: TextStyle(
                    color: Colors.white70, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 32,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: FlChart(
                    chart: BarChart(BarChartData(
                      titlesData: FlTitlesData(
                          show: true,
                          showHorizontalTitles: true,
                          showVerticalTitles: false,
                          horizontalTitlesTextStyle: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14, fontFamily: "나눔바른펜"),
                          horizontalTitleMargin: 32,
                          getHorizontalTitles: (double value) {
                            switch (value.toInt()) {
                              case 0:
                                return 'Mon';
                              case 1:
                                return 'Tue';
                              case 2:
                                return 'Wed';
                              case 3:
                                return 'Thu';
                              case 4:
                                return 'Fri';
                              case 5:
                                return 'Sat';
                              case 6:
                                return 'Sun';
                            }
                          }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      barGroups: [
                        makeGroupData(0, 10),
                        makeGroupData(1, 11),
                        makeGroupData(2, 20),
                        makeGroupData(3, 30),
                        makeGroupData(4, 14),
                        makeGroupData(5, 30),
                        makeGroupData(6, 17),
                      ],
                    )),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(
        y: y,
        color: barColor,
        width: width,
        isRound: true,
        backDrawRodData: BackgroundBarChartRodData(
          show: true,
          y: 8,
          color: barBackgroundColor,
        ),
      ),
    ]);
  }

}