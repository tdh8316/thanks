import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:thanks/components/animation/show_up.dart';
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
  List<FlSpot> _graphCoordinates;

  int touchedIndex;

  int numOfFiles(data) => int.tryParse("${data != null ? data["total"] : "0"}");

  List<TooltipItem> customTilesStyle<T extends TouchedSpot>(
      List<T> touchedSpots) {
    if (touchedSpots == null) {
      return null;
    }

    return touchedSpots.map((T touchedSpot) {
      if (touchedSpots == null || touchedSpot.spot == null) {
        return null;
      }

      final String text = () {
            if (touchedSpot.spot.y == null)
              return '';
            else if (touchedSpot.spot.y == YAxisFromFeeling.great)
              return "좋아! \uD83D\uDE0A";
            else if (touchedSpot.spot.y == YAxisFromFeeling.notGood)
              return "그저 그래 \uD83D\uDE10";
            else if (touchedSpot.spot.y == YAxisFromFeeling.sad)
              return "너무 슬프다 \uD83D\uDE25";
            else if (touchedSpot.spot.y == YAxisFromFeeling.angry)
              return "정말 화난다 \uD83D\uDE21";
            else
              return '\uD83E\uDD14';
          }() +
          "\n${targetDate.month}. ${touchedSpot.spot.x.toInt()}";

      final TextStyle textStyle = TextStyle(
        fontFamily: "나눔바른펜",
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      );
      return TooltipItem(text, textStyle);
    }).toList();
  }

  LineChartData get graphData => LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: TouchTooltipData(
            getTooltipItems: customTilesStyle,
            tooltipBgColor: DefaultColorTheme.sub,
            tooltipBottomMargin: 32,
          ),
        ),
        maxY: 2,
        minY: -1,
        maxX: 31,
        lineBarsData: <LineChartBarData>[
          LineChartBarData(
            spots: _graphCoordinates.length > 0
                ? [FlSpot(0, YAxisFromFeeling.center), ..._graphCoordinates]
                : [FlSpot(0, 0)],
            isCurved: true,
            curveSmoothness: 0.014,
            colors: <Color>[
              HexColor("#ff9a44"),
              HexColor("#fc6076"),
              HexColor("#ff9a44"),
            ],
            barWidth: 5,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              checkToShowDot: (FlSpot spot) =>
                  spot.x == _graphCoordinates.last.x,
              dotColor: DefaultColorTheme.main,
              dotSize: 6,
            ),
            belowBarData: BarAreaData(show: false),
          ),
        ],
        clipToBorder: false,
      );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<Null> loadStatisticData() async {
    data = await getStatisticData(targetDate: targetDate);
    _graphCoordinates = await getCoordinateFromFeeling(targetDate);
    return null;
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<Null>(
        future: loadStatisticData(),
        builder: (BuildContext context, AsyncSnapshot<Null> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if ((data == null ||
                      _graphCoordinates == null ||
                      _graphCoordinates.length == 0) &&
                  (targetDate.year == DateTime.now().year &&
                      targetDate.month == DateTime.now().month)) {
                return Column(
                  children: <Widget>[
                    SizedBox(height: 32),
                    ShowUp(
                      animatedOpacity: true,
                      curve: Curves.easeOutCirc,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: SizedBox(
                          height: 256,
                          child: Image.asset("res/assets/humans/3.png"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 64,
                      ),
                      child: ShowUp(
                        delay: Duration(milliseconds: 100),
                        animatedOpacity: true,
                        curve: Curves.easeOutSine,
                        child: Text(
                          "아직 당신을 알아 가는 단계예요.\n"
                          "일기를 작성하시면 이 공간을 준비할게요!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "나눔바른펜",
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return SafeArea(child: _buildStatisticWidget(context));
            default:
              if (snapshot.hasError)
                return Container(
                  child: SafeArea(
                    child: Center(
                      child: Text(
                        "Exception: ${snapshot.error}",
                        style: TextStyle(fontFamily: "Roboto"),
                      ),
                    ),
                  ),
                );
              return Container();
          }
        },
      );

  Widget _buildStatisticWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
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
                        Colors.transparent,
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "${targetDate.year}. ${targetDate.month}월",
                              style: TextStyle(
                                fontSize: 32,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.025,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black54,
                              ),
                              onPressed: () {
                                setState(() {
                                  targetDate = DateTime(
                                    targetDate.year,
                                    targetDate.month - 1,
                                  );
                                });
                              },
                            ),
                            SizedBox(width: 16),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black54,
                              ),
                              onPressed: () {
                                DateTime temp = DateTime(
                                  targetDate.year,
                                  targetDate.month + 1,
                                );
                                if (temp.isBefore(DateTime.now()))
                                  setState(() {
                                    targetDate = temp;
                                  });
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 64, right: 8),
                        child: Text(
                          numOfFiles(data).toString(),
                          style: TextStyle(
                            fontSize: 64,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 4,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 48),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "이번 달의 기록",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontFamily: "나눔바른펜",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 32),
                      Row(
                        children: <Widget>[
                          Spacer(),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    HexColor("#ff9a44"),
                                    HexColor("#fc6076"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "월간 기분 변화 추이",
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 4,
                        child: ShowUp(
                          child: numOfFiles(data) > 0
                              ? FlChart(
                                  chart: LineChart(
                                    graphData,
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    "이 기간에 작성된 일기가 없어요.",
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: DefaultColorTheme.main,
                                    ),
                                  ),
                                ),
                          animatedOpacity: true,
                          begin: Offset.zero,
                        ),
                      ),
                      // SizedBox(height: 64),
                      Divider(),
                    ],
                  ),
                ),
              ),
              /*Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 2,
                ),
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
              ),*/
            ],
          ),
        ],
      ),
    );
  }

  // ignore: unused_element
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
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 14,
                        // sections: showingSections(),
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
