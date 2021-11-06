import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jagadompet_flutter/utils/firebase_utils.dart';

class AddIncomePage extends StatefulWidget {
  const AddIncomePage({Key? key}) : super(key: key);

  @override
  _AddIncomePageState createState() => _AddIncomePageState();
}

class _AddIncomePageState extends State<AddIncomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _selectedSource = '';
  late TextEditingController _titleController;
  late TextEditingController _amountController;
  late TextEditingController _noteController;
  bool _isAddIncomeDisabled = false;

  List<DropdownMenuItem> sourceList() {
    return <DropdownMenuItem>[
      const DropdownMenuItem(
        value: '',
        child: Text('-- Pilih salah satu --'),
        enabled: false,
      ),
      const DropdownMenuItem(
        value: 'in_salary',
        child: Text('Gaji'),
      ),
      const DropdownMenuItem(
        value: 'in_prize',
        child: Text('Hadiah'),
      ),
      const DropdownMenuItem(
        value: 'in_inheritance',
        child: Text('Warisan'),
      ),
      const DropdownMenuItem(
        value: 'in_investment',
        child: Text('Investasi'),
      ),
      const DropdownMenuItem(
        value: 'in_other',
        child: Text('Lain-lain'),
      ),
    ];
  }

  void _doAddIncome() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isAddIncomeDisabled = true;
      });
      String source = _selectedSource;
      String title = _titleController.value.text;
      int amount = int.parse(_amountController.value.text);
      String note = _noteController.value.text;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Menambah isi dompet...'),
        ),
      );
      try {
        await addInTransaction(
          source: source,
          title: title,
          amount: amount,
          note: note,
        );

        Navigator.pop(context);
      } on FirebaseException catch (e) {
        _isAddIncomeDisabled = false;
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
        title: const Text('Tambah isi dompet'),
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
                    'Sumber*',
                  ),
                ),
                items: sourceList(),
                value: _selectedSource,
                onChanged: (dynamic value) {
                  setState(() {
                    _selectedSource = value;
                  });
                },
                onSaved: (dynamic value) {
                  setState(() {
                    _selectedSource = value;
                  });
                },
                validator: (dynamic value) {
                  if (value.isEmpty) {
                    return 'Sumber tidak boleh kosong';
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
                  onPressed: _isAddIncomeDisabled ? null : _doAddIncome,
                  child: _isAddIncomeDisabled
                      ? const CircularProgressIndicator()
                      : const Text('Tambah isi dompet'),
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
