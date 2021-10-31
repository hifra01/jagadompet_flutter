import 'package:flutter/material.dart';
import 'package:jagadompet_flutter/utils/transactions_generator.dart';
import 'package:jagadompet_flutter/widgets/transaction_history_card.dart';

class HistorySection extends StatefulWidget {
  const HistorySection({Key? key}) : super(key: key);

  @override
  _HistorySectionState createState() => _HistorySectionState();
}

class _HistorySectionState extends State<HistorySection> {
  List transactions = TransactionsGenerator.generate();
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
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return TransactionHistoryCard(transaction: transactions[index]);
            },
          ),
        )
      ],
    );
  }
}
