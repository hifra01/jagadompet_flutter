import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jagadompet_flutter/models/monthly_cashflow.dart';
import 'package:jagadompet_flutter/widgets/difference_pie_chart.dart';

class InOutDiffCard extends StatefulWidget {
  final DocumentReference userWallet;
  const InOutDiffCard({Key? key, required this.userWallet}) : super(key: key);

  @override
  _InOutDiffCardState createState() => _InOutDiffCardState();
}

class _InOutDiffCardState extends State<InOutDiffCard> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String year = now.year.toString();
    String month = now.month.toString();
    String yearMonthKey = '${year}_$month';

    return FutureBuilder(
      future: widget.userWallet.collection('cashflow').doc(yearMonthKey).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.grey.shade200,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                height: 174,
                child: Center(
                  child: Text('Terjadi kesalahan'),
                ),
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          MonthlyCashflow cashflow = MonthlyCashflow.fromJson(
              snapshot.data!.data() as Map<String, Object?>);
          return Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.grey.shade200,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Statistik bulan ini',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(32),
                        child: SizedBox(
                          height: 80,
                          width: 80,
                          child: DifferencePieChart(
                            income: cashflow.income!,
                            outcome: cashflow.outcome!,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Total pemasukan',
                                style: TextStyle(fontSize: 12),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Rp${cashflow.income}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Total pengeluaran',
                                style: TextStyle(fontSize: 12),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Rp${cashflow.outcome}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Selisih',
                                style: TextStyle(fontSize: 12),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Rp${(cashflow.income! - cashflow.outcome!)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }

        return Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.grey.shade200,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: SizedBox(
              height: 174,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      },
    );
  }
}
