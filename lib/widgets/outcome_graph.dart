import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jagadompet_flutter/models/monthly_cashflow.dart';
import 'package:jagadompet_flutter/widgets/indicator.dart';

class OutcomeGraph extends StatelessWidget {
  final MonthlyCashflow cashflow;
  final Color foodColor = const Color(0xffef476f);
  final Color dailyColor = const Color(0xffffd166);
  final Color educationColor = const Color(0xff06d6a0);
  final Color healthColor = const Color(0xff118ab2);
  final Color otherColor = const Color(0xff073b4c);
  final double sectionRadius = 100;
  const OutcomeGraph({
    Key? key,
    required this.cashflow,
  }) : super(key: key);

  List<PieChartSectionData> categoryList() {
    double newOutFood = cashflow.outFood!.toDouble();
    double newOutDaily = cashflow.outDaily!.toDouble();
    double newOutEducation = cashflow.outEducation!.toDouble();
    double newOutHealth = cashflow.outHealth!.toDouble();
    double newOutOther = cashflow.outOther!.toDouble();

    if (newOutFood == 0 &&
        newOutDaily == 0 &&
        newOutEducation == 0 &&
        newOutHealth == 0 &&
        newOutOther == 0) {
      newOutFood =
          newOutDaily = newOutEducation = newOutHealth = newOutOther = 1.0;
    }

    return [
      PieChartSectionData(
        value: newOutFood,
        title: '',
        color: foodColor,
        radius: sectionRadius,
      ),
      PieChartSectionData(
        value: newOutDaily,
        title: '',
        color: dailyColor,
        radius: sectionRadius,
      ),
      PieChartSectionData(
        value: newOutEducation,
        title: '',
        color: educationColor,
        radius: sectionRadius,
      ),
      PieChartSectionData(
        value: newOutHealth,
        title: '',
        color: healthColor,
        radius: sectionRadius,
      ),
      PieChartSectionData(
        value: newOutOther,
        title: '',
        color: otherColor,
        radius: sectionRadius,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat numberFormat = NumberFormat.decimalPattern('id');
    final int total = cashflow.outFood! +
        cashflow.outDaily! +
        cashflow.outEducation! +
        cashflow.outHealth! +
        cashflow.outOther!;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: 200,
              height: 200,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 0,
                  sections: categoryList(),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 48,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Kategori',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Indicator(
                    color: foodColor,
                    text: 'Makanan & minuman',
                  ),
                  Text('Rp${numberFormat.format(cashflow.outFood)}'),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Indicator(
                    color: dailyColor,
                    text: 'Kebutuhan sehari-hari',
                  ),
                  Text('Rp${numberFormat.format(cashflow.outDaily)}'),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Indicator(
                    color: educationColor,
                    text: 'Pendidikan',
                  ),
                  Text('Rp${numberFormat.format(cashflow.outEducation)}'),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Indicator(
                    color: healthColor,
                    text: 'Kesehatan',
                  ),
                  Text('Rp${numberFormat.format(cashflow.outHealth)}'),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Indicator(
                    color: otherColor,
                    text: 'Lain-lain',
                  ),
                  Text('Rp${numberFormat.format(cashflow.outOther)}'),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Rp${numberFormat.format(total)}',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
