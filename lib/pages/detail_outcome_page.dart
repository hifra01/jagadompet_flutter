import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:jagadompet_flutter/models/transaction_item.dart';
import 'package:jagadompet_flutter/utils/firebase_utils.dart';

class DetailOutcomePage extends StatefulWidget {
  const DetailOutcomePage({Key? key}) : super(key: key);

  @override
  State<DetailOutcomePage> createState() => _DetailOutcomePageState();
}

class _DetailOutcomePageState extends State<DetailOutcomePage> {
  bool _isDeleteDisabled = false;
  late TransactionItem item;

  void _doDeleteItem() async {
    try {
      setState(() {
        _isDeleteDisabled = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Menghapus pengeluaran...'),
        ),
      );
      await deleteOutTransaction(item);
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      setState(() {
        _isDeleteDisabled = false;
      });
      String errorMessage = e.message ?? 'Terjadi kesalahan';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    item = ModalRoute.of(context)!.settings.arguments as TransactionItem;
    initializeDateFormatting('id_ID', null);
    NumberFormat numberFormat = NumberFormat.decimalPattern('id');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pengeluaran'),
      ),
      body: SizedBox.expand(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              const Icon(
                Icons.shopping_cart,
                color: Colors.red,
                size: 36,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Rp${numberFormat.format(item.amount)}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(item.title),
              const SizedBox(
                height: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Detail Transaksi',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Kategori'),
                      Text(item.category.toString()),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Tanggal'),
                      Text(DateFormat.yMMMMd('id_ID')
                          .add_Hms()
                          .format(item.date)),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Keterangan',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(item.note),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              TextButton(
                onPressed: _isDeleteDisabled ? null : _doDeleteItem,
                style: TextButton.styleFrom(primary: Colors.red),
                child: _isDeleteDisabled
                    ? const CircularProgressIndicator()
                    : const Text(
                        'HAPUS ITEM',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
