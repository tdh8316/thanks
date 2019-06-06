import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget lineChartWithGradient() {
  List<Color> gradientColors = [
    Color(0xff23b6e6),
    Color(0xff02d39a),
  ];
  return AspectRatio(
    aspectRatio: 1.70,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        color: Colors.transparent,
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
        child: FlChart(
          chart: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawHorizontalGrid: true,
                horizontalGridColor: Colors.transparent,
                verticalGridColor: Colors.transparent,
                verticalGridLineWidth: 1,
                horizontalGridLineWidth: 1,
              ),
              titlesData: FlTitlesData(
                show: true,
                horizontalTitlesTextStyle: TextStyle(
                  color: Color(0xff68737d),
                  fontWeight: FontWeight.bold,
                  fontFamily: "나눔바른펜",
                  fontSize: 18,
                ),
                getHorizontalTitles: (value) {
                  switch (value.toInt()) {
                    case 1:
                      return "Mon";
                    case 3:
                      return "Tue";
                    case 5:
                      return "Wed";
                    case 7:
                      return "Thu";
                    case 9:
                      return "Fri";
                  }

                  return "";
                },
                getVerticalTitles: (value) {},
                verticalTitlesTextStyle: TextStyle(
                  color: Color(0xff67727d),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                verticalTitlesReservedWidth: 28,
                verticalTitleMargin: 12,
                horizontalTitleMargin: 8,
              ),
              borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    color: Colors.transparent,
                    width: 1,
                  )),
              minX: 0,
              maxX: 11,
              minY: 0,
              maxY: 6,
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(0, 2),
                    FlSpot(1, 1),
                    FlSpot(3, 2),
                    FlSpot(5, 3),
                    FlSpot(7, 5),
                    FlSpot(9, 2),
                  ],
                  isCurved: true,
                  colors: gradientColors,
                  barWidth: 5,
                  isStrokeCapRound: true,
                  dotData: FlDotData(
                    show: false,
                  ),
                  belowBarData: BelowBarData(
                    show: true,
                    colors: gradientColors
                        .map((color) => color.withOpacity(0.3))
                        .toList(),
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
