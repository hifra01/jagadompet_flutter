import 'package:flutter/material.dart';
import 'package:jagadompet_flutter/models/transaction_history_item.dart';

class TransactionHistoryCard extends StatelessWidget {
  final TransactionHistoryItem transaction;
  const TransactionHistoryCard({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color priceColor =
    transaction.transactionType == "in" ? Colors.green : Colors.red;
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  transaction.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  (transaction.transactionType == 'in' ? '+' : '-') +
                      'Rp${transaction.amount}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: priceColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4,),
            const Text(
              '26 Oktober 2021',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
