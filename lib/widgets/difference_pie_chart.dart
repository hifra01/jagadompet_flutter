import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DifferencePieChart extends StatefulWidget {
  const DifferencePieChart({Key? key}) : super(key: key);

  @override
  _DifferencePieChartState createState() => _DifferencePieChartState();
}

class _DifferencePieChartState extends State<DifferencePieChart> {
  @override

  List<PieChartSectionData> categoryList() {
    return [
      PieChartSectionData(
        // Outcome
        color: Colors.red,
        value: 123456,
        radius: 10,
        title: '',
      ),
      PieChartSectionData(
        //  Income
        color: Colors.green,
        value: 500000,
        radius: 10,
        title: '',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sectionsSpace: 1,
        centerSpaceRadius: 30,
        sections: categoryList(),
      ),
    );
  }
}
