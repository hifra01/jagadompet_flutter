import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jagadompet_flutter/models/monthly_cashflow.dart';
import 'package:jagadompet_flutter/widgets/outcome_graph.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class GraphSection extends StatefulWidget {
  final User? currentUser;
  const GraphSection({Key? key, this.currentUser}) : super(key: key);

  @override
  _GraphSectionState createState() => _GraphSectionState();
}

class _GraphSectionState extends State<GraphSection> {
  late DocumentReference userWallet;
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    userWallet = FirebaseFirestore.instance
        .collection('wallet')
        .doc(widget.currentUser!.uid);
  }

  Future<void> _chooseMonth(BuildContext context) async {
    final DateTime? picked = await showMonthPicker(
      context: context,
      initialDate: now,
      firstDate: DateTime.now().subtract(const Duration(days: 90)),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != now) {
      setState(() {
        now = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String year = now.year.toString();
    String month = now.month.toString();
    String yearMonthKey = '${year}_$month';

    return Column(
      children: [
        Container(
          color: Colors.blue,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Grafik Pengeluaran',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              OutlinedButton(
                onPressed: () async {
                  await _chooseMonth(context);
                },
                child: const Text('PILIH BULAN'),
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: userWallet.collection('cashflow').doc(yearMonthKey).get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Text('Terjadi kesalahan'),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  MonthlyCashflow cashflow = snapshot.data!.exists
                      ? MonthlyCashflow.fromJson(
                          snapshot.data!.data() as Map<String, Object?>)
                      : MonthlyCashflow.allZero();
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: OutcomeGraph(cashflow: cashflow, date: now,),
                  );
                }

                return const Center(
                      child: CircularProgressIndicator(),
                    );
              },
            ),
          ),
        ),
      ],
    );
  }
}
