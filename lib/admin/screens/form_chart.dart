import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ApplicationLineChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        minY: 0,
        minX: 0,
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: AxisTitles(axisNameSize: 0),
          rightTitles: AxisTitles(axisNameSize: 0),
          leftTitles: AxisTitles(
              sideTitles:
                  SideTitles(showTitles: true, interval: 2, reservedSize: 30)),
          bottomTitles: AxisTitles(
              sideTitles:
                  SideTitles(showTitles: true, interval: 1, reservedSize: 30)),
        ),
        lineBarsData: [
          LineChartBarData(
            color: Colors.red,
            spots: [
              const FlSpot(1, 7),
              const FlSpot(2, 9),
              const FlSpot(3, 13),
              const FlSpot(4, 8),
              const FlSpot(5, 16),
              const FlSpot(6, 8),
              const FlSpot(7, 9),
            ],
            isCurved: false,
            barWidth: 4,
            dotData: FlDotData(show: false),
          ),
          LineChartBarData(
            spots: [
              const FlSpot(1, 5),
              const FlSpot(2, 6),
              const FlSpot(3, 10),
              const FlSpot(4, 9),
              const FlSpot(5, 5),
              const FlSpot(6, 3),
              const FlSpot(7, 6),
            ],
            isCurved: false,
            barWidth: 4,
            dotData: FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}
