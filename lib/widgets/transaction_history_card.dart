import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:jagadompet_flutter/models/transaction_item.dart';

class TransactionHistoryCard extends StatelessWidget {
  final TransactionItem transaction;
  const TransactionHistoryCard({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID', null);
    NumberFormat numberFormat = NumberFormat.decimalPattern('id');
    Color priceColor =
    transaction.type == "in" ? Colors.green : Colors.red;
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                    (transaction.type == 'in' ? '+' : '-') +
                        'Rp${numberFormat.format(transaction.amount)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: priceColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4,),
              Text(
                DateFormat.yMMMMd('id_ID').format(transaction.date),
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
