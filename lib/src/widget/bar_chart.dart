import 'package:covid_state_app/src/data/model/covid_status_model.dart';
import 'package:covid_state_app/src/utils/data_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CovidBarChart extends StatelessWidget {
  const CovidBarChart({Key? key, required this.covidDatas, required this.maxY})
      : super(key: key);
  final List<CovidStatusModel> covidDatas;
  final double maxY;

  @override
  Widget build(BuildContext context) {
    int x = 0;
    return AspectRatio(
      aspectRatio: 1.3,
      child: BarChart(
        BarChartData(
            barTouchData: barTouchData,
            titlesData: titlesData,
            borderData: borderData,
            barGroups: covidDatas
                .map<BarChartGroupData>((covidData) => BarChartGroupData(
                      x: x++,
                      barRods: [
                        BarChartRodData(y: covidData.calcDecideCnt, colors: [
                          Colors.lightBlueAccent,
                          Colors.greenAccent
                        ])
                      ],
                      showingTooltipIndicators: [0],
                    ))
                .toList(),
            alignment: BarChartAlignment.spaceAround,
            maxY: maxY * 1.4,
            gridData: FlGridData(show: false)),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.y.round().toString(),
              TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff7589a2),
            fontSize: 14,
          ),
          margin: 20,
          getTitles: (double value) {
            return DataUtils.simpleDayFormat(
                covidDatas[value.toInt()].stateDt!);
          },
        ),
        leftTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );
}
