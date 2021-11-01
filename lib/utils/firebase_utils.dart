import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> userFirstTimeSetup(String fullName, String email) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? currentUser = auth.currentUser;
  String uid = auth.currentUser!.uid.toString();

  CollectionReference wallet = FirebaseFirestore.instance.collection('wallet');
  DocumentReference userWallet = wallet.doc(uid);

  CollectionReference userCashflows = userWallet.collection('cashflow');

  DateTime now = DateTime.now();
  String year = now.year.toString();
  String month = now.month.toString();
  String cashflowKey = '${year}_$month';

  Map walletObject = {
    'amount': 0,
  };

  Map cashflowObject = {
    'in': 0,
    'out': 0,
    'out_food': 0,
    'out_daily': 0,
    'out_education': 0,
    'out_health': 0,
    'out_other': 0,
  };

  currentUser!.updateDisplayName(fullName);
  userWallet.set(walletObject, SetOptions(merge: true));
  userCashflows.doc(cashflowKey).set(cashflowObject, SetOptions(merge: true));
  return;
}
