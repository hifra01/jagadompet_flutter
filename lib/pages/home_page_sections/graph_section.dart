import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jagadompet_flutter/models/monthly_cashflow.dart';
import 'package:jagadompet_flutter/widgets/outcome_graph.dart';

class GraphSection extends StatefulWidget {
  final User? currentUser;
  const GraphSection({Key? key, this.currentUser}) : super(key: key);

  @override
  _GraphSectionState createState() => _GraphSectionState();
}

class _GraphSectionState extends State<GraphSection> {
  late DocumentReference userWallet;

  @override
  void initState() {
    super.initState();
    userWallet = FirebaseFirestore.instance
        .collection('wallet')
        .doc(widget.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String year = now.year.toString();
    String month = now.month.toString();
    String yearMonthKey = '${year}_$month';

    return Column(
      children: [
        Container(
          color: Colors.blue,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: const Text(
            'Grafik Pengeluaran',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: FutureBuilder(
              future: userWallet.collection('cashflow').doc(yearMonthKey).get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Terjadi kesalahan'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  MonthlyCashflow cashflow = MonthlyCashflow.fromJson(snapshot.data!.data() as Map<String, Object?>);
                  return OutcomeGraph(cashflow: cashflow);
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
