import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:thanks/generated/i18n.dart';
import 'package:thanks/models/coordinate.dart';
import 'package:thanks/models/hex_color.dart';
import 'package:thanks/services/statistic.dart';
import 'package:thanks/styles/colors.dart';

class StatisticPage extends StatefulWidget {
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  DateTime targetDate = DateTime.now();
  Map<String, dynamic> data;
  List<FlSpot> _graphData = [FlSpot(0, 0)];

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
            colors: <Color>[Colors.white70],
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
  Widget build(BuildContext context) => SingleChildScrollView(
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
                          DefaultColorTheme.main,
                          HexColor("#ff9a44"),
                        ],
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "${targetDate.year}. ${targetDate.month}",
                                style: TextStyle(
                                  fontSize: 32,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white70,
                                ),
                                onPressed: () {},
                              ),
                              SizedBox(width: 16),
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white70,
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
                                  color: Colors.white,
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
                                fontSize: 18,
                                color: Colors.white54,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 128,
                          child: FlChart(
                            chart: LineChart(
                              graphData(),
                            ),
                          ),
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
                      child: FractionallySizedBox(
                        child: Card(
                          elevation: 32,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Spacer(),
                                  Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(height: 28),
                                        Text(
                                          S.of(context).feelingGreat,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        SizedBox(height: 28),
                                        Text(
                                          S.of(context).feelingNotGood,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        SizedBox(height: 28),
                                        Text(
                                          S.of(context).feelingSad,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        SizedBox(height: 28),
                                        Text(
                                          S.of(context).feelingAngry,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        SizedBox(height: 28),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
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
