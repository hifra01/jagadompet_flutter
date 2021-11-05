import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jagadompet_flutter/utils/firebase_utils.dart';

class AddOutcomePage extends StatefulWidget {
  const AddOutcomePage({Key? key}) : super(key: key);

  @override
  _AddOutcomePageState createState() => _AddOutcomePageState();
}

class _AddOutcomePageState extends State<AddOutcomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _selectedCategory = '';
  late TextEditingController _titleController;
  late TextEditingController _amountController;
  late TextEditingController _noteController;
  bool _isAddOutcomeDisabled = false;

  List<DropdownMenuItem> categoryList() {
    return <DropdownMenuItem>[
      const DropdownMenuItem(
        value: '',
        child: Text('-- Pilih salah satu --'),
        enabled: false,
      ),
      const DropdownMenuItem(
        value: 'out_food',
        child: Text('Makanan & minuman'),
      ),
      const DropdownMenuItem(
        value: 'out_daily',
        child: Text('Kebutuhan sehari-hari'),
      ),
      const DropdownMenuItem(
        value: 'out_education',
        child: Text('Pendidikan'),
      ),
      const DropdownMenuItem(
        value: 'out_health',
        child: Text('Kesehatan'),
      ),
      const DropdownMenuItem(
        value: 'out_other',
        child: Text('Lain-lain'),
      ),
    ];
  }

  void _doAddOutcome() async {
    if (_formKey.currentState!.validate()) {
      _isAddOutcomeDisabled = true;
      String category = _selectedCategory;
      String title = _titleController.value.text;
      int amount = int.parse(_amountController.value.text);
      String note = _noteController.value.text;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Menambah pengeluaran baru...'),
        ),
      );
      try {
        await addOutTransaction(
          category: category,
          title: title,
          amount: amount,
          note: note,
        );

        Navigator.pop(context);
      } on FirebaseException catch (e) {
        _isAddOutcomeDisabled = false;
        String errorMessage = e.message ?? 'Terjadi kesalahan';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _amountController = TextEditingController();
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah pengeluaran baru'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  label: Text(
                    'Kategori*',
                  ),
                ),
                items: categoryList(),
                value: _selectedCategory,
                onChanged: (dynamic value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                onSaved: (dynamic value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                validator: (dynamic value) {
                  if (value.isEmpty) {
                    return 'Kategori tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Nama transaksi*'),
                  helperText: 'Berikan nama yang mudah diingat',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama transaksi tidak boleh kosong';
                  }
                  return null;
                },
                controller: _titleController,
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    label: Text('Nominal*'), prefixText: 'Rp '),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nominal transaksi tidak boleh kosong';
                  }
                  return null;
                },
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  signed: false,
                  decimal: false,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Keterangan'),
                ),
                controller: _noteController,
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isAddOutcomeDisabled ? null : _doAddOutcome,
                  child: _isAddOutcomeDisabled
                      ? const CircularProgressIndicator()
                      : const Text('Tambah pengeluaran'),
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(double.infinity, 48),
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
