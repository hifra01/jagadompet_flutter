import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jagadompet_flutter/models/wallet.dart';
import 'package:jagadompet_flutter/widgets/in_out_diff_card.dart';
import 'package:skeleton_text/skeleton_text.dart';

class HomeSection extends StatefulWidget {
  final User? currentUser;
  const HomeSection({Key? key, required this.currentUser}) : super(key: key);

  @override
  _HomeSectionState createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  late DocumentReference userWallet;
  final NumberFormat numberFormat = NumberFormat.decimalPattern('id');

  @override
  void initState() {
    super.initState();
    userWallet = FirebaseFirestore.instance
        .collection('wallet')
        .doc(widget.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userWallet.get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const SizedBox.expand(
            child: Center(
              child: Text('Terjadi kesalahan'),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Wallet data =
              Wallet.fromJson(snapshot.data!.data() as Map<String, Object?>);

          return ListView(
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
                      children: [
                        const Text(
                          'Rp',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 4,),
                        Text(
                          numberFormat.format(data.total),
                          style: const TextStyle(
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
                    InOutDiffCard(
                      userWallet: userWallet,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await Navigator.pushNamed(context, '/addincome');
                        setState(() {});
                      },
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
                      onPressed: () async {
                        await Navigator.pushNamed(context, '/addoutcome');
                        setState(() {});
                      },
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
                    children: [
                      const Text(
                        'Rp',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 4,),
                      SkeletonAnimation(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: 24,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blue[200],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        );
      },
    );
  }
}
