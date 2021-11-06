import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:jagadompet_flutter/models/monthly_cashflow.dart';
import 'package:jagadompet_flutter/widgets/indicator.dart';

class OutcomeGraph extends StatefulWidget {
  final MonthlyCashflow cashflow;
  final DateTime date;

  const OutcomeGraph({
    Key? key,
    required this.cashflow,
    required this.date
  }) : super(key: key);

  @override
  State<OutcomeGraph> createState() => _OutcomeGraphState();
}

class _OutcomeGraphState extends State<OutcomeGraph> {
  final Color foodColor = const Color(0xffef476f);

  final Color dailyColor = const Color(0xffffd166);

  final Color educationColor = const Color(0xff06d6a0);

  final Color healthColor = const Color(0xff118ab2);

  final Color otherColor = const Color(0xff073b4c);

  NumberFormat numberFormat = NumberFormat.decimalPattern('id');

  int _touchedIndex = -1;

  List<PieChartSectionData> categoryList() {
    double newOutFood = widget.cashflow.outFood!.toDouble();
    double newOutDaily = widget.cashflow.outDaily!.toDouble();
    double newOutEducation = widget.cashflow.outEducation!.toDouble();
    double newOutHealth = widget.cashflow.outHealth!.toDouble();
    double newOutOther = widget.cashflow.outOther!.toDouble();

    if (newOutFood == 0 &&
        newOutDaily == 0 &&
        newOutEducation == 0 &&
        newOutHealth == 0 &&
        newOutOther == 0) {
      newOutFood =
          newOutDaily = newOutEducation = newOutHealth = newOutOther = 1.0;
    }

    return List.generate(5, (index) {
      final isTouched = index == _touchedIndex;
      final fontSize = isTouched ? 14.0 : 0.0;
      final radius = isTouched ? 120.0 : 100.0;

      switch (index) {
        case 0:
          return PieChartSectionData(
            value: newOutFood,
            title: isTouched
                ? 'Rp${numberFormat.format(widget.cashflow.outFood)}'
                : '',
            color: foodColor,
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          );
        case 1:
          return PieChartSectionData(
            value: newOutDaily,
            title: isTouched
                ? 'Rp${numberFormat.format(widget.cashflow.outDaily)}'
                : '',
            color: dailyColor,
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          );
        case 2:
          return PieChartSectionData(
            value: newOutEducation,
            title: isTouched
                ? 'Rp${numberFormat.format(widget.cashflow.outEducation)}'
                : '',
            color: educationColor,
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          );
        case 3:
          return PieChartSectionData(
            value: newOutHealth,
            title: isTouched
                ? 'Rp${numberFormat.format(widget.cashflow.outHealth)}'
                : '',
            color: healthColor,
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          );
        case 4:
          return PieChartSectionData(
            value: newOutOther,
            title: isTouched
                ? 'Rp${numberFormat.format(widget.cashflow.outOther)}'
                : '',
            color: otherColor,
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          );
        default:
          throw 'Yabe';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID', null);
    final NumberFormat numberFormat = NumberFormat.decimalPattern('id');
    final int total = widget.cashflow.outFood! +
        widget.cashflow.outDaily! +
        widget.cashflow.outEducation! +
        widget.cashflow.outHealth! +
        widget.cashflow.outOther!;
    return Column(
      children: [
        Text(
          DateFormat.yMMMM('id_ID').format(widget.date),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: 200,
            height: 200,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      _touchedIndex = -1;
                      return;
                    }
                    _touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                }),
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
                Text('Rp${numberFormat.format(widget.cashflow.outFood)}'),
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
                Text('Rp${numberFormat.format(widget.cashflow.outDaily)}'),
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
                Text('Rp${numberFormat.format(widget.cashflow.outEducation)}'),
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
                Text('Rp${numberFormat.format(widget.cashflow.outHealth)}'),
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
                Text('Rp${numberFormat.format(widget.cashflow.outOther)}'),
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
    );
  }
}
