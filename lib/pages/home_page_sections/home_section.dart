import 'package:flutter/material.dart';
import 'package:jagadompet_flutter/widgets/in_out_diff_card.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({Key? key}) : super(key: key);

  @override
  _HomeSectionState createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.blue,
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  'Isi dompetmu saat ini',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: const [
                  Text(
                    'Rp',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '12.345.678',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              InOutDiffCard(),
              SizedBox(height: 32,),
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: const [
                    Icon(Icons.account_balance_wallet),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Tambah isi dompet')
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(double.infinity, 48),
                  primary: Colors.green,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: const [
                    Icon(Icons.shopping_cart),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Tambah pengeluaran baru')
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(double.infinity, 48),
                  primary: Colors.red,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
