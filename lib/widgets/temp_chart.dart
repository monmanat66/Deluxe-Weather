import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/forecast.dart';

class TempChart extends StatelessWidget {
  final List<HourlyWeather> hourly;
  const TempChart({super.key, required this.hourly});

  @override
  Widget build(BuildContext context) {
    final take = hourly.take(24).toList();
    if (take.isEmpty) {
      return const SizedBox(height: 180, child: Center(child: Text('No data')));
    }
    final points = <FlSpot>[];
    final labels = <int, String>{};
    for (var i = 0; i < take.length; i++) {
      final y = (take[i].temperatureC ?? 0).toDouble();
      points.add(FlSpot(i.toDouble(), y));
      if (i % 6 == 0) labels[i] = '${take[i].time.hour.toString().padLeft(2,'0')}h';
    }

    double minY = points.first.y, maxY = points.first.y;
    for (final s in points) {
      if (s.y < minY) minY = s.y;
      if (s.y > maxY) maxY = s.y;
    }
    minY -= 2; maxY += 2;

    return SizedBox(
      height: 220,
      child: LineChart(
        LineChartData(
          minY: minY, maxY: maxY,
          gridData: FlGridData(show: true, drawVerticalLine: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final label = labels[value.toInt()];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(label ?? '', style: const TextStyle(fontSize: 11)),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 34),
            ),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: points, isCurved: true, barWidth: 3,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true, applyCutOffY: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter, end: Alignment.bottomCenter,
                  colors: [Colors.deepPurpleAccent.withOpacity(0.35), Colors.deepPurpleAccent.withOpacity(0.05)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
