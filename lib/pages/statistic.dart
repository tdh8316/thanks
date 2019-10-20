import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:thanks/components/animation/show_up.dart';
import 'package:thanks/models/coordinate.dart';
import 'package:thanks/services/statistic.dart';
import 'package:thanks/styles/colors.dart';

class StatisticPage extends StatefulWidget {
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  DateTime targetDate = DateTime.now();
  Map<String, dynamic> data;
  List<FlSpot> _graphData = [FlSpot(0, 0)];
  StreamController<PieTouchResponse> pieTouchedResultStreamController;
  int touchedIndex;

  graphData() => LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(enabled: false),
        maxY: 4,
        minY: 0,
        maxX: 31,
        lineBarsData: <LineChartBarData>[
          LineChartBarData(
            spots: _graphData,
            isCurved: true,
            colors: <Color>[DefaultColorTheme.sub],
            barWidth: 5,
            isStrokeCapRound: true,
            dotData: const FlDotData(
              show: false,
            ),
            belowBarData: BarAreaData(show: false),
          ),
        ],
      );

  @override
  void initState() {
    aaa();
    pieTouchedResultStreamController = StreamController();
    pieTouchedResultStreamController.stream.distinct().listen((details) {
      if (details == null) {
        return;
      }

      setState(() {
        if (details.touchInput is FlLongPressEnd) {
          touchedIndex = -1;
        } else {
          touchedIndex = details.touchedSectionPosition;
        }
      });
    });
    super.initState();
  }

  aaa() async {
    final _data = await getStatisticData(targetDate: targetDate);
    final _gd = getCoordinateFromFeeling(targetDate);
    setState(() {
      this.data = _data;
      this._graphData = _gd;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (data == null || _graphData == null || _graphData.length == 0)
      return Container(
        child: Column(
          children: <Widget>[],
        ),
      );
    return _buildStatisticWidget(context);
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: DefaultColorTheme.main.withOpacity(.95),
            value: 40,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 1:
          return PieChartSectionData(
            color: DefaultColorTheme.main.withOpacity(.75),
            value: 30,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 2:
          return PieChartSectionData(
            color: DefaultColorTheme.main.withOpacity(.5),
            value: 15,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 3:
          return PieChartSectionData(
            color: DefaultColorTheme.main.withOpacity(.25),
            value: 15,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        default:
          return null;
      }
    });
  }

  Widget _buildStatisticWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(64),
                  topRight: Radius.circular(64),
                  bottomLeft: Radius.elliptical(256, 64),
                  bottomRight: Radius.elliptical(256, 64),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        //HexColor("#fc6076"),
                        //DefaultColorTheme.main,
                        //HexColor("#ff9a44"),
                        Colors.white,
                        Colors.white,
                      ],
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "${targetDate.year}. ${targetDate.month}",
                              style: TextStyle(
                                fontSize: 32,
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black54,
                              ),
                              onPressed: () {},
                            ),
                            SizedBox(width: 16),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black54,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 32, right: 8),
                            child: Text(
                              "${data != null ? data["total"] : "0"}",
                              style: TextStyle(
                                fontSize: 64,
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 32),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "이번 달의 기록",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                                fontFamily: "나눔바른펜",),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      ShowUp(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 128,
                          child: FlChart(
                            chart: LineChart(
                              graphData(),
                            ),
                          ),
                        ),
                        animatedOpacity: true,
                        begin: Offset.zero,
                      ),
                      SizedBox(height: 64),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 300),
                child: Center(
                  child: FractionallySizedBox(
                    widthFactor: 0.875,
                    child: ShowUp(
                      child: _buildFeelingChart(context),
                      animatedOpacity: true,
                      curve: Curves.linearToEaseOut,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeelingChart(BuildContext context) => Card(
        elevation: 32,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Spacer(),
                SizedBox(
                  width: 150,
                  child: FlChart(
                    chart: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchResponseStreamSink:
                              pieTouchedResultStreamController.sink,
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 14,
                        sections: showingSections(),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 28),
                      Row(
                        children: <Widget>[
                          Container(
                            height: 8,
                            width: 8,
                            color: DefaultColorTheme.main.withOpacity(.95),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "좋아",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "나눔바른펜",
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 28),
                      Row(
                        children: <Widget>[
                          Container(
                            height: 8,
                            width: 8,
                            color: DefaultColorTheme.main.withOpacity(.75),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "그저 그래",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "나눔바른펜",
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 28),
                      Row(
                        children: <Widget>[
                          Container(
                            height: 8,
                            width: 8,
                            color: DefaultColorTheme.main.withOpacity(.5),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "슬퍼",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "나눔바른펜",
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 28),
                      Row(
                        children: <Widget>[
                          Container(
                            height: 8,
                            width: 8,
                            color: DefaultColorTheme.main.withOpacity(.25),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "화나",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "나눔바른펜",
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 28),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          ],
        ),
      );
}
