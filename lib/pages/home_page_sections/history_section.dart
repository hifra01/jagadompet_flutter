import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jagadompet_flutter/models/transaction_item.dart';
import 'package:jagadompet_flutter/widgets/transaction_history_card.dart';

class HistorySection extends StatefulWidget {
  final User? currentUser;
  const HistorySection({Key? key, required this.currentUser}) : super(key: key);
  @override
  _HistorySectionState createState() => _HistorySectionState();
}

class _HistorySectionState extends State<HistorySection> {
  late String _uid;
  late CollectionReference _transactionsRef;

  @override
  void initState() {
    super.initState();
    _uid = widget.currentUser!.uid;
    _transactionsRef = FirebaseFirestore.instance
        .collection('wallet')
        .doc(_uid)
        .collection('transactions');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.blue,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: const Text(
            'Riwayat Transaksi',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: _transactionsRef.orderBy('date', descending: true).get(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Terjadi kesalahan'),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data!.size == 0) {
                  return const Center(
                    child: Text('Anda belum menambahkan transaksi apapun'),
                  );
                }
                List transactions = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, i) {
                    return TransactionHistoryCard(
                        transaction: TransactionItem.fromJson(
                            transactions[i].data() as Map<String, Object?>));
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        )
      ],
    );
  }
}
