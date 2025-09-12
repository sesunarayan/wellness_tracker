import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class ProgressScreen extends StatelessWidget {
  static const routeName = '/progress';
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppProvider>();

    // TODO: Replace with real stored weekly data.
    // Mock weekly values generated from current state.
    final waterData = List.generate(
      7,
          (i) => (state.waterGlasses - i).clamp(0, 10).toDouble(),
    ).reversed.toList();

    final sleepData = List.generate(
      7,
          (i) => (state.sleepHours - i * 0.3).clamp(0.0, 12.0),
    ).reversed.toList();

    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Scaffold(
      appBar: AppBar(title: const Text("Progress")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
//for water intake
            Text(
              "Weekly Water Intake (glasses)",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  gridData: FlGridData(drawVerticalLine: false, drawHorizontalLine: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false, reservedSize: 15),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() < 0 || value.toInt() >= days.length) {
                            return const SizedBox.shrink();
                          }
                          return Text(days[value.toInt()]);
                        },
                      ),
                    ),
                  ),
                  barGroups: List.generate(
                    waterData.length,
                        (i) => BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: waterData[i],
                          color: Color(0xfff5a63f),
                          width: 13,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),

// for sleep pattern
            Text(
              "Weekly Sleep Pattern (hours)",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  gridData: FlGridData(drawVerticalLine: false, drawHorizontalLine: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false, reservedSize: 15),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() < 0 || value.toInt() >= days.length) {
                            return const SizedBox.shrink();
                          }
                          return Text(days[value.toInt()]);
                        },
                      ),
                    ),
                  ),
                  barGroups: List.generate(
                    sleepData.length,
                        (i) => BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: sleepData[i],
                          color:  Color(0xff6a2798),
                          width: 14,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
