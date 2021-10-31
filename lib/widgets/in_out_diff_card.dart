import 'package:flutter/material.dart';
import 'package:jagadompet_flutter/widgets/difference_pie_chart.dart';

class InOutDiffCard extends StatefulWidget {
  const InOutDiffCard({Key? key}) : super(key: key);

  @override
  _InOutDiffCardState createState() => _InOutDiffCardState();
}

class _InOutDiffCardState extends State<InOutDiffCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Statistik bulan ini'),
            SizedBox(height: 16,),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(32),
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: DifferencePieChart(),
                  ),
                ),
                Column(
                  children: [
                    Text('Total pemasukan'),
                    Text('Total pemasukan'),
                    Text('Total pemasukan'),
                    Text('Total pemasukan'),
                    Text('Total pemasukan'),
                    Text('Total pemasukan'),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
