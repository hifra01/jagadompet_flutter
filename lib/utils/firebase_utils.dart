import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jagadompet_flutter/utils/general_utils.dart';

Future<void> userFirstTimeSetup(String fullName, String email) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? currentUser = auth.currentUser;
  String uid = auth.currentUser!.uid.toString();

  DocumentReference profileRef =
      FirebaseFirestore.instance.collection('profile').doc(uid);

  CollectionReference wallet = FirebaseFirestore.instance.collection('wallet');
  DocumentReference userWallet = wallet.doc(uid);

  CollectionReference userCashflows = userWallet.collection('cashflow');

  DateTime now = DateTime.now();
  String year = now.year.toString();
  String month = now.month.toString();
  String cashflowKey = '${year}_$month';

  await currentUser!.updateDisplayName(fullName);
  await profileRef.set({'name': fullName});
  await userWallet.set({
    'amount': 0,
  }, SetOptions(merge: true));
  await userCashflows.doc(cashflowKey).set({
    'in': 0,
    'out': 0,
    'out_food': 0,
    'out_daily': 0,
    'out_education': 0,
    'out_health': 0,
    'out_other': 0,
  }, SetOptions(merge: true));
  return;
}

Future<void> addOutTransaction({
  required String category,
  required String title,
  required int amount,
  required String note,
}) async {
  DateTime now = DateTime.now();
  String yearMonthKey = '${now.year.toString()}_${now.month.toString()}';

  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();

  DocumentReference userWalletRef =
      FirebaseFirestore.instance.collection('wallet').doc(uid);

  DocumentReference thisMonthCashflowRef =
      userWalletRef.collection('cashflow').doc(yearMonthKey);

  CollectionReference transactionsCollectionRef =
      userWalletRef.collection('transactions');

  Map<String, dynamic> userWallet = await userWalletRef
      .get()
      .then((DocumentSnapshot value) => value.data() as Map<String, dynamic>);

  Map<String, dynamic> thisMonthCashflow = await thisMonthCashflowRef
      .get()
      .then((DocumentSnapshot value) => value.data() as Map<String, dynamic>);

  int currentTotal = userWallet['total'] ?? 0;
  int newTotal = currentTotal - amount;

  int currentCashflowOutcome = thisMonthCashflow['outcome'] ?? 0;
  int newCashflowOutcome = currentCashflowOutcome + amount;

  int currentCashflowOnCategory = thisMonthCashflow[category] ?? 0;
  int newCashflowOnCategory = currentCashflowOnCategory + amount;

  await transactionsCollectionRef.add({
    'type': 'out',
    'title': title,
    'amount': amount,
    'category_id': category,
    'category': getCategoryFromCategoryId(category),
    'note': note,
    'date': now,
  });
  await userWalletRef.set(
    {'total': newTotal},
    SetOptions(merge: true),
  );
  await thisMonthCashflowRef.set({
    'outcome': newCashflowOutcome,
    category: newCashflowOnCategory,
  }, SetOptions(merge: true));
}

Future<void> addInTransaction({
  required String source,
  required String title,
  required int amount,
  required String note,
}) async {
  DateTime now = DateTime.now();
  String yearMonthKey = '${now.year.toString()}_${now.month.toString()}';

  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();

  DocumentReference userWalletRef =
      FirebaseFirestore.instance.collection('wallet').doc(uid);

  DocumentReference thisMonthCashflowRef =
      userWalletRef.collection('cashflow').doc(yearMonthKey);

  CollectionReference transactionsCollectionRef =
      userWalletRef.collection('transactions');

  Map<String, dynamic> userWallet = await userWalletRef
      .get()
      .then((DocumentSnapshot value) => value.data() as Map<String, dynamic>);

  Map<String, dynamic> thisMonthCashflow = await thisMonthCashflowRef
      .get()
      .then((DocumentSnapshot value) => value.data() as Map<String, dynamic>);

  int currentTotal = userWallet['total'] ?? 0;
  int newTotal = currentTotal + amount;

  int currentCashflowIncome = thisMonthCashflow['income'] ?? 0;
  int newCashflowIncome = currentCashflowIncome + amount;

  int currentCashflowOnSource = thisMonthCashflow[source] ?? 0;
  int newCashflowOnSource = currentCashflowOnSource + amount;

  await transactionsCollectionRef.add({
    'type': 'in',
    'title': title,
    'amount': amount,
    'source_id': source,
    'source': getSourceFromSourceId(source),
    'note': note,
    'date': now,
  });
  await userWalletRef.set(
    {'total': newTotal},
    SetOptions(merge: true),
  );
  await thisMonthCashflowRef.set({
    'income': newCashflowIncome,
    source: newCashflowOnSource,
  }, SetOptions(merge: true));
}
