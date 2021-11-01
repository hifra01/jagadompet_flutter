import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DifferencePieChart extends StatefulWidget {
  final int income;
  final int outcome;
  const DifferencePieChart({Key? key, required this.income, required this.outcome}) : super(key: key);

  @override
  _DifferencePieChartState createState() => _DifferencePieChartState();
}

class _DifferencePieChartState extends State<DifferencePieChart> {

  List<PieChartSectionData> categoryList() {
    double newIncome = widget.income.toDouble();
    double newOutcome = widget.outcome.toDouble();

    if (newIncome == 0 && newOutcome == 0) {
      newIncome = 1;
      newOutcome = 1;
    }

    return [
      PieChartSectionData(
        // Outcome
        color: Colors.red,
        value: newOutcome,
        radius: 10,
        title: '',
      ),
      PieChartSectionData(
        //  Income
        color: Colors.green,
        value: newIncome,
        radius: 10,
        title: '',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 30,
        sections: categoryList(),
      ),
    );
  }
}
